hc <- function(X, K, method){
    # load dataset
    source('distc.r')
    # create clusters distance matrix, make zero be NA
    XDistMat <- as.matrix(dist(X))
    XDistMat[XDistMat==0] <- NA
    #XDistMat[upper.tri(XDistMat)] <- NA 
    # create list, store all end-nodes of every cluster
    Clu <- list()
    for (item in 1:nrow(X)) {Clu[[item]] <- item}
    # abandon1: #create list store the child nodes of every cluster
    # abandon1: Clu2 <- list()
    # abandon1: for (item in 1:nrow(X)) {Clu2[[item]] <- item}
    # create vector store the status if the node has been referred by upper node 
    status <- c(rep(1,nrow(X)))
    # create initial cluster distance matrix
    CluDistMat <- matrix(NA,2*nrow(X)-K,2*nrow(X)-K)
    CluDistMat[1:nrow(XDistMat),1:ncol(XDistMat)] <- XDistMat
    fmCluDistMat <- CluDistMat
    for (item in 1:(nrow(X)-K)) {
        # find the subscript of minimum cluster distance
        minClu <- which(fmCluDistMat==min(fmCluDistMat, na.rm=TRUE), arr.ind=T)
        # update cluster list
        Clu[[nrow(X)+item]] <- c(Clu[[minClu[nrow(minClu),1]]],Clu[[minClu[nrow(minClu),2]]])  
        # abandon1: Clu2[[nrow(X)+item]] <- as.numeric(minClu[nrow(minClu),])
        # update the status
        status[minClu[nrow(minClu),]] <- 0
        status[nrow(X)+item] <- 1
        # call distc function, merge clusters and update ClusterDistanceMatrix
        CluDistMat <- distc(X, CluDistMat, Clu, method)  
        # delete the clusters which has been merged
        fmCluDistMat[minClu[nrow(minClu),],] <- NA
        fmCluDistMat[,minClu[nrow(minClu),]] <- NA
        fmCluDistMat[(nrow(X)+item),1:(nrow(X)+item)] <- CluDistMat[(nrow(X)+item),1:(nrow(X)+item)]
        fmCluDistMat[1:(nrow(X)+item),(nrow(X)+item)] <- CluDistMat[1:(nrow(X)+item),(nrow(X)+item)]
    }
    # the final K clusters which status equal to 1
    finClu <- Clu[status==1]
    finClu1 <- c()
    for (item in 1:length(finClu)) finClu1[finClu[[item]]] <- item
    cat('The Cluster Number of each observation:\n',finClu1,'\n')
    return(list(finClu1, finClu))
    
}
