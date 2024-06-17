function [newX,P] = FAGPE(X,cluster_n,dimension,iter,gamma,lambda,k)
% Fast Anchor Graph optimized projections with Principal component analysis and Entropy regularization
    %Input: 
    % @para X denotes the input data
    % @para cluster_n denotes the number of anchors
    % @para dimension denotes the reducted dimensionality
    % @para iter represents the iteration times
    % @para gamma and lambda are two tade-off parameters
    % @para k denotes sparsity of the anchor graph
    
    
    %Output: 
    % newX represents the projected data
    % P respresents the anchor the membership matrix

clear objV;
clear obj;
    mapping.mean = mean(X, 1);
    X = bsxfun(@minus, X, mapping.mean);
    % Compute covariance matrix
    if size(X, 2) < size(X, 1)
        C = cov(X);
    else
        C = (1 / size(X, 1)) * (X * X'); % if N>D, we better use this matrix for the eigendecomposition
    end
        G=chol(C,'lower');
objV=[];
[data_row,data_col] =size(X);
% Initializing P
P=rand(cluster_n,data_row);
[sp,ps]=sort(P,1);
P(ps>k)=0;
col_sum=sum(P);  
P=P./repmat(col_sum,cluster_n,1); 
P=P';
for i=1:iter
    centers = P'*X./(repmat(sum(P',2),1,data_col)); 
    dn=diag(sum(P,1));
    dc=diag(sum(P,2));
    M=(X'*dc*X-2*X'*P*centers+centers'*dn*centers);
    M=M-lambda*C;
    M=(M+M')/2;
    M(find(isnan(M)==1))= 0;
    [W,B] = eig(M);
    B(isnan(B)) = 0;
    [B, ind] = sort(diag(B));
    W = (inv(G))'*W;
    W = W(:,ind(1:dimension));
    sdist =L2_distance_subfun((X*W)',(centers*W)');
    Z=exp(-sdist*gamma);
    ZZ=Z';
    [sp,ps]=sort(ZZ,1);
    Z=ZZ';
    [sp,ps]=sort(ZZ,1);
    ZZ(ps>k)=0;
    col_sum=sum(Z,2); 
    P=Z./repmat(col_sum,1,cluster_n);
    P(isnan(P)) = 1.0/data_col;
    obj=-sum(log(col_sum))/gamma-lambda*trace(W'*C*W);
    objV=[objV,obj];
    if i>2
      if objV(i-1)-objV(i)<10^-5
         break;
      end
    end
end
newX=X*W;
end


