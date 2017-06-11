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