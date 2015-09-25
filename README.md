# Data_cleaning
For the script made in the Data cleaning course

This MD describes the workings of the script, and also contains an overview of the variable names used (code book)

The script starts by opening the different required files:
activity_labels.txt: contains the activities (6 of them) label, number in the list = activity number
features.txt: contains all descriptions of all variables (basically the code book)
test/subject_test.txt: contains all the subject numbers for all the observations in X_test
test/X_test.txt: contains all normalized data from the test-set
test/y_test.txt: contains all activity numbers for the data in X_test
train/subject_train.txt: same as above, but for the training set
train/X_test.txt: same as above
train/y_test.txt: same as above

The X_test and X_train consist of 2947 and 7352 rows of 561 variables respectively. Because it is loaded from a txt file, it first has to be cut into pieces (the strings) and converted into number. I do this columnwise, because it is a lot faster then row-wise.
After loading them in, combine them in one big dataset, and then filter.
We only want the mean and std values. It is filtered through a dplyr select statement, this keeps 88 (including the columns containing subject and activity info).
After that it is grouped, and then summarized. Unfortunately, R doesn't know an average, only a mean. But the assignment says average. Therefore I create two summarized data_frames, n_df (number of observations) and sum_df (sum of the observations) grouped on subject number and activity. Then I create the definitive tidy set, by dividing sum_df by n_df on a column by column basis. 
I'm aware that there are probably faster ways to do this, but a month ago I never even heard of R... :-)

The column names (88 left) are as follows:
"Subject_Numbers": the subject number
"Activity_Type": the activity type
"1 tBodyAcc-mean()-X" : the mean body acceleration (it is stated in the original files) in X direction. 
"2 tBodyAcc-mean()-Y" : the number in front is the number of the original column in the set. It first lists all the means
"3 tBodyAcc-mean()-Z" : then all the stds (this is due to the grouping method). It isn't stated in the assignment that this
"41 tGravityAcc-mean()-X" : isn't allowed
"42 tGravityAcc-mean()-Y" 
"43 tGravityAcc-mean()-Z" 
"81 tBodyAccJerk-mean()-X" 
"82 tBodyAccJerk-mean()-Y" 
"83 tBodyAccJerk-mean()-Z" 
"121 tBodyGyro-mean()-X"
"122 tBodyGyro-mean()-Y" 
"123 tBodyGyro-mean()-Z" 
"161 tBodyGyroJerk-mean()-X" 
"162 tBodyGyroJerk-mean()-Y" 
"163 tBodyGyroJerk-mean()-Z"
"201 tBodyAccMag-mean()" 
"214 tGravityAccMag-mean()" 
"227 tBodyAccJerkMag-mean()" 
"240 tBodyGyroMag-mean()" 
"253 tBodyGyroJerkMag-mean()" 
"266 fBodyAcc-mean()-X" 
"267 fBodyAcc-mean()-Y" 
"268 fBodyAcc-mean()-Z" 
"294 fBodyAcc-meanFreq()-X" 
"295 fBodyAcc-meanFreq()-Y" 
"296 fBodyAcc-meanFreq()-Z" 
"345 fBodyAccJerk-mean()-X" 
"346 fBodyAccJerk-mean()-Y" 
"347 fBodyAccJerk-mean()-Z" 
"373 fBodyAccJerk-meanFreq()-X" 
"374 fBodyAccJerk-meanFreq()-Y" 
"375 fBodyAccJerk-meanFreq()-Z" 
"424 fBodyGyro-mean()-X" 
"425 fBodyGyro-mean()-Y" 
"426 fBodyGyro-mean()-Z" 
"452 fBodyGyro-meanFreq()-X" 
"453 fBodyGyro-meanFreq()-Y" 
"454 fBodyGyro-meanFreq()-Z" 
"503 fBodyAccMag-mean()" 
"513 fBodyAccMag-meanFreq()" 
"516 fBodyBodyAccJerkMag-mean()" 
"526 fBodyBodyAccJerkMag-meanFreq()" 
"529 fBodyBodyGyroMag-mean()" 
"539 fBodyBodyGyroMag-meanFreq()" 
"542 fBodyBodyGyroJerkMag-mean()" 
"552 fBodyBodyGyroJerkMag-meanFreq()" 
"555 angle(tBodyAccMean,gravity)" 
"556 angle(tBodyAccJerkMean),gravityMean)" 
"557 angle(tBodyGyroMean,gravityMean)" 
"558 angle(tBodyGyroJerkMean,gravityMean)" 
"559 angle(X,gravityMean)" 
"560 angle(Y,gravityMean)" 
"561 angle(Z,gravityMean)" 
"4 tBodyAcc-std()-X" 
"5 tBodyAcc-std()-Y" 
"6 tBodyAcc-std()-Z" 
"44 tGravityAcc-std()-X" 
"45 tGravityAcc-std()-Y" 
"46 tGravityAcc-std()-Z" 
"84 tBodyAccJerk-std()-X" 
"85 tBodyAccJerk-std()-Y" 
"86 tBodyAccJerk-std()-Z" 
"124 tBodyGyro-std()-X" 
"125 tBodyGyro-std()-Y" 
"126 tBodyGyro-std()-Z" 
"164 tBodyGyroJerk-std()-X" 
"165 tBodyGyroJerk-std()-Y" 
"166 tBodyGyroJerk-std()-Z" 
"202 tBodyAccMag-std()" 
"215 tGravityAccMag-std()" 
"228 tBodyAccJerkMag-std()" 
"241 tBodyGyroMag-std()" 
"254 tBodyGyroJerkMag-std()" 
"269 fBodyAcc-std()-X" 
"270 fBodyAcc-std()-Y" 
"271 fBodyAcc-std()-Z" 
"348 fBodyAccJerk-std()-X" 
"349 fBodyAccJerk-std()-Y" 
"350 fBodyAccJerk-std()-Z" 
"427 fBodyGyro-std()-X" 
"428 fBodyGyro-std()-Y" 
"429 fBodyGyro-std()-Z" 
"504 fBodyAccMag-std()" 
"517 fBodyBodyAccJerkMag-std()" 
"530 fBodyBodyGyroMag-std()" 
"543 fBodyBodyGyroJerkMag-std()"

