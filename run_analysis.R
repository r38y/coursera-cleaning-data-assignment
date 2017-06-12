# The results from running this script will be saved in ./output

library(dplyr)
source("helper_functions.R")

# Download and unzip data

downloadData()

# Label data

activityLabels <- loadData("activity_labels.txt")
names(activityLabels) <- c("activity_id", "old_name")
activityLabels <- mutate(activityLabels, activity = tolower(old_name))
variableNames <- loadData("features.txt")$V2

# Read train data

trainActivities <- loadData("train/y_train.txt")
trainSubjectNumbers <- loadData("train/subject_train.txt")
trainReadings <- loadData("train/X_train.txt")

# Turn the train data into a well-labeled data set that we can manipulate later
trainReadings <- mergeData(trainReadings, trainSubjectNumbers, trainActivities, variableNames, activityLabels)

# Read test data

testActivities <- loadData("test/y_test.txt")
testSubjectNumbers <- loadData("test/subject_test.txt")
testReadings <- loadData("test/X_test.txt")

# Turn the test data into a well-labeled data set that we can manipulate later
testReadings <- mergeData(testReadings, testSubjectNumbers, testActivities, variableNames, activityLabels)

# Combine the data
readings <- rbind(trainReadings, testReadings)

# Subset to just mean and std
readings <- readings %>% 
  # Remove duplicates. I don't think I should have to do this but couldn't figure out
  # a better way. Since the duplicated ones don't include ones we want I'm 
  # just going to remove them. I don't think this is ideal but what I need to do.
  subset(., select=which(!duplicated(names(.)))) %>%
  # Find the columns with mean() and std() in the name as well as our original
  # subject and activity columns
  select(matches("[a-zA-Z]+-(std|mean)\\(\\)|subject|activity"))

# Clean up column names
names(readings) <- gsub("-", "_", names(readings))
names(readings) <- gsub("\\(\\)", "", names(readings))
names(readings) <- gsub("^t{1}", "time_", names(readings))
names(readings) <- gsub("^f{1}", "frequency_", names(readings))

# Write the new data set to disk for future reference
writeDataTable(readings, "readings.csv")

# Create a tidy data set with the average of each variable for each activity and each subject

library(reshape2)

# Melt with id of subject and activity since we are looking for the mean for each combination of
# activty and subject
melted <- melt(readings, id=c("subject", "activity"))

# This takes the melted data and finds the mean for each of the variables grouped by [subject, activity]
# There should be 180 rows since there are 30 subjects and 6 activities. 
reshaped <- dcast(melted, subject + activity ~ variable, mean)

writeDataTable(reshaped, "variable_means_by_subject_and_activity.csv")