# Assignment week 4: get and clean data set

# first clean the environment
rm(list = ls())

# Set the working directory (if this script runs on your own laptop/compuer, change it accordingly)
setwd("C:/Users/helbouazzaoui/Desktop/Coursera course/Data science course/Course 3 Getting and cleaning data/Week 4")


# install reshape2 package to create tidy data
library(reshape2)

# Define the url of the data (zip file)
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if(!file.exists("./data")){dir.create("./data")}
download.file(fileurl, destfile = "./data/projectdata.zip", method = "curl")

# unzip the data
unzip("./data/projectdata.zip", overwrite = T, unzip = "internal")

# create training and test variables to load in the data
trainsetX <- read.table("UCI HAR Dataset/train/X_train.txt")
trainsetY <- read.table("UCI HAR Dataset/train/Y_train.txt")
testsetX <- read.table("UCI HAR Dataset/test/X_test.txt")
testsetY <- read.table("UCI HAR Dataset/test/Y_test.txt")

# load the train and test subject
trainSubject <- read.table("UCI HAR Dataset/train/subject_train.txt")
testSubject <- read.table("UCI HAR Dataset/test/subject_test.txt")

# Load the activity labels to add descriptive activity names to the data
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
names(activity_labels) <- c("Activity Number", "ACtivity Name")

# Load the features
features <- read.table("UCI HAR Dataset/features.txt")


# Find the indices where there is a mean or a std present
featureIndex <- grep(".*mean.*|.*std.*", features[,2])

# Define feature labels based on the indices with only the mean and std
featureLabels <- features[featureIndex,2]
featureLabels <- gsub('-mean', 'Mean', featureLabels)
featureLabels <- gsub('-std', 'Std', featureLabels)
featureLabels <- gsub('[-()]', '', featureLabels)
featureLabels <- gsub("^t", "time", featureLabels)
featureLabels <- gsub("^f", "freq", featureLabels)
featureLabels <- as.character(featureLabels)

# Only extract the mean and std from the training and test data sets
trainsetX <- trainsetX[featureIndex]
testsetX <- testsetX[featureIndex]

# merge train and test data sets
tmp_trainset <- cbind(trainSubject, trainsetY, trainsetX)
tmp_testset <- cbind(testSubject, testsetY, testsetX)

# create total merge of train and test sets
totalDataSet <- rbind(tmp_trainset, tmp_testset, deparse.level = 0)
names(totalDataSet) <- c('DataSubject', 'DataActivity', featureLabels)

# melt the data over subject and activity to 
totalDataSet_molted <- melt(totalDataSet, id =c("DataSubject", "DataActivity"))

# cast the molted data to calculate the average for each variable for each activity
totalDataSet_average <- dcast(totalDataSet_molted, DataSubject + DataActivity ~ variable, mean)

# create tidy dataset
write.csv(totalDataSet, file = "tidy_totaldataset.cvs")
write.csv(totalDataSet_average, file = "tidy_totaldataset_average.csv")

