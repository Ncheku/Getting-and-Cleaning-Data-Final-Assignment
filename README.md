# Getting-and-Cleaning-Data-Final-Assignment

This file describes how the R script works to accomplish the goals of the final assignment of Getting and Cleaning Data Course from Johns Hopkins University via Coursera.

1 - The zip file containing the Human Activity Recognition Using Smartphones Data Set is downloaded from the website: "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

2 - The zip file is extracted to the folder "./data", where . represents the current working directory.

3 - The activity labels and features are read from the "./data/UCI HAR Dataset/" folder (as described in the README.txt file of the Data Set)

4 - The train sets are read from the "./data/UCI HAR Dataset/train/" folder.

5 - The test sets are read from the "./data/UCI HAR Dataset/test/" folder.

6 - The train and tests data sets are merged together, with their own subjects and activities.

7 - The names of the variables are set for the merged data set, so they are now descriptive.

8 - Only the measurements on the mean and standard deviation are extracted.

9 - Finally, a tidy data set is written to a .txt file.
