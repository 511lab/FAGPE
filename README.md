# FAGPE
#Fast Anchor Graph Optimized Projections with Principal Component Analysis and Entropy Regularization

We provide the codes and the datasets.

Abstract：Traditional machine learning algorithms often fail when dealing with high dimensional data, called “curse of dimensionality”. In order to solve this problem, many dimensionality reduction algorithms have been proposed. Adjacency graph-based dimensionality reduction algorithms, which are currently a focus of research, have high time complexity of O(n 2 d), where n represents the number of samples, and d represents the number of features. On the other hand, these methods do not consider the global data information. To solve the above two problems, we propose a novel method named Fast Anchor Graph optimized projections with Principal component analysis and Entropy regularization (FAGPE), which integrates anchor graph, entropy regularization term, and Principal Component Analysis (PCA). In the proposed model, the anchor graph with sparse constraint captures the cluster information of the data, while the embedded Principal Component Analysis takes into account the global data information. This paper introduces a novel iterative optimization approach to address the proposed model. In general, the time complexity of our proposed
algorithm is O(nmd), with m representing the number of anchors. Finally, the All the codes and data sets can be found on website https://github.com/511lab/FAGPE.

# Set up
## Requirements
 All experiments were conducted on Windows10 computer with 4.5GHz Intel Core I9 10850K CPU and 32-GB RAM. 
All the codes are implemented with  MATLAB 2021a. 

In order to keep consistent with the comparison algorithms, the 1NN classification is chosen as the base classifier. The operating parameters of the 1NN classification are as follows: Euclidean distance is used to calculate the intersample distance, and the number of sample nearest neighbors is taken as 1. When the number of columns of X does not exceed 10, the nearest neighbor search method is the KD-tree search algorithm. The maximum number of data points in the leaf node of the kdtree is 50. We set the weights of each sample to be the same, and each sample is assigned to the class closest to it.

# Datasets
You can also download the datasets from [dataset](https://github.com/511lab/FAGPE/dataset)

# Codes  
Source Codes on Matlab are available at, [code](https://github.com/511lab/FAGPE/code)

1.main.m #The main function of Classification performance.

2.L2_distance_subfun.m  #The  function that calculates the distance between samples.

3.FAGPE.m #The function of our proposed FAGPE algorithm.

5.Random_sampling.m  #The function of the Stratified sampling of the Classification performance.

# Contact: 
For any problem about this dataset or codes, please contact Dr. Wang (wjkweb@163.com).
