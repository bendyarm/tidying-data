# Codebook for tidying-data
## For explaining the content of the file tidy_activity_recog_data.txt

See also the file `README.md` and the R script `run_analysis.R`  
for more details on the location of the original data set  
and the code implementing the transformation.

Starting with the original data from the files (under `"USI HAR Dataset"`):  
`train/X_train.txt`  
`test/X_test.txt`  
`train/subject_train.txt`  
`test/subject_test.txt`  
`train/y_train.txt`  
`test/y_test.txt`  
These 6 files were read into R and appended in pairs to combine the training and testing data.  
All the `*_train.txt` files have 7352 lines(rows) and all the `*_test.txt` files have 2947 lines,
so each appended pair has 7352+2947 = 10299 rows.  
The first pair, `*/X_*.txt`, contains 561 columns of floating point observations.  
The column names are in the file `features.txt`, which has one name per line for 561 lines
 (and these measurements are described in the file `features_info.txt`).  
After combining the first pair, all columns whose names did not contain either the string
`mean()` or `std()` were discarded.  (There is further discussion of this in the script.)
This reduced the number of columns to 66.  
The second pair, `*/subject_*.txt`, contains one column which is the human subject number (in the range 1 to 30).  
The third pair, `*/y_*.txt`, contains one column which was an integer from 1 to 6
 indicating the type of activity the subject was doing when the measurement was made.  
The mapping between activity number and a descriptive name for the activity
 is in the file `activity_labels.txt`.  
After combining training and testing data for each pair of files,
 the 3 types of data were adjoined, with the result being a single data frame with 66+1+1 = 68 columns and 10299 rows.  
Next, the column containing activity numbers was replaced by an equivalent column with
 descriptive activity names (those from the file `activity_labels.txt` mentioned above).

Next, the data was grouped by subject number and subgrouped by activity name.
 Within each subgroup, each of the 66 floating point measurements was averaged.
 The resulting data contains 30*6 = 180 rows.  (Each of the 30 subjects participated in
 each of the 6 activities, and within each such subgroup, the mean of the observations for
 each column was computed.)

The output file `tidy_activity_recog_data.txt` contains 181 lines: one header line with column names,
 and 180 row lines.  Row labels (i.e. row index numbers) were suppressed when written to the file.  
It has 68 columns.  
The first column is `subject_num`.  It varies from 1 to 30.
The second column is `activity_name`.  It is described in the original data set documentation,
 but I will repeat it here for convenience.  The values are:  `LAYING` (sic; should be `LYING`), 
 `SITTING`, `STANDING`, `WALKING`, `WALKING_DOWNSTAIRS`, and `WALKING_UPSTAIRS`.  (Aside: It is 
 interesting that if you alphabetise these names, they come out in the order from least to most effort!)  
The remaining 66 columns consist of averages (for each subject X activity subgroup) of the original
 measurements with `mean()` or `std()` in their names.  Refer to the original data set documentation file
 `features_info.txt` for information about those columns.
 
