##Hemanshu Singh - Peer-graded Assignment: Getting and Cleaning Data Course Project

#check if directory exists, if not create it
if(!exists('./data')){dir.create('./data')}

#download the zip file
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip',
              './data/zipped_file.zip')

#unzip file
f <- unzip('./data/zipped_file.zip', exdir='./data')

#getting feature names to be used later in test and train files
features <- read.table(f[2], col.names = c('index', 'features'))
activities <- read.table(f[1], col.names = c('index', 'activity'))

#test data
t1 <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", stringsAsFactors = F, col.names = 'subject')
##this step also takes care of step4
t2 <- read.table("./data/UCI HAR Dataset/test/X_test.txt", stringsAsFactors = F, col.names = features$features)
t3 <- read.table("./data/UCI HAR Dataset/test/y_test.txt", stringsAsFactors = F, col.names = 'activityLabel')
##this step also takes care of step3
t3.1 <- inner_join(t3, activities, by = c('activityLabel' = 'index')) 
#get all test data into one df
test <- cbind(t1,t3.1,t2)

#training data
t4 <- read.table('./data/UCI HAR Dataset/train/subject_train.txt', stringsAsFactors = F, col.names = 'subject')
##this step also takes care of step4
t5 <- read.table("./data/UCI HAR Dataset/train/X_train.txt", stringsAsFactors = F, col.names = features$features)
t6 <- read.table("./data/UCI HAR Dataset/train/y_train.txt", stringsAsFactors = F, col.names = 'activityLabel')
##this step also takes care of step3
t6.1 <- inner_join(t6, activities, by = c('activityLabel' = 'index')) 


#get all test data into one df
train <- cbind(t4,t6.1,t5)

#1. Merges the training and the test sets to create one data set.
test_train <- rbind(test, train)

#2. Extracts only the measurements on the mean and standard deviation for each measurement.
test_train_mean_std <- test_train %>% select(matches('(mean.|std|activity|subject)'), -activityLabel)

#3. Uses descriptive activity names to name the activities in the data set
print('this is taken care of in the read data section above')

#4. Appropriately labels the data set with descriptive variable names.
##doing a bit cleaning of the variable names
names(test_train_mean_std) <- gsub('std', 'Std',names(test_train_mean_std))
names(test_train_mean_std) <- gsub('mean', 'Mean',names(test_train_mean_std))
names(test_train_mean_std) <- gsub('\\.', '',names(test_train_mean_std))

#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
avg_df <- test_train_mean_std %>%
            group_by(subject, activity) %>%
            summarise_all(mean, na.rm = TRUE)

write.table(avg_df, './data/tidy_data.txt', row.names = FALSE)
