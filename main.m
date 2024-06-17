clc;
clear;
% Test on Glass data set.
datasets_name={'Glass'};
% Use the following script to test on all the fourteen benchmark data sets.
% datasets_name={'AR','Yeast','YaleB','umist','PIE_32x32','Heart','Glass','German','FERET32x32','COIL20','Cleve','Banknote','Balance','Australian'};
tools_name={'FAGPE'};
for ds=1:length(datasets_name)
    dataset=datasets_name{ds};
    file=strcat('..\dataset\',dataset,'.mat');
    load(file);
    for drt=1:length(tools_name)
        tool=tools_name{drt};
        filename=strcat('results\',dataset,"_",tool,".xlsx");
        if exist(filename,'file')
            disp("disp");
            continue;
        end
        class=length(unique(Y));
        if size(X,2)>100
            data=pca(X,100);
            [n,d]=size(data);
            strat_dim=10;
            step=10;
            end_dim=100;
        else
            data=X;
            [n,d]=size(data);
            strat_dim=1;
            step=1;
            end_dim=d;
        end
        result=[];
        for dim=strat_dim:step:end_dim
            dim
            % Sampling ratio
            sampRate=20;
            measureCount=20;
            if strcmp(tool,"FAGPE")
                iter=1;
                a=ceil(n/10);
                b=ceil(n/5);
                step1=ceil(max(1,(b-a)/5));
                for cluster_n=a:step1:b
                    step2=ceil(max(1,(cluster_n-1)/5));
                    for k=1:step2:cluster_n
                        for lambda=[0.001 0.1 1 10 100 1000] % 1000000
                            for gamma=[0.001 0.1 1 10 100 1000]
                                % 0.0000000001 0.000001 0.0001 0.01 1 10 1000
                                starttime=cputime;
                                [newX,P] = FAGPE(data,cluster_n,dim,iter,gamma,lambda,k);
                                runtime=cputime-starttime;
                                dr_data=real(newX);
                                [mean_measure,std_measure]=measure(dr_data,Y,sampRate,measureCount);
                                result=[result;mean_measure,dim,k,lambda,cluster_n,gamma,runtime,std_measure];
                            end
                        end
                     end
                 end
             end
         end
        if exist(filename,'file')
            delete(filename)
        end
        xlswrite(filename,result)
    end
end
disp("Parameters are saved...")