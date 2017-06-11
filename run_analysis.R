# Download and unzip data

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

loadData <- function(filename) {
  fread(paste("./data/UCI HAR Dataset/", filename, sep = ""))
}

# 
activityLabels <- loadData("activity_labels.txt") # 6 rows
colNames <- loadData("features.txt") # 561 rows

# Train Data

trainActivities <- loadData("train/y_train.txt")
trainSubjectNumbers <- loadData("train/subject_train.txt")
trainReadings <- loadData("train/X_train.txt") # 561 cols

# Test Data

testActivities <- loadData("test/y_test.txt")
testSubjectNumbers <- loadData("test/subject_test.txt")
testReadings <- loadData("test/X_test.txt") # 561 cols

# Merge the data

# Write the new data set to disk