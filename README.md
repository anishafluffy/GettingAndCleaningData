GettingAndCleaningData
======================
README
========================================================

The run_analysis script uses the data in the "UCI HAR Dataset"

Link to data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

This script does the following: 

1. first loads the "activity labels", "features" "subject_test", "x_test",  "y_test", "subject_train", "x_train" and "y_train" files
2. adds activity labels to the data
3. merges the train and test data together
4. changes the "V1, V2,.." variable names to more descriptive names
5. extracts only the mean and standard deviation measurements from the original files
6. creates a narrow tidy data set with the averages of the averages of the variables for each subject and activity
