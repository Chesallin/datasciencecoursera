# Introduction
`run_analysis.R`performs the following 5 steps:
* 1. All the similar data is merged using the `rbind()` function.
* 2. Only those columns with the mean and standard deviation measures are taken from the whole dataset. After extracting these columns, they are given the correct names, taken from `features.txt`.
* 3. As activity data is addressed with values 1:6, we take the activity names and IDs from `activity_labels.txt` and they are substituted in the dataset.
* 4. On the whole dataset, those columns with vague column names are corrected.
* 5. It generates a new dataset with all the average measures for each subject and activity type (30 subjects * 6 activities = 180 rows). The output file is called `final_data.txt`, and uploaded to this repository.

# Variables
* `xtrain`, `ytrain`, `xtest`, `ytest`, `subject_train` and `subject_test` contain the data from the downloaded files.
* `xdata`, `ydata` and `subject_data` merge the previous datasets to further analysis.
* `features` contains the correct names for the `xdata` dataset, which are applied to the column names stored in `mean_and_std_features`, a numeric vector used to extract the desired data.
* `all_data` merges `xdata`, `ydata` and `subject_data` in a big dataset.
* `final_data` contains the relevant averages which will be later stored in a `.txt` file. `ddply()` from the plyr package is used to apply `colMeans()` and ease the development.