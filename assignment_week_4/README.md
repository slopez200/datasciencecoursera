# Cleaning Data - Assignment

## Overview
The following actions are performed by the R script run_analysis.R

Download the dataset

Load the subject, activity and measurement data for training

Load the subject, activity and measurement data for testing

Combine the subject and activity data

Rename the subject and activity columns

Assign the column names dynamically using the features.txt file

Remove duplicate columns that are not required

Use regular expressions to expand the abbreviated names in the existing column names

Modify the activity column to use names instead of numeric values

Aggregate the data to calculate the mean

Write the data out to a file called tidy.txt


## Assumptions

working directory means the current directory and all required files are in that directory
    .
    
    ./subject_train.txt
    
    ./y_train.txt
    
    ./X_train.txt
    
    ./subject_test.txt
    
    ./y_test.txt
    
    ./X_test.txt
    
    ./features.txt
    
 
