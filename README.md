## Hierarchical Aggromerative Clustering
===    

### 1. Call function by 
> hc(dataset, K, method)      

This function will print the cluster number of each observation, and return a list which contain 1. the cluster number of each observation; 2. the observations of each cluster. And the result also depend on the value of K.		

### 2. Apply NCI microarray data set with preprocess     
> nci <- read.table('nci.data')     
> nci <- t(nci)     
> label <- read.table('label.txt')            
> K <- nrow(unique(label))                # K = 14

### 3. Fit Hierarchical Aggromerative Clustering with different linkage function     
Hierarchical clustering has the distinct advantage that any valid measure of distance can be used. Different linkage have different strengthen in special case.
#### 3.1 with complete linkage		
The distance between two culsters is considered by the minimunm distance between each observation of two clusters.
> Cluster.single <- hc(nci, K, 'single')        
 [1]  1  1  1  1  2  1  1  3  1  4  1  1  1  1  1  1  1  5  6  7  1  1  1  1  1  1  1       
[28]  1  1  1  1  1  1  8  9  9  9 10 11 11 12  1  1  1  1  1  1  1  1  1  1  1  1  1       
[55] 13 14 14 14 14 14 14 14 14 14      

#### 3.2 with complete linkage       
The distance between two culsters is considered by the maximunm distance between each observation of two clusters.
> Cluster.complete <- hc(nci, K, 'complete')        
 [1]  1  1  2  3  3  1  1  1  2  4  2  2  2  2  2  2  2  5  5  6  6  6  2  2  7  7  2       
[28]  2  2  2  2  2  2  8  8  8  8  8  9  9 10 11 11 11 11 11 11 11 12 12 12 12  2 13       
[55] 13 14 14 14 14 14 14 14 14 14      

#### 3.3 with average linkage        
The distance between two culsters is considered by the average distance between each observation of two clusters.
> Cluster.average <- hc(nci, K, 'average')      
 [1]  1  1  1  1  2  1  1  1  1  3  1  1  1  1  1  1  1  4  4  5  1  1  1  1  6  6  1       
[28]  1  1  1  1  1  1  7  8  8  8  7  9  9 10 11 11 11 11 11 11 11 12 12 12 12  1 13       
[55] 13 14 14 14 14 14 14 14 14 14      

#### 3.4 with centroid linkage      
The distance between two culsters is considered by the centroid distance between each observation of two clusters. 
> Cluster.centroid <- hc(nci, K, 'centroid')        
 [1]  1  1  1  2  3  1  1  1  1  4  1  1  1  1  1  1  1  5  1  6  1  1  1  1  1  1  1       
[28]  1  1  1  1  1  1  1  1  1  1  7  8  9 10  1  1  1  1  1 11  1  1  1  1 12  1  1       
[55] 13 14  1  1  1  1  1  1  1  1      

### 4. apply k-means     
The result of k-means base on a global view with considered by every observation. The result in this case is look familiar to true label.

> km.out=kmeans(nci,K,nstart=20)        
> as.vector(km.out$cluster)     
 [1]  5  5  8  8  8  8  8  8 14 14  6  6  6  6  6  6  6  1  1 14 14 14 14 10 13 13 13       
[28] 13 10 10 10 10 10  7  2  2  2  7  4  4  7 10 12 12 12 12 12 12  9  9  9  9 10 11       
[55] 11  3  3  3  3  3  3  3  3  3      

### 5. Compare K-means and Hierarchical cluster  
In one hand, K-means algorithm finds a local rather than a global optimum, the results obtained will depend on the initial cluster assignment of each observation. In other hand, Hierarchical Clustering can give diﬀerent partitionings depending on the level-of-resolution we are looking at. So it will cause different result. Hiereachical cluster would indicate more information about the level according to distance, but it's much slower than K-means.

### 6. (Optional)Discuss how to choose K
If the dimension is not greater than 3, we could plot the dataset with different K and find the best value of K.
If the dimension is greater than 3, we could use Gap statistic or derease the dimension to 2, then plot it with different K and find the best K.
