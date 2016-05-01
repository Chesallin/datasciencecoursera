install.packages("here")
install.packages("plyr")
library(plyr)

###############################################################################
# Step 1
# Merge the training and test sets to create one data set
###############################################################################

xtrain <- read.table("train/X_train.txt")
ytrain <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")

xtest <- read.table("test/X_test.txt")
ytest <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")

# create 'x' data set
xdata <- rbind(xtrain, xtest)

# create 'y' data set
ydata <- rbind(ytrain, ytest)

# create 'subject' data set
subject_data <- rbind(subject_train, subject_test)

###############################################################################
# Step 2
# Extract only the measurements on the mean and standard deviation for 
# each measurement
###############################################################################

features <- read.table("features.txt")

# get only columns with mean() or std() in their names
mean_and_std_features <- grep("-(mean|std)\\(\\)", features[, 2])

# subset the desired columns
xdata <- xdata[, mean_and_std_features]

# correct the column names
names(xdata) <- features[mean_and_std_features, 2]

###############################################################################
# Step 3
# Use descriptive activity names to name the activities in the data set
###############################################################################

activities <- read.table("activity_labels.txt")

# update values with correct activity names
ydata[, 1] <- activities[ydata[, 1], 2]

# correct column name
names(ydata) <- "activity"

###############################################################################
# Step 4
# Label the data set with descriptive variable names
###############################################################################

names(subject_data) <- "subject"
all_data <- cbind(xdata, ydata, subject_data)

###############################################################################
# Step 5
# Create a second, independent tidy data set with the average of each variable
###############################################################################

# 66 <- 68 (activity & subject)
final_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))
write.table(final_data, "final_data.txt", row.name=FALSE)