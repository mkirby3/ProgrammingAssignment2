# run_analysis.R

run_analysis <- function() {
      # Read in the training and test sets as separate data frames.
      setwd("~/Documents/DataScienceSpecialization-Coursera/3-GettingAndCleaningData/CourseProject/UCI HAR Dataset/train")
      train_df <- read.table("X_train.txt")
      trainActivity <- read.table("y_train.txt")
      train_df <- cbind(trainActivity, train_df)
      colnames(train_df)[1] <- "Activity"
      
      setwd("~/Documents/DataScienceSpecialization-Coursera/3-GettingAndCleaningData/CourseProject/UCI HAR Dataset/test")
      test_df <- read.table("X_test.txt") 
      testActivity <- read.table("y_test.txt")
      test_df <- cbind(testActivity, test_df) 
      colnames(test_df)[1] <- "Activity"
      
      # Merges the training and the test sets to create one data set.
      full_df <- merge(train_df, test_df, all = TRUE) 
      
      # Read in the column/variable names from 'features.txt'
      setwd("~/Documents/DataScienceSpecialization-Coursera/3-GettingAndCleaningData/CourseProject/UCI HAR Dataset/")
      features <- read.table("features.txt") 
      features <- features[, 2] 
      features <- as.character(features)
      
      # Assign the column/variable names in 'features' to the column headers 
      # in full_df (leaving the column name in the first column as "Activity")
      colnames(full_df)[2:562] <- features
      
      # Extracts only the measurements on the mean and standard deviation for 
      # each measurement. 
      meanLogical <- grepl("mean()", features, fixed = TRUE)
      stdLogical <- grepl("std()", features, fixed = TRUE) 
      meanOrStd <- logical()
      for (i in 1:length(meanLogical)) {
            if (identical(meanLogical[i], TRUE) | identical(stdLogical[i], TRUE)) {
                  meanOrStd[i] <- TRUE
            } else {
                  meanOrStd[i] <- FALSE
            }
      }
      meanOrStd <- c(TRUE, meanOrStd) 
      meanAndStdMeasures_df <- full_df[, meanOrStd]
      
      # Uses descriptive activity names to name the activities in the data set
      activityLabels <- character(length = nrow(meanAndStdMeasures_df))
      for (i in 1:length(activityLabels)) {
            if (identical(meanAndStdMeasures_df[i, 1], as.integer(1))) {
                  activityLabels[i] <- "Walking"
            } else if (identical(meanAndStdMeasures_df[i, 1], as.integer(2))) {
                  activityLabels[i] <- "WalkingUpstairs"
            } else if (identical(meanAndStdMeasures_df[i, 1], as.integer(3))) {
                  activityLabels[i] <- "WalkingDownstairs"
            } else if (identical(meanAndStdMeasures_df[i, 1], as.integer(4))) {
                  activityLabels[i] <- "Sitting" 
            } else if (identical(meanAndStdMeasures_df[i, 1], as.integer(5))) {
                  activityLabels[i] <- "Standing" 
            } else if (identical(meanAndStdMeasures_df[i, 1], as.integer(6))) {
                  activityLabels[i] <- "Laying" 
            } else {
                  activityLabels[i] <- NA 
            }
      }
      
      activityLabels <- as.data.frame(activityLabels)
      meanAndStdMeasures_df2 <- cbind(activityLabels, meanAndStdMeasures_df[, 2:67])
      
      # From the data set in step 4, creates a second, independent tidy data set 
      # with the average of each variable for each activity and each subject.
      write.table(meanAndStdMeasures_df2, "~/Documents/DataScienceSpecialization-Coursera/3-GettingAndCleaningData/CourseProject/UCI HAR Dataset/tidyDataFull.txt", row.name=FALSE)
}


