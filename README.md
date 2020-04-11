# Getting-and-Cleaning-Data-Project
### My submission for the course project of the John Hopkins University Getting and Cleaning Data course on Coursera
Luis Venegas <br><br>
#### This README file explains the code in the run_analysis script. 

##### Obtaining the Data: 
The run_analysis script will automatically download the dataset required for the analysis. <br>
If the data has already been downloaded in the working directory with the standard name "UCI HAR Dataset", the files will not be redownloaded. <br>
It is important that the working directory is NOT the UCI HAR Dataset, but the directory where this was downloaded. 
###### Example: If dataset was downloaded into your Documents folder then working directory shoud be;
###### Correct: ~/Documents 
###### Incorrect: ~/Documents/UCI HAR Dataset<br>

##### General Labels
The script then loads in the features and activity labels. We'll use these to name our columns and activities later. <br>

##### Test/Train Data
The following procedure is followed for reading the test data: <br> 
- Read the subjects (subject_test)
- Read the sensor data (X_test)
- Rename the sensor data columns with the correct feature names.
- Read the activity label data (y_test)
- Bind the three data tables by columns
<br>
An equal procedure is followed for the training data. <br>
The train/test datasets are binded by rows, giving us a complete dataset. <br>

##### Mean and STD_Dev
In this step we reduce the original dataset to include only the columns that are measuring mean and standard deviation. <br>
This is accomplished by using the grepl function with a regex expression that extracts all column names with mean() and std(). 
Once we have the desired names, we just subset our complete dataset using the column names we extracted.

##### Naming Activities
Creating a function and using an apply function allows for the renaming of all the activity labels from the number ID to their descriptive name. <br>
The function is created to take a row from the data, and replace the number in the "Label" column for its equivalent name by using the number in the row as the index we want from the activity labels that were preloaded at the start of the script.









