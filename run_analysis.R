#############################################################################
######                Cleaning the Samsung dataset                    #######
#############################################################################

# Load libraries

library(tidyr)
library(dplyr)
library(reshape2)


# Download data

setwd("C:/Users/Izel/Dropbox/Courses/Coursera/Getting and Cleaning data/Week 4/Assignment")
list.files()
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, dest="mydataset.zip") 
unzip("mydataset.zip")
list.files()          # compare to earlier list.files() to determine which file was added to the existing directory
list.files("./UCI HAR Dataset")
list.files("./UCI HAR Dataset/train")
list.files("./UCI HAR Dataset/test")

dateDownloaded <- date()


# Read data
## Read train data

setwd("C:/Users/Izel/Dropbox/Courses/Coursera/Getting and Cleaning data/Week 4/Assignment/UCI HAR Dataset")

train_set <- read.table("./train/X_train.txt")
train_subject <- read.table("./train/subject_train.txt") #identifies participant
train_labl <- read.table("./train/y_train.txt")


## Read test data

test_set <- read.table("./test/X_test.txt")
test_subject <- read.table("./test/subject_test.txt")
test_labl <- read.table("./test/y_test.txt")


## Read other data

act_labl <- read.table("activity_labels.txt")
features <- read.table("features.txt")


# Edit data

## Add column names to train and test data

colnames(train_set) <- features[,2]
colnames(test_set)  <- features[,2]
colnames(act_labl) <- c("activityID", "activity") #colnames for act_labl data frame


## Add activity ID column to training and test data set

colnames(train_labl) <- "activityID"
colnames(test_labl) <- "activityID"
train_set1 <- cbind(train_labl, train_set)
test_set1 <- cbind(test_labl, test_set)


## Add subject column to training and test data set

head(test_subject)
colnames(train_subject) <- "subject"
colnames(test_subject) <- "subject"
train_set2 <- cbind(train_subject, train_set1)
test_set2 <- cbind(test_subject, test_set1)


## Merge train and test data

dataset <- rbind(train_set2,test_set2)
dim(dataset)


## Keep only feature columns from the dataset that contain mean() or std()
 # Choose not to include meanFreq variable.

 # grep "mean()-" and "std()-" to exclude columns not containg X, Y and Z
mean <- grep("mean()-", colnames(dataset), fixed=TRUE)  
std <- grep("std()-", colnames(dataset), fixed=TRUE)

columns_mean <- dataset[,mean]
columns_std <- dataset[,std]
columns_subject_activityID <- dataset[,1:2]

dataset1 <- cbind(columns_subject_activityID, columns_mean, columns_std)


## Separate the variable columns into "feature" (tBodyAcc etc.), "statistic" (mean or std) and "axis" (X, Y or Z). Use tidyr package.

# This involves two steps:
 #  1. Use gather() to stack columns of dataset1

res <- gather(dataset1, feature_statistic_axis, value, -subject, -activityID)

 # 2. Call separate() on res to split the variable column into feature, statistic and axis columns.

  # The different classes/variables of this column are separated by "-". Define the separator as "-" in the call.
df <- separate(res, feature_statistic_axis, c("feature", "statistic", "axis"), sep="-")
  # remove "()" from the contents of the "statistic" column
df$statistic <- gsub("()", "", df$statistic, fixed=TRUE)


## Add a column with activities (WALKING etc) that correspond to the activity ID.

activity <- tolower(act_labl$activity)
activity
activity[df$activityID]
df$activity <- activity[df$activityID]

#Check to see if activity values correspond to activityID
table(df$activity)
table(df$activityID)
# Change order of columns
df <- df[,c(1,2,7,3,4,5,6)]
head(df)


# Analysis

tbldf <-tbl_df(df) # Convert df to a tibble data frame.


## Determine average of each subject for each activity, feature, statistic and axis

group_subject <- group_by(tbldf, subject, activity, feature, statistic, axis)
new_data <- summarise(group_subject, mean=mean(value))

setwd("C:/Users/Izel/Dropbox/Courses/Coursera/Getting and Cleaning data/Week 4/Assignment")
write.table(new_data, file = "new_data.txt", row.names=FALSE)


