# Assignment: Getting and Cleaning Data
This is my Week 4 assignment for the Coursera course Getting and Cleaning Data.

### How my script works
I submitted an R script file: `Assignment submission.Rmd` 
The script consists of the following components  

1. **Download** data.  
   + download the zipped file to the chosen working directory and unzip the file.  

2. **Read** data.  
   + read the training and test datasets, and the training label for each observation in the training and test datasets. 
   + read the features which are the variable names for the training and test data
   + read the activities (`act_labl`) that correspond to the `test_labl` and `train_labl`. The `test_labl` and `train_labl` data is used as activityID and the `act_labl` is used as activity in the final data frame.  

3. **Edit** data. 
+ 
4. **Analyze** data.  

A description of how the data is edited and anlysed is described in my CodeBook document.

This is the course project for the Getting and Cleaning Data Coursera course. The R script, run_analysis.R, does the following:
Download the dataset if it does not already exist in the working directory
Load the activity and feature info
Loads both the training and test datasets, keeping only those columns which reflect a mean or standard deviation
Loads the activity and subject data for each dataset, and merges those columns with the dataset
Merges the two datasets
Converts the activity and subject columns into factors
Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.
The end result is shown in the file tidy.txt.
