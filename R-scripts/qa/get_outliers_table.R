get_outliers_table <- function(simeval_directory,cdd.data) {
  simeval_files_exist <- file.exists(file.path("simeval_run", "raw_all_iofv.csv"))
  if(simeval_files_exist) {
    iofv_res <- i_ofv_res(file.path(simeval_directory, "raw_all_iofv.csv"),show.warning=F)
    outlier_ids <- iofv_res$outlier_ID
    if(length(outlier_ids)!=0) {
      if(ncol(cdd.data)!=1) {
        outliers_table <- as.data.frame(array(0,c(length(outlier_ids),2)))
        colnames(outliers_table) <- c("Subjects","dofv")
        for(i in 1:length(outlier_ids)) {
          outliers_table[i,1] <- outlier_ids[i]
          outliers_table[i,2] <- ifelse(any(cdd.data$id %in% outlier_ids[i]),cdd.data$dofv[which(cdd.data$id==outlier_ids[i])],NA)
        }
        outliers_table <- outliers_table[order(outliers_table$dofv,decreasing = T),]
        outliers_table$dofv <- round(as.numeric(outliers_table$dofv), 1)
        outliers_table <- outliers_table %>% mutate(Subjects=paste("Subject",Subjects))
        if(!all(is.na(outliers_table$dofv))) {
          max_outlier_table <- outliers_table[which.max(outliers_table$dofv),]
          colnames(max_outlier_table) <- c("","dofv")
        } else {
          max_outlier_table <- data.frame("SIMEVAL","No dofv values found")
          colnames(max_outlier_table) <- c("","dofv")
        }
      } else {
        outliers_table <- data.frame("Subjects"=outlier_ids,"dofv"=rep("ERROR",length(outlier_ids)))
        max_outlier_table <- error_table("SIMEVAL")
      }
    } else {
      outliers_table <- data.frame(c("No outliers detected"))
      colnames(outliers_table) <- ""
      max_outlier_table <- data.frame(c("No outliers detected",""))
      colnames(outliers_table) <- c("","dofv")
    }
    
  } else {
    outliers_table <- error_table(col=1)
    max_outlier_table <- error_table("SIMEVAL")
  }
  
  return(list(simeval_files_exist=simeval_files_exist,
              outliers_table=outliers_table,
              max_outlier_table=max_outlier_table))
}