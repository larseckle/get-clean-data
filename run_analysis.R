##################################

## Coursera Getting and Cleaning Data Course Project

# run_analysis.R File does the following:

# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement.
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names.
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##################################


## 0. Loading data from given URL and saving it locally

# store locally
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip",method="auto")

# unpack
unzip(zipfile="./data/Dataset.zip",exdir="./data")
mydatadirectory <- file.path("./data" , "UCI HAR Dataset")

# read training data
X_train <- read.table(file.path(mydatadirectory, "train", "X_train.txt"))
y_train <- read.table(file.path(mydatadirectory  , "train", "y_train.txt"))
subject_train <- read.table(file.path(mydirectory , "train", "subject_train.txt"))

# read test data
X_test <- read.table(file.path(mydatadirectory, "test", "X_test.txt"))
y_test <- read.table(file.path(mydatadirectory, "test", "y_test.txt"))
subject_test <- read.table(file.path(mydatadirectory, "test", "subject_test.txt"))


## 1. Merges the training and the test sets to create one data set.

# combine test and training by rows
X_merged <- rbind( X_train,  X_test)
activity_merged <- rbind( y_train,  y_test)
subject_merged <- rbind(subject_train, subject_test)

# assign original column names
features <- read.table(file.path(mydatadirectory, "features.txt"))
names(X_merged) <- features$V2 
names(subject_merged) <- c("subject")  
names(activity_merged) <- c("activity") 
  
# combine measurements, subject and activity data by col
completeData <- cbind(X_merged, subject_merged, activity_merged)


## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

# extract mean and std col names
my_mean_std_features <- features[grep("(std|mean)\\(\\)",features$V2),]

refinedData <- completeData[,c(as.character(my_mean_std_features$V2), "subject", "activity")]


## 3. Uses descriptive activity names to name the activities in the data set

# make elements of subject and activity meaningful, and turn them into a factor
activityLabels <- read.table(file.path(mydatadirectory, "activity_labels.txt"),header = FALSE)
refinedData$activity <- factor(refinedData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
refinedData$subject <- as.factor(allData$subject)


## 4. Appropriately labels the data set with descriptive variable names. 

# find an replace fragments of col name
names(refinedData)<-gsub("^t", "time", names(refinedData))
names(refinedData)<-gsub("^f", "frequency", names(refinedData))
names(refinedData)<-gsub("Acc", "Accelerometer", names(refinedData))
names(refinedData)<-gsub("[gG]yro", "Gyroscope", names(refinedData))
names(refinedData)<-gsub("Mag", "Magnitude", names(refinedData))
names(refinedData)<-gsub("BodyBody", "Body", names(refinedData))
names(refinedData)<-gsub("\\(\\)","",names(refinedData))
names(refinedData)<-gsub("-std","StdDev",names(refinedData))
names(refinedData)<-gsub("-mean","Mean",names(refinedData))
names(refinedData)<-gsub("([Gg]ravity)","Gravity",names(refinedData))
names(refinedData)<-gsub("(-)","",names(refinedData))


## 5. From the data set in step 4, creates a second, independent tidy data set with the 
## average of each variable for each activity and each subject.

# group by subject and activity and apply mean()
finalData <-aggregate(. ~subject + activity, refinedData, mean)

# save tidy data
write.table(finalData, file = "tidy.txt",row.name=FALSE)


