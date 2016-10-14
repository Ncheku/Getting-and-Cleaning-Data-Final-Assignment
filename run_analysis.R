#Assignment dataset download
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, "./data/galaxySacc.zip")

#Unzip the compressed file to the folder UCI HAR Dataset
unzip("./data/galaxySacc.zip", exdir = "./data")

#Using readme.txt and features_info.txt to identify the purpose of each data set.

#Read activity labels and features
activityLabels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
features <- read.table("./data/UCI HAR Dataset/features.txt")

#Read train sets
trainSet <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
trainActivities <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
trainSubjects <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

#Read test sets
testSet <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
testActivities <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
testSubjects <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

#1 - Merges the training and the test sets to create one data set.
trainSet <- cbind(trainSubjects, trainActivities, trainSet)
testSet <- cbind(testSubjects, testActivities, testSet)
mergedSet <- rbind(trainSet, testSet)

#3 - Uses descriptive activity names to name the activities in the data set
#4 - Appropriately labels the data set with descriptive variable names.
featuresNames <- as.vector(features[,2])
colnames(mergedSet) <- c("Subject", "Activity", featuresNames)

#2 - Extracts only the measurements on the mean and standard deviation for each measure.
library(data.table)
subsetZero <- mergedSet[names(mergedSet) %in% c("Subject", "Activity")]
subsetOne <- mergedSet[names(mergedSet) %like% "mean"]
subsetTwo <- mergedSet[names(mergedSet) %like% "std"]
mergedSet <- cbind(subsetZero, subsetOne, subsetTwo)

#5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidyDS <- data.frame(sapply(mergedSet, mean))
write.table(tidyDS, "./data/tidyDS.txt", quote = F, row.names = F, col.names = F)