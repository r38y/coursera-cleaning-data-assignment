# Coursera Cleaning Data Assignment Code Book

This data set consists of 66 variables and 180 observations derived from the [Human Activity Recognition Using Smartphones][1] data set.

## Files

`variable_means_by_subject_and_activity.csv`

## Variables

The meaning of each of the various measurement types (minus prefixes and suffixes) are best pulled from the original study but I've described some of the naming changes I've made below

* subject - the number of the subject, 1-30
* activity - the activity being performed
* time_ - based on time domain signals
* frequency_ - based on frequency domain signals
* _X, _Y, _Z - the various axis
* std - the standard deviation
* mean - the mean

## Observations

* There are 6 different activities for each of the 30 test subjects resulting in 180 observations. The value of each is the mean for each specific combination of subject and activity

[1]: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
