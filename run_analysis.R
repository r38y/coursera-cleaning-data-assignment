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

# Helper functions
loadData <- function(filename) {
  fread(paste("./data/UCI HAR Dataset/", filename, sep = ""))
}

# Label data
activityLabels <- loadData("activity_labels.txt") # 6 rows
colNames <- loadData("features.txt") # 561 rows

# Train data

trainActivities <- loadData("train/y_train.txt")
trainSubjectNumbers <- loadData("train/subject_train.txt")
trainReadings <- loadData("train/X_train.txt") # 561 cols
# add headings
names(trainReadings) <- as.vector(colNames[, V2])

# add activity
trainReadings[, activity:=as.vector(trainActivities[, V1])]

# add subject
trainReadings[, subject:=as.vector(trainSubjectNumbers[, V1])]

# Test data

testActivities <- loadData("test/y_test.txt")
testSubjectNumbers <- loadData("test/subject_test.txt")
testReadings <- loadData("test/X_test.txt") # 561 cols

# select columns

# Write the new data set to disk