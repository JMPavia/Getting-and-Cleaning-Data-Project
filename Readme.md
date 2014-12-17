run_analysis.R
==============

Getting and Cleaning Data. Course Project

This is a repository for the COURSE PROJECT of the online coursera course 'Getting and Cleaning Data'

Information about the data can be found in CodeBook.md.

The R code is for creating two new tidy datasets. 
One with the microdata of the measurements on the mean and standard deviation for each measurement.
An another with the average of each variable for each activity and each subject from the raw data of the first dataset.

The code assumes that the file containing the data to be handled in the project available in either:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
or:
http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip
has been unzipped in the working directory and that the files from which the data are going to be extracted are available with the same structure of subdirectories included in the zip file. Otherwise, the zip file cointaining the raw data is donwloaded and the corresponding file unzipped. In this latter case, the code needs a while to run.

As output the code produces two datasets. "Tidy.Dataset.csv" contains the microdata measuraments and "Subject.Activity.Means.csv" the subject-acrtivity averages.

The code has been tested and works nicely in R version 3.0.3 (2014-03-06) -- "Warm Puppy" for Windows.

## References

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
<activityrecognition@smartlab.ws>

## Required R Packages

The R package `reshape2` is required to run this script.
```

