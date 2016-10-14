#Assignment dataset download
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, "./data/galaxySacc.zip")

#Unzip the compressed file to the folder UCI HAR Dataset
unzip("./data/galaxySacc.zip", exdir = "./data")

#Using readme.txt and features_info.txt to identify the purpose of each data set.

#Read activity labels and features
activityLabels <- read.table("./data/UCI HAR Dataset/activity_labels.txt", colClasses =  c("character"))
features <- read.table("./data/UCI HAR Dataset/features.txt", colClasses = c("character"))

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

#4 - Appropriately labels the data set with descriptive variable names.
colnames(mergedSet) <- c("subject", "activity", features[,2])

#2 - Extracts only the measurements on the mean and standard deviation for each measure.
library(data.table)
subsetZero <- mergedSet[names(mergedSet) %in% c("subject", "activity")]
subsetOne <- mergedSet[names(mergedSet) %like% "mean"]
subsetTwo <- mergedSet[names(mergedSet) %like% "std"]
mergedSet <- cbind(subsetZero, subsetOne, subsetTwo)

#3 - Uses descriptive activity names to name the activities in the data set
mergedSet$activity[mergedSet$activity == 1] <- tolower(activityLabels[1,2])
mergedSet$activity[mergedSet$activity == 2] <- tolower(activityLabels[2,2])
mergedSet$activity[mergedSet$activity == 3] <- tolower(activityLabels[3,2])
mergedSet$activity[mergedSet$activity == 4] <- tolower(activityLabels[4,2])
mergedSet$activity[mergedSet$activity == 5] <- tolower(activityLabels[5,2])
mergedSet$activity[mergedSet$activity == 6] <- tolower(activityLabels[6,2])

#5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidyDS <- melt(mergedSet, id = c("subject", "activity"))
tidyDS <- dcast(tidyDS, subject + activity ~ variable, mean)

write.table(tidyDS, "./data/tidyDS.txt", quote = F, row.names = F, col.names = F)
