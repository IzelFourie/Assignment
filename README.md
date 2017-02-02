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
   + Add column names to the train and test data, from `features`.  
   + Add an activity Id column (from `train_labl`and `test_labl`) to the training and test data set  
   + Add a subject column to the training and test data set obtained from `train_subject` and `test_subject`  
   + Merge the training and test data set to create `dataset`  
   + Keep only feature columns from `dataset` that contain mean() or std()
   + Create `dataset1` with selected feature columns, subject and activityID columns
   + Separate the feature (variable) columns in `dataset1` into features that I thought each should be a variable. Clean data consists of only one variable per column. I considered for example "tBodyAcc" as a `feature`, the mean or std as a `statistic` and X, Y, Z each  as a different `axis`. The data frame containing subject, activityID, feature, statistic and axis is called `df`.  
   + To `df` add a column containing the activities such as walking etc.  
4. **Analyze** data.  
   + Creates a tidy dataset containing the average (mean) value for each variable, for each subject and each activity.  
   + The end result is shown in the file `new_data.csv`.
