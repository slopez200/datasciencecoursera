assignment_4 <- function(){
  
  library(dplyr)
  
  # step 1, merging of data sets
  
  ### Train Data ###
  
  trainSubject <- read.table("./data/ass_data/UCI HAR Dataset/train/subject_train.txt")

  trainActivity <- read.table("./data/ass_data/UCI HAR Dataset/train/y_train.txt")

  trainData <- read.table(file = "./data/ass_data/UCI HAR Dataset/train/X_train.txt", header = FALSE)


  ### Test Data ###

  testSubject <- read.table("./data/ass_data/UCI HAR Dataset/test/subject_test.txt")

  testActivity <- read.table("./data/ass_data/UCI HAR Dataset/test/y_test.txt")

  testData <- read.table(file = "./data/ass_data/UCI HAR Dataset/test/X_test.txt", header = FALSE)

  ### Combine Data and Change the Variable Names ###

  combinedSubject <- rbind(trainSubject,testSubject)

  colnames(combinedSubject) <- c("Subject")

  combinedActivity <- rbind(trainActivity,testActivity)

  colnames(combinedActivity) <- c("Activity")

  combinedData <- rbind(trainData,testData)

  ## assign the original column names from features.txt

  originalColumnNames <- read.table("./data/ass_data/UCI HAR Dataset/features.txt")
  
  originalColumnNames <- originalColumnNames[,2]
  
  colnames(combinedData) <- originalColumnNames
   
  ## clean up the data by removing duplicates ##
   
  combinedData <- combinedData[ !duplicated(names(combinedData)) ]
  
  newDataFrame <- select(combinedData,contains("mean()"),contains("std()"))
  
  ## use regular expressions to make the names easier to understand ##

  newNames <- names(newDataFrame)
  
  newNames <- sub("^t","time",newNames)
  newNames <- sub("^f","fourier",newNames)
  newNames <- sub("Acc","Accelaration",newNames)
  newNames <- sub("Mag","Magnitude",newNames)
  newNames <- sub("mean\\(\\)","Mean",newNames)
  newNames <- sub("std\\(\\)","StandardDeviation",newNames)
  
  colnames(newDataFrame) <- newNames
  
  
  ## assign the subject and activity column to the frame

  AllVariablesDataFrame <- data.frame(combinedSubject,combinedActivity,newDataFrame)

  AllVariablesDataFrame$Activity <- factor(AllVariablesDataFrame$Activity,
                      levels = c(1,2,3,4,5,6),
                      labels = c("Walking", "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying"))


  # aggregate the data to create a smaller tidy set
  
  ag <- aggregate(. ~ Subject + Activity, AllVariablesDataFrame, mean)
  
  # write the new data out to a file
  
  write.table(AllVariablesDataFrame,file="./tidy.txt",row.name=FALSE)
  
  
}
