######################################################
## Import and merge training sets
######################################################

## Step 0: Load packages
if(!("data.table" %in% installed.packages())) install.packages("data.table")
library(data.table)

## Step 1: Import sets

UCI.features <- fread("./UCI HAR Dataset/features.txt")
names(UCI.features) <- c("ColNum","Measurement")
UCI.actlab <- fread("./UCI HAR Dataset/activity_labels.txt")
names(UCI.actlab) <- c("TaskNum","Activity")

getUCIdata <- function(tt,path="./UCI HAR Dataset/") {
 
  # read data tables
  UCI.subj <- fread(paste(path,tt,"/subject_",tt,".txt",sep=""))
  UCI.task <- fread(paste(path,tt,"/y_",tt,".txt",sep=""))
  UCI.data <- fread(paste(path,tt,"/X_",tt,".txt",sep=""))
  
  # attach additional details
  names(UCI.data) <- UCI.features$Measurement
  UCI.data$Subject <- UCI.subj
  UCI.data$TaskNum <- UCI.task
  UCI.data$Type <- tt

  # remove duplicate columns and return
  dupnames <- duplicated(names(UCI.data))
  UCI.data[,!dupnames,with=FALSE]
}

# get test and train data
UCI.test <- getUCIdata("test")
UCI.train  <- getUCIdata("train")

# join data sets
UCI.full <- rbind(UCI.test,UCI.train)

## Step 2:  Extract mean and standard deviation
keeplist <- UCI.features[grepl("mean|std",UCI.features$Measurement)]$Measurement
UCI.meanstd <- UCI.full[,c("Subject","TaskNum","Type",keeplist),with=FALSE]

## Step 3: Attach activity labels
UCI.labeled <- merge(UCI.meanstd,UCI.actlab)

## Step 4: Clean up names
names(UCI.labeled) <- gsub("mean","Mean",names(UCI.labeled))
names(UCI.labeled) <- gsub("std","StandardDeviation",names(UCI.labeled))
names(UCI.labeled) <- gsub("\\(\\)","",names(UCI.labeled))

## Step 5: Create tidy dataset with average of each variable by subject and activity
numfields <- grep("Mean|StandardDeviation",names(UCI.labeled),value =TRUE)
UCI.finaltidy <- UCI.labeled[,lapply(.SD,mean),.SDcols=numfields,by=.(Subject,Activity)]
UCI.finaltidy <- UCI.finaltidy[order(Subject,Activity)]
write.table(UCI.finaltidy,file="FinalTidyWeek4.txt",row.names = FALSE)
