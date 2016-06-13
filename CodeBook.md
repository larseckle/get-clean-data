
### Description

This document provides information about variables, underlying data, conversions of data in context of the
course "Getting and Cleaning Data course." at Johns Hopkins University

### Source Data

The underlying raw data is described at the UCI Machine Learning Repository

Project website:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Retrieved data:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


### Data Set Information

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:


- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.


### Process Flow and Data Represenation

Step 0.  Download complete data archive for the project including raw data and description

prepare a directory that contains the downloaded zip archive and the unpacked data


Step 1. Merge the training and the test sets to create one data set.

Read the data from the followin files

# data about the measured points in test and training data 
    features.txt

# training data
    subject_train.txt
    x_train.txt
    y_train.txt
# test data    
    subject_test.txt
    x_test.txt
    y_test.txt

# data about acivity during which measurements were taken
    activity_labels.txt

combine the test and training data based on rows
integrate subject and activity data on column base the aforementioned data
assign column names as extracted from features.txt
the result is the full data set stored in variable:

completeData

Step 2. Extract only the measurements on the mean and standard deviation for each measurement.

identify all measrurement points thatcarry the string "mean()" or "std()" in the respective column name
reduced data set is stored in:

refinedData


Section 3. Use descriptive activity names to name the activities in the data set.

columns "activity" is converted into the more meaningful descriptions sourced from activity_labels.txt
columns "activity" and "subject" are converted into factors

refined data set is stored in:
refinedData


Step 4. Appropriately labels the data set with descriptive variable names.

Apply a series of gsub to expand abbreviations in the column names and make them easier to understand for humans.
refined data set is stored in:
refinedData

Step 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Group by subject and activity and apply mean() to the values of eaech group and store in variable
finalData

contents of finalData gets written to "tidy.txt" of the working directory

