# load dataset
nci <- read.table('nci.data')
nci <- t(nci)
label <- read.table('label.txt')
K <- nrow(unique(label))                # K = 14

### These for test, non-sense
set.seed(2)                                                                                                                                                           
x <- matrix(rnorm(50*3),ncol=3)
x[1:25,1] <- x[1:25,1]+3
x[1:25,2] <- x[1:25,2]-4
Cluster.single <- hc(x, 2, 'single')
###

# apply hierarchical agglomerative clustering
source('hc.r')
# with single linkage
Cluster.single <- hc(nci, K, 'single')
# with complete linkage
Cluster.complete <- hc(nci, K, 'complete')
# with average linkage
Cluster.average <- hc(nci, K, 'average')
# with centroid linkage
Cluster.centroid <- hc(nci, K, 'centroid')

# apply k-means
set.seed(0506)
km.out=kmeans(nci,K,nstart=20)
as.vector(km.out$cluster)

