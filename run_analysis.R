#
# JHU Getting and Cleaning Data, week 4, final course project
#
# Author: Stefan Mohr
#

# Load needed libraries
library(reshape2)

# setting working dir and reading test und train data
setwd("C:\\Users\\smohr\\ownCloud\\DATASCIENCE\\666 - R\\6 Course (3-3) - JHU - Getting and Cleaning Data\\final project")
dataTest <- read.table("X_test.txt", quote="\"", comment.char="")
dataTrain <- read.table("X_train.txt", quote="\"", comment.char="")
activitiesTest <- read.table("y_test.txt", quote="\"", comment.char="")
activitiesTrain <- read.table("y_train.txt", quote="\"", comment.char="")
subjectTest <- read.table("subject_test.txt", quote="\"", comment.char="")
subjectTrain <- read.table("subject_train.txt", quote="\"", comment.char="")

# get all row names from the file
features <- read.table("features.txt", quote="\"", comment.char="")

# combining the data sets
combinedTest <- cbind(dataTest, subjectTest, activitiesTest)
combinedTrain <- cbind(dataTrain, subjectTrain, activitiesTrain)

# merging the complete data set
data <- rbind(combinedTest, combinedTrain)

# set the row names in the data set from the features.txt file and the activity
names(data) <- features$V2
names(data)[562] <- "subject"
names(data)[563] <- "activityid"

# Read activity labels file
activityLabels <- read.table("activity_labels.txt", quote="\"", comment.char="")
names(activityLabels) <- c("activityid","activityname")

# refactoring of the activity with verbose labels
data$activityname <- factor(data$activityid, levels = activityLabels$activityid, labels = activityLabels$activityname)

# select only the needed rows (std | mean | subject | activityname)
dataSelected <- data[,grep("-mean\\(\\)|-std\\(\\)|subject|activityname", names(data))]

# duplicate the data set
dataComputed <- dataSelected

# melt and dcast the copy of the data set to group by subject and activityname and calculate mean for all variables
dataComputed <- reshape2::melt(data = dataComputed, id = c("subject", "activityname"))
dataComputed <- reshape2::dcast(data = dataComputed, subject + activityname ~ variable, fun.aggregate = mean)

# output computed data set to HDD
write.table(dataComputed, "computeddata.txt", row.names = FALSE)
