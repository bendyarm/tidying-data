# Codebook for tidying-data
## For the file tidy_activity_recog_data.txt

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
All the `*_train.txt` files have 7352 lines/rows and all the `*_test.txt` files have 2947 lines,
so each appended pair has 7352+2947 = 10299 rows.
The first pair, `*/X_*.txt`, contains 561 columns of floating point observations.  
The column names are in the file `features.txt`, which has one name per line for 561 lines
 (and these measurements are described in the file `features_info.txt`).  
After combining the first pair, all columns whose names did not contain either the string
`mean()` or `std()` were discarded.  (There is further discussion of this in the script.)
This reduced the number of columns to 66.  
The second pair, `*/subject_*.txt`, contains one column which is the human subject number (in the range 1 to 30).  
The third pair, `*/y_*.txt`, contains one column which is an integer from 1 to 6
 indicating the type of activity the subject was doing when the measurement was made.  
The mapping between activity number and a descriptive name for the activity
 is in the file `activity_labels.txt`.  
After combining training and testing data for each pair of files,
 the 3 types of data were adjoined, with the result being a single data frame with 68 columns and 10299 rows.  
Next, the column containing activity numbers was replaced by an equivalent column with
 descriptive activity names (those from the file `activity_labels.txt` mentioned above).


