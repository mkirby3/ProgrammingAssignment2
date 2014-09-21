# run_analysis.R

run_analysis <- function() {
      # Read in the training and test sets as separate data frames.
      setwd("~/Documents/DataScienceSpecialization-Coursera/3-GettingAndCleaningData/CourseProject/UCI HAR Dataset/train")
      train_df <- read.table("X_train.txt")
      
      setwd("~/Documents/DataScienceSpecialization-Coursera/3-GettingAndCleaningData/CourseProject/UCI HAR Dataset/test")
      test_df <- read.table("X_test.txt") 
      
      # 1) Merges the training and the test sets to create one data set.
      full_df <- merge(train_df, test_df, all = TRUE) 
      
      
      # Read in the column/variable names from 'features.txt'
      setwd("~/Documents/DataScienceSpecialization-Coursera/3-GettingAndCleaningData/CourseProject/UCI HAR Dataset/")
      features <- read.table("features.txt") 
      features <- features[, 2] 
      features <- as.character(features)
      
      # Assign the column/variable names in 'features' to the column headers 
      # in full_df
      colnames(full_df) <- features
      
      # 2) Extracts only the measurements on the mean and standard deviation for 
      # each measurement. 
      write.table(full_df, "~/Documents/DataScienceSpecialization-Coursera/3-GettingAndCleaningData/CourseProject/UCI HAR Dataset/tidyDataFull.txt", row.name=FALSE)
      
}


