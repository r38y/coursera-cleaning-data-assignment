# The results from running this script will be saved in ./output

library(dplyr)

# Helper functions

loadData <- function(filename) {
  read.table(paste("./data/UCI HAR Dataset/", filename, sep = ""))
}

mergeData <- function(readings, subjectNumbers, activities, variableNames, activityLabels) {
  # add headings
  names(readings) <- variableNames
  names(activities) <- c("activity_id")
  names(subjectNumbers) <- c("subject")
  
  # put pretty activity names as values
  activities <- select(left_join(activities, activityLabels, by = "activity_id"), activity)

  # combine them
  cbind(subjectNumbers, activities, readings)
}

downloadData <- function() {
  zipFile <- "./UCI_HAR_Dataset.zip"
  unzipDir <- "./data"
  if (!file.exists(zipFile) & !file.exists(unzipDir)) {
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileURL, destfile = zipFile, method = "curl")
  }
  if (!file.exists(unzipDir)) {
    unzip(zipFile, exdir = unzipDir)  
  }
  if (file.exists(zipFile)) {
    file.remove(zipFile)
  } 
}

writeDataTable <- function(dt, filename) {
  if(!file.exists("./output")) { dir.create("./output")}
  path <- paste("./output", filename, sep = "/")
  write.csv(dt, file = path)
}

# Download and unzip data

downloadData()

# Label data

activityLabels <- loadData("activity_labels.txt")
names(activityLabels) <- c("activity_id", "old_name")
activityLabels <- mutate(activityLabels, activity = tolower(old_name))
variableNames <- loadData("features.txt")$V2

# Train data

trainActivities <- loadData("train/y_train.txt")
trainSubjectNumbers <- loadData("train/subject_train.txt")
trainReadings <- loadData("train/X_train.txt")

trainReadings <- mergeData(trainReadings, trainSubjectNumbers, trainActivities, variableNames, activityLabels)

# Test data

testActivities <- loadData("test/y_test.txt")
testSubjectNumbers <- loadData("test/subject_test.txt")
testReadings <- loadData("test/X_test.txt")

testReadings <- mergeData(testReadings, testSubjectNumbers, testActivities, variableNames, activityLabels)

# Combine the data
readings <- rbind(trainReadings, testReadings)

# Subset to just mean and std
# readings <- subset(readings, select = grep("[a-zA-Z]+-(std|mean)\\(\\).*|subject|activity", names(readings)))

# Clean up column names
# names(readings) <- gsub("-", "_", names(readings))
# names(readings) <- gsub("\\(\\)", "", names(readings))
# names(readings) <- gsub("\\(\\)", "", names(readings))
# names(readings) <- gsub("^t{1}", "time_", names(readings))
# names(readings) <- gsub("^f{1}", "frequency_", names(readings))

# Write the new data set to disk

# writeDataTable(readings, "readings.csv")