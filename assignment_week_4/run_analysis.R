## assumptions:
## working directory means the current directory and all required files are in that directory
##    .
##    ./subject_train.txt
##    ./y_train.txt
##    ./X_train.txt
##    ./subject_test.txt
##    ./y_test.txt
##    ./X_test.txt
##    ./features.txt
## 

assignment_4 <- function(){
  
  library(dplyr)
  
  # step 1, merging of data sets
  
  ### Train Data ###
  
  trainSubject <- read.table("./subject_train.txt")

  trainActivity <- read.table("./y_train.txt")

  trainData <- read.table(file = "./X_train.txt", header = FALSE)


  ### Test Data ###

  testSubject <- read.table("./subject_test.txt")

  testActivity <- read.table("./y_test.txt")

  testData <- read.table(file = "./X_test.txt", header = FALSE)

  ### Combine Data and Change the Variable Names ###

  combinedSubject <- rbind(trainSubject,testSubject)

  colnames(combinedSubject) <- c("Subject")

  combinedActivity <- rbind(trainActivity,testActivity)

  colnames(combinedActivity) <- c("Activity")

  combinedData <- rbind(trainData,testData)

  ## assign the original column names from features.txt

  originalColumnNames <- read.table("./features.txt")
  
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
  
  # write.table(AllVariablesDataFrame,file="./data/tidy.txt",row.name=FALSE)
  
}
