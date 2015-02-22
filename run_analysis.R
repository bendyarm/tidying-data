# Script: run_analysis.R
# Revision: v1
# Author: Bendyarm
# Date: 2015-02-22
# Purpose: Course Project for Coursera JHU Getting and Cleaning Data
# ( https://class.coursera.org/getdata-011 )

# To Run This Script
# ------------------
#
# 1. Check the README.md in this file's directory for setup information,
#    including information on the tested configuration.
# 2. Connect to the "UCI HAR Dataset" directory/folder,
#    either in a shell/Terminal window or in an R Console using the setwd() command.
# 3. Run this script.
#    If you are in an R console, do:
#        source("/path-to-this-file/run_analysis.R")
#    If you are in a shell/Terminal window, run
#        Rscript /path-to-this-file/run_analysis.R

# Input and Output Files
# ----------------------
# Input and output files are documented in the README.md.
# The output file name is:
#    tidy_activity_recog_data.txt
# and it will be written to the working directory as setup in step 2 above.
# See the file CodeBook.md in this script's directory for information
# about the content of the output file.


# From the course instructions:
# You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


# --------
# 0. Presume that the current directory when running this script is the "UCI HAR Dataset" directory.

# setwd("/Users/---/courses/getting_data/project/UCI HAR Dataset")


# --------
# 1. Merges the training and the test sets to create one data set.

# no headers, default separator of whitespace
mytrainDF <- read.table("./train/X_train.txt")
mytestDF <- read.table("./test/X_test.txt")
myDF <- rbind(mytrainDF, mytestDF)


# --------
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

# From features.txt, there are 561 "features".
# There are 56 occurrences of the word "mean".  
# 33 are "mean()".  13 are meanFreq().  10 other occurrences of "Mean", 
# some twice, all in the last 7 features.
# I think meanFreq() is not much like mean(), it is more similar to the 
# other features near it in the list.
# I think it makes more sense to just extract the 33 with mean() 
# and the 33 with std(), for a total of 66 features.

# First read in the features file.
featuresDF <- read.table("./features.txt")

# find the indices of the features we want to keep
mean_indices <- grep("mean()", featuresDF[,2], fixed=TRUE)
std_indices <- grep("std()", featuresDF[,2], fixed=TRUE)
both_indices <- sort(c(mean_indices,std_indices))
mean_and_std_featuresDF <- featuresDF[both_indices,]

# Now, mean_and_std_featuresDF[,1] is the list of column indexes
# we want to extract, and mean_and_std_featuresDF[,2] is the column names.
myDF2 <- myDF[ , mean_and_std_featuresDF[,1]]
colnames(myDF2) <- mean_and_std_featuresDF[,2]

# --------
# 3. Uses descriptive activity names to name the activities in the data set

# Although it was not clear to me from the instructions, I think it is easier
# to add the activity number column and subject column *before* changing
# the activity numbers to activity labels.  This is because the merge()
# function reorders the rows, and merge() is the most straightforward way
# to change the activity numbers to labels.

# Read subject data files and make a data frame
train_subjects <- read.table("./train/subject_train.txt")
test_subjects <- read.table("./test/subject_test.txt")
both_subjects <- rbind(train_subjects, test_subjects)
colnames(both_subjects) <- "subject_num"
# add the subject data as a column in DF2
myDF2 <- cbind(myDF2, both_subjects)

# Read activity data files and make a data frame
train_activities <- read.table("./train/y_train.txt")
test_activities <- read.table("./test/y_test.txt")
both_activities <- rbind(train_activities, test_activities)
colnames(both_activities) <- "activity_num"
# add the activity data as a column in DF2
myDF2 <- cbind(myDF2, both_activities)

# Read activity labels
activity_labels <- read.table("./activity_labels.txt")
colnames(activity_labels) <- c("activity_num", "activity_name")

# Add activity labels
# Note, merge reorders rows, but that is OK since we have everything
# we want in the rows and they get rearranged by grouping later on.
myDF2 <- merge(x=myDF2, y=activity_labels, on="activity_num", x.all=TRUE)

# Remove the activity_num column
myDF2$activity_num <- NULL


# --------
# I found some of the above reshaping stuff annoyingly clunky, so I decided to use dplyr for the rest.
library(dplyr)


# --------
# 4. Appropriately labels the data set with descriptive variable names. 

# I already did this.  The community TA discussion indicates that
# this step is to replace names like V1 with the names from features.txt
# but it seemed more natural to set the colnames at the end of step 2.


# --------
# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.

DF3 <- group_by(myDF2, subject_num, activity_name)
# summarise_each does not modify the grouping variables but summarizes all the other columns
DF4 <- summarise_each(DF3, funs(mean))


# --------
# (6.) Write out the resulting data frame.
# From the instructions:
# Please upload your data set as a txt file created with write.table() using row.name=FALSE

# Note, this does write a header line with the column names.
write.table(DF4, "tidy_activity_recog_data.txt", row.name=FALSE)


