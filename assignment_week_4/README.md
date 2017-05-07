# Cleaning Data - Assignment

## Overview
The following actions are performed by the R script run_analysis.R

1.  Download the dataset
2.  Load the subject, activity and measurement data for training
3.  Load the subject, activity and measurement data for testing
4.  Combine the subject and activity data
5.  Rename the subject and activity columns
6.  Assign the column names dynamically using the features.txt file
7.  Remove duplicate columns that are not required
8.  Use regular expressions to expand the abbreviated names in the existing column names
9.  Modify the activity column to use names instead of numeric values
10. Aggregate the data to calculate the mean
11. Write the data out to a file called tidy.txt


## Assumptions

working directory means the current directory where run_analysis.R is executed and all required files are in that directory
    
    
    subject_train.txt
    
    y_train.txt
    
    X_train.txt
    
    subject_test.txt
    
    y_test.txt
    
    X_test.txt
    
    features.txt
    
 
