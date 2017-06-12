# Helper functions

loadData <- function(filename) {
  tbl_df(read.table(paste("./data/UCI HAR Dataset/", filename, sep = "")))
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