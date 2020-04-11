# Made By: Luis Venegas | luisvenegas@ufm.edu
# For: John Hopkins' Getting and Cleaning Data final project

# Install Packages
library(dplyr)

# Download UCI HAR Dataset
path = getwd()
if(!dir.exists(paste(path, "/UCI HAR Dataset", sep = ""))){
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(url, file.path(path, "dataFiles.zip"))
  unzip(zipfile = "dataFiles.zip")
}

# Load General Labels
features = read.table("UCI HAR Dataset/features.txt", sep = " ")
colnames(features) = c("id", "feature")

activity_labels = read.table("UCI HAR Dataset/activity_labels.txt", sep = " ", col.names = c("id", "activity"))

# Get Test data
get_test_data = function(){
  subjects_test = read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "Subject")
  X_test = read.table("UCI HAR Dataset/test/X_test.txt", header = F)
  colnames(X_test) = features$feature
  y_test = read.table("UCI HAR Dataset/test/y_test.txt", col.names = "Label")

  return(cbind(subjects_test, y_test, X_test))
}

test_data = get_test_data()

# Get Train data
get_train_data = function(){
  subjects_train = read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "Subject")
  X_train = read.table("UCI HAR Dataset/train/X_train.txt", header = F)
  colnames(X_train) = features$feature
  y_train = read.table("UCI HAR Dataset/train/y_train.txt", col.names = "Label")

  return(cbind(subjects_train, y_train, X_train))
}

train_data = get_train_data()

# Step 1: Merge train and test data
complete_data = rbind(train_data, test_data)

#Step 2: Only mean and std_dev
get_wanted_features = function(){
  features_names = features[,2]
  mean_std = grepl("(mean|std)\\(\\)", features_names)
  wanted_features = as.character(features_names[mean_std])
  wanted_features = c("Subject", "Label", wanted_features)
  return(complete_data[,wanted_features])
}

filtered_data = get_wanted_features()

# Step 3: Name activities
activity_namer = function(y){
  activities = activity_labels[,2]
  label = y[2] 
  y[2] = activities[label]
}
filtered_data[,2] = apply(filtered_data, 1, activity_namer)

# Step 4: Label data set with descriptive variable names
label_data = function(){
  new_names = names(filtered_data)
  new_names = gsub("^f", "Frequency ", new_names)
  new_names = gsub("^t", "Time ", new_names)
  new_names = gsub("-", " ", new_names)
  new_names = gsub("[()]", "", new_names)
  return(new_names)
}

names(filtered_data) = label_data()

# Step 5: Average of each variable for each activity and each subject and create a separate tidy file.

tidy_data = filtered_data %>% group_by(Subject, Label) %>% summarise_all(~mean(.))
write.table(tidy_data, "tidy_data.txt", row.names = FALSE)



