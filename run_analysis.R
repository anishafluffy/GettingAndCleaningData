########## Loading Files ##########

## Load the "activity labels" and "features" files
activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt")
features<-read.table("./UCI HAR Dataset/features.txt")
## Load the "subject_test", "x_test" and "y_test" files
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")
x_test<-read.table("./UCI HAR Dataset/test/x_test.txt")
y_test<-read.table("./UCI HAR Dataset/test/y_test.txt",sep = " ")
## Load the "subject_train", "x_train" and "y_train" files
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")
x_train<-read.table("./UCI HAR Dataset/train/x_train.txt")
y_train<-read.table("./UCI HAR Dataset/train/y_train.txt",sep = " ")

########## Add Descriptive Activity Labels ########## 

## Add activities to both data sets (Step 3)
## Match y data to activity_labels 
y_test$activity<-activity_labels[match(y_test$V1,activity_labels$V1),2]
y_train$activity<-activity_labels[match(y_train$V1,activity_labels$V1),2]

## Change activity labels to lowercase and remove underscores
y_test$activity<-tolower(y_test$activity)
y_test$activity<-sub("_"," ",y_test$activity)
y_train$activity<-tolower(y_train$activity)
y_train$activity<-sub("_"," ",y_train$activity)

## Join x, y, and subject columns together for both test and train
## Add activity labels and create new data frames
test_data<-cbind(y_test[2],x_test) 
train_data<-cbind(y_train[2],x_train) 

## Add subject number to the new data frame
test_data<-cbind(subject_test,test_data) 
train_data<-cbind(subject_train,train_data) 

########## Merge Datasets ########## 

## Merge test and train data sets (Step 1)
## Create new data frame with merged test and train data
data <- rbind(test_data, train_data)

########## Add Descriptive Variable Names ##########

## Label data set with descriptive variable names (Step 4)
## Create vector of the variable names
columns<-as.character(features[,2])   
## Make columns descriptive
## Change "t" to "Time"
columns<-sub("^t","Time",columns)
## Change "f" to "Freq"
columns<-sub("^f","Freq",columns)
## Delete extra "Body"
columns<-sub("BodyBody","Body",columns)
## Change dash to underscore
columns<-gsub("-","_",columns)
## Delete parenthesis
columns<-sub("\\(\\)","",columns)

## Add subject and activity headings
columns<-c("subject","activity",columns) 
## Update the column names of data
colnames(data)<-columns                  

## Extract only the measurements on the mean and standard deviation for each measurement (Step 2)
## Find the columns with mean and std
data_2<-data[grepl("mean",columns)|grepl("std",columns)]
## Bind the mean and std columns with the subject and activity columns
data_2<-cbind(data[,c(1,2)],data_2)

########## Create Tidy Data Set ########## 

## Create narrow tidy data with averages of each variable (Step 5)
library(reshape2)
## Use recast to shape data into a narrow data set with averages of mean and std
tidydata<-recast(data_2, subject+activity+variable~., fun.aggregate=mean, id.var = 1:2)
## Set the column names
colnames(tidydata)<-c("subject","activity","variable","average")

## Export TidyData.txt
write.csv(tidydata,file = "TidyData.txt",row.names = F)


