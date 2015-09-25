#cleanData.R
#created for the Getting and Cleaning Data course
#Goals:
#1: Merge the training and the test sets to create one data set.
#2: Extract only the measurements on the mean and standard deviation for each measurement. 
#3: Use descriptive activity names to name the activities in the data set
#4: Appropriately label the data set with descriptive variable names. 
#5: From the data set in step 4, create a second, independent tidy data set
#   with the average of each variable for each activity and each subject.

#So therefore, break the tasks down in the following scheme:
#   Load all relevant files
#   Combine the different data sets to one big one
#   Keep only those data that has to do with mean or std
#   Calculate the averages of all these variable, grouped by activity and subject

#Because we have to add columns to a dataframe, it is probably easiest to use dplyr:
library(dplyr)

#Load all relevant files:
#first, go to the desired location:
originalWD <- getwd ()
setwd("UCI HAR Dataset")
#load in the set of datanames:
data_names_set <- readLines("features.txt")

#We have both test and train, start with train:
setwd("train")
raw_train_data <- readLines("X_train.txt")

#Load in the subjects:
subject_number_str <- readLines("subject_train.txt")
subject_number <- vector (mode = "numeric", length = length(subject_number_str))
#Load in the activity types
activity_type_str <- readLines("y_train.txt")
activity_type <- vector (mode = "character", length = length(activity_type_str))

for (j in 1:length(subject_number_str)) {
    subject_number [j] <- as.numeric(subject_number_str[j])
    #Later, maybe changing into labels?
    activity_type [j] <- switch (activity_type_str[j], "1" = "Walking",
                                 "2" = "Walking Upstairs",
                                 "3" = "Walking Downstairs",
                                 "4" = "Sitting",
                                 "5" = "Standing",
                                 "6" = "Lying") 
    #activity_type [j] <- as.numeric(activity_type_str [j])
}
train_df <- data.frame(subject_number)
#train_df[1] <- subject_number
colnames(train_df)[1] <- "Subject_Numbers"
train_df[2] <- activity_type
colnames(train_df)[2] <- "Activity_Type"

rm (subject_number)
rm (subject_number_str)
rm (activity_type)
rm (activity_type_str)


single_column <- vector (mode = "numeric", length = length(raw_train_data))
for (j in 0:560) {
    for (i in 1:length(raw_train_data)) {
        single_column [i] <- as.numeric(substr(raw_train_data[i], j*16 + 1, j*16+16))
    }
    
    print(data_names_set[j+1])
    train_df[[data_names_set[j + 1]]] <- single_column
    #colnames(train_df)[j + 2] <- data_names_set[j + 1]
}
rm (raw_train_data)
#Load in the subjects and put them in a new column!!

#And now the test-set
setwd ("../test")
raw_test_data <- readLines("X_test.txt")
#This file has 2947 rows of 561 elements per row in a text format.
#So cut this up into rows, and get all the elements per row as a number
#But first, the subject numbers and activity types:
#Load in the subjects:
subject_number_str <- readLines("subject_test.txt")
subject_number <- vector (mode = "numeric", length = length(subject_number_str))
#Load in the activity types
activity_type_str <- readLines("y_test.txt")
activity_type <- vector (mode = "numeric", length = length(activity_type_str))

for (j in 1:length(subject_number_str)) {
    subject_number [j] <- as.numeric(subject_number_str[j])
    #Later, maybe changing into labels?
    activity_type [j] <- switch (activity_type_str[j], "1" = "Walking",
                                 "2" = "Walking Upstairs",
                                 "3" = "Walking Downstairs",
                                 "4" = "Sitting",
                                 "5" = "Standing",
                                 "6" = "Lying") 
    #activity_type [j] <- as.numeric(activity_type_str [j])
}
test_df <- data.frame(subject_number)
#test_df[1] <- subject_number
colnames(test_df)[1] <- "Subject_Numbers"
test_df[2] <- activity_type
colnames(test_df)[2] <- "Activity_Type"

rm (subject_number)
rm (subject_number_str)
rm (activity_type)
rm (activity_type_str)
single_column <- vector (mode = "numeric", length = length(raw_test_data))
for (j in 0:560) {
    for (i in 1:length(raw_test_data)) {
        single_column [i] <- as.numeric(substr(raw_test_data[i], j*16 + 1, j*16+16))
    }
    print(data_names_set[j+1])
    test_df[[data_names_set[j + 1]]] <- single_column
    
}
rm (raw_test_data)
total_df <- data_frame()
#And bind together to one big data_frame (switch to dplyr here)
total_df <- bind_rows("Training data" = train_df, "Test data" = test_df, .id = "groups")
#and throw all the unnecessary Mbs away:
rm (train_df)
rm (test_df)
rm (single_column)
rm (data_names_set)

#Clean the data_frame:
clean_df <- select (total_df, 1:3, contains("mean"), contains("std"))
rm (total_df)

#And now group by subject and activity:
#unfortunately R only know a MEAN, not an AVERAGE. It can probably be calculated easier, but I wouldn't know
#the syntax. Therefore, make two new summarised data_frames:
sum_df <- clean_df %>%
    select (-groups) %>%
    group_by (Subject_Numbers, Activity_Type) %>%
    summarise_each(funs(sum))
n_df <- clean_df %>%
    select (-groups) %>%
    group_by (Subject_Numbers, Activity_Type) %>%
    summarise_each(funs(n()))
#and columnwise divide sum_df by n_df
tidy_df <- select(sum_df, 1:2)
for (j in 3:88) {
    one_column <- select(sum_df, j) / select(n_df, j)
    tidy_df[j] <- one_column[2]
    print (one_column[2])
}
#Remove all unwanted variables:
rm (clean_df)
rm (n_df)
rm (one_column)
rm (sum_df)
#Last but not least, reset the WD
setwd(originalWD)
#And here, save our file:
write.table(tidy_df, "Tidy_set.txt", row.name=FALSE)
