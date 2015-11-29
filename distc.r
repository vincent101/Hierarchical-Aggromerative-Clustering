distc <- function(X, CluDistMat, Clu, method){
    # total number of Clu
    CluNum <- length(Clu)
    # value of lasted Clu
    newClu <- Clu[[length(Clu)]]
    # check method if single
    if(method == 'single'){
        # loop all cluster except lasted one
        for (i in c(1:(CluNum-1))[-newClu]) {
            tmp <- c()
            tmp.c <- 1
            # loop content of cluters
            for (j in Clu[[i]]) {
                # loop content of lasted cluster
                for (k in newClu) {
                    tmp[tmp.c] <- CluDistMat[j,k]
                    tmp.c <- tmp.c+1
                }
            }
            # find the minimum distance between two cluster
            CluDistMat[CluNum,i] <- min(tmp)
            CluDistMat[i,CluNum] <- min(tmp)
        }
        return(CluDistMat)
    }
    if(method == 'complete'){
        # loop all cluster except lasted one
        for (i in c(1:(CluNum-1))[-newClu]) {
            tmp <- c()
            tmp.c <- 1
            # loop content of cluters
            for (j in Clu[[i]]) {
                # loop content of lasted cluster
                for (k in newClu) {
                    tmp[tmp.c] <- CluDistMat[j,k]
                    tmp.c <- tmp.c+1
                }
            }
            # find the maximum distance between two cluster
            CluDistMat[CluNum,i] <- max(tmp)
            CluDistMat[i,CluNum] <- max(tmp)
        }
        return(CluDistMat)
    }
    if(method == 'average'){
        # loop all cluster except lasted one
        for (i in c(1:(CluNum-1))[-newClu]) {
            tmp <- c()
            tmp.c <- 1
            # loop content of cluters
            for (j in Clu[[i]]) {
                # loop content of lasted cluster
                for (k in newClu) {
                    tmp[tmp.c] <- CluDistMat[j,k]
                    tmp.c <- tmp.c+1
                }
            }
            # find the maximum distance between two cluster
            CluDistMat[CluNum,i] <- sum(tmp)/(length(Clu[[i]])*length(newClu))
            CluDistMat[i,CluNum] <- sum(tmp)/(length(Clu[[i]])*length(newClu))
        }
        return(CluDistMat)
    }
    if(method == 'centroid'){
        # loop all cluster except lasted one
        for (i in c(1:(CluNum-1))[-newClu]) {
            # find the maximum distance between two cluster
            CluDistMat[CluNum,i] <- abs(mean(X[Clu[[i]],])-mean(X[newClu,]))
            CluDistMat[i,CluNum] <- abs(mean(X[Clu[[i]],])-mean(X[newClu,]))
        }
        return(CluDistMat)
    }
    
}
