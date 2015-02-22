# tidying-data
Class project for Coursera JHU Getting and Tidying Data
2015-02-22

This project consists of an R script that reads a specific
dataset and tidies it according to the class instructions.

The files here are:<br/>
  `README.md` - this file<br/>
  `run_analysis.R` - the R script that tidies the data<br/>
  `CodeBook.md` - a codebook describing the output data file<br/>
Not included here:<br/>
&nbsp;&nbsp;The input and output files.  They are described below, though.
  
## Setup
In order to run the R script, you will need a suitable version of R
and the dplyr library, and the input data set.

### R version
Tested on R version: 3.1.2.  
Tested on Mac OSX 10.9.5 (64-bit),  
using RStudio Version 0.98.507

### dplyr
Tested on dplyr package version: 0.4.1.  
Note, to check if you have dplyr installed, do this at an R prompt:
```
> installed.packages()["dplyr",c("Package","Version")]
Package Version 
"dplyr" "0.4.1" 
```
If, instead of the above response, you get a "subscript out of bounds" error,
then you will need to install the dplyr package like this:
```
> install.packages("dplyr")
```

### Required input data
Download the following zip file (about 63 MB) and expand it:  
  `https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip`  
That will create the `"UCI HAR Dataset"` directory (about 270 MB).  
The tested version of this dataset was downloaded on Fri Feb 20 14:29:04 2015.  
Note, if the dataset is not available at that location, it is possible you can get it
from  
  `http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip`  
However, I did not verify that the contents were identical.

## Running the Script
See the comments at the top of `run_analysis.R` for detailed information on how to run the script.  
In most cases, just cd to the 'UCI HAR Dataset' and run the script.

## Output file
The script will generate an output dataset in whitespace-delimited text form.  
The dataset is written to the file `tidy_activity_recog_data.txt`  
in the `"UCI HAR Dataset"` directory.  
See the file CodeBook.md (in the same directory as this README.md file)
for details on the output dataset.

