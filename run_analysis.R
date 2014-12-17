# COURSE PROJECT for coursera course 'Getting and Cleaning Data'

# The code assumes that the file containing the data to be handled in the
# project has been unzipped in the working directory and that the files
# from which the data are going to be extracted are available with the
# same structure of subdirectories included in the zip file. Otherwise,
# the zip file cointaining the raw data is donwloaded and the file unzipped.

#.....................................................................
# TESTING FILES AVAILABILITY
dirfile2 <- "http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip"
# Test to know if the raw files are available in the working directory
if (!file.exists("UCI HAR Dataset/train/X_train.txt")
    | !file.exists("UCI HAR Dataset/test/X_test.txt")
    | !file.exists("UCI HAR Dataset/test/y_test.txt")
    | !file.exists("UCI HAR Dataset/train/y_train.txt")
    | !file.exists("UCI HAR Dataset/train/subject_train.txt")
    | !file.exists("UCI HAR Dataset/test/subject_test.txt")
    | !file.exists("UCI HAR Dataset/features.txt")
    | !file.exists("UCI HAR Dataset/activity_labels.txt")){
       download.file(dirfile2, destfile = "Dataset.zip")
       unzip("Dataset.zip")
}
#----------------------------------------------------------------------

# Loading package reshape2
if (!require(reshape2)) {
   install.packages("reshape2")
}
require(reshape2)

#.....................................................................
# READING FILES
# Reading X, y and subject data for both train and test datasets
xtrain <- read.table("UCI HAR Dataset/train/X_train.txt")
xtest <- read.table("UCI HAR Dataset/test/X_test.txt")
ytrain <- read.table("UCI HAR Dataset/train/y_train.txt")
ytest <- read.table("UCI HAR Dataset/test/y_test.txt")
subject.train <- read.table("UCI HAR Dataset/train/subject_train.txt")
subject.test <- read.table("UCI HAR Dataset/test/subject_test.txt")
# Reading variables and activities' descriptions
features <- read.table("UCI HAR Dataset/features.txt")[,2]
activities <- read.table("UCI HAR Dataset/activity_labels.txt")
#----------------------------------------------------------------------

#.....................................................................
# MERGING AND LABELLING RAw DATASETS
# Merging X, y and subject data for both train and test datasets
X <- rbind(xtrain, xtest)
y <- rbind(ytrain, ytest)
subject <- rbind(subject.train, subject.test)

# Descriptive names for all columns X, y, subject data and activities
colnames(X) <- features
colnames(y) <- "ID_activity"
colnames(subject) <- "subject"
colnames(activities) <- c("ID_activity", "activity")

# Selection of features containing measurements on the mean and
# standard deviation for each measurement
medias <- grep("mean()", features, fixed=TRUE)
desviaciones <- grep("std()", features, fixed=TRUE)
X <- X[, c(medias, desviaciones)]

# Assigning descriptive names to activities labels
y <- merge(y, activities)

# Combining the dataset of measurements with the activity labels
dataset1 <- cbind(X, y["activity"])
#----------------------------------------------------------------------

#.....................................................................
# SAVING THE TIDY DATASET
# Saving to csv the microdata dataset
write.table(dataset1, "Tidy.Dataset.csv", row.names=F, sep=";")
#----------------------------------------------------------------------

#.....................................................................
# (NEW) SUMMARY DATASET
# Creating and saving a second, independent tidy data set with the
# average of each variable for each activity and each subject
dataset2 <- cbind(dataset1, subject)

# Summarizing means per unique pair( of subject & activity
dataset2melt <- melt(dataset2, id=c("subject", "activity"))
dataset2 <- dcast(dataset2melt, activity + subject ~ variable, mean)
dataset2 <- dataset2[order(dataset2$subject),]

## Saving to csv the mean summary dataset
write.table(dataset2, "Subject.Activity.Means.csv", row.names=F, sep=";")
#----------------------------------------------------------------------

