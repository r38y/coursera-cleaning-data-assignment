# Download and unzip data

downloadData()

# Label data

activityLabels <- loadData("activity_labels.txt") # 6 rows
activityLabels[,name:= lapply(gsub("_", " ", V2), tolower)]
colNames <- loadData("features.txt") # 561 rows
colNames <- as.vector(colNames[, V2])

# Train data

trainActivities <- loadData("train/y_train.txt")
trainSubjectNumbers <- loadData("train/subject_train.txt")
trainReadings <- loadData("train/X_train.txt") # 561 cols

trainReadings <- mergeData(trainReadings, trainSubjectNumbers, trainActivities)

# Test data

testActivities <- loadData("test/y_test.txt")
testSubjectNumbers <- loadData("test/subject_test.txt")
testReadings <- loadData("test/X_test.txt") # 561 cols

testReadings <- mergeData(testReadings, testSubjectNumbers, testActivities)

# Combine the data

# Write the new data set to disk

# Helper functions

loadData <- function(filename) {
  fread(paste("./data/UCI HAR Dataset/", filename, sep = ""))
}

mergeData <- function(readings, subjectNumbers, activities) {
  # add headings
  names(readings) <- colNames
  
  # add activity
  activityNames <- activityLabels[as.vector(activities[, V1]), name]
  readings[, activity:=activityNames]
  
  # add subject
  readings[, subject:=as.vector(subjectNumbers[, V1])]
  # setcolorder(trainReadings, c("subject", "activity", colNames))
  readings
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