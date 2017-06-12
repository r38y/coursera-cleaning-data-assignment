# Getting and Cleaning Data Course Project

run_analysis.R will

* Download and unzip the data
* Merge the subject, activity, readings, and variable names for each of the test and train data sets to make them much easier to understand
* Merge the test and train data sets into one big data set
* Narrow down the data set to only the mean and standard deviation for each of the observations
* Clean up the variable names so they are easier to read. I decided we didn't need () and underscores read better than dashes. I also made the short "t" and "f" and expanded them into something more descriptive, "time" and "frequency"
* Clean up the activity type names. I left them as lowercase and underscored because those tend to be easier to read from a computer standpoint and they are also still easy to read as a human. I could have made them be something like "Walking Downstairs" but to be honest, that isn't any easier to read and further down the line I bet someone is just going to turn it back into underscores.
* Create a tidy data set with the average of each variable for each activity and each subject and save it to "./output/variable_means_by_subject_and_activity.csv".

To read the reshaped data back in:

```
read.csv("./output/variable_means_by_subject_and_activity.csv")
```
