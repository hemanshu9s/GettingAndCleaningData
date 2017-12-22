# GettingAndCleaningData
#Getting And Cleaning Data Project
##Hemanshu Singh - Peer-graded Assignment: Getting and Cleaning Data Course Project

Getting-and-Cleaning-Data-Course-Project

Instructions to execute the code

Open a R terminal
Set your working directory as "Getting-and-Cleaning-Data-Course-Project"
Type 'source("run_analysis.R")' in the R terminal (R-studio whatever)
Run the function 'tidy_data'. This function doesn't take any argument. The output a list with 2 elements:
the first element, $ds1, is the data set created following steps 1 to 4
the second element, $ds2, is the data set created for the step 5
This function also returns a file "output.txt" in the "tidy-datasets" directory. This file contains the output we need to provide (step 5).

What the run_analysis.R script does :

Read the train & test sets
Add the right column name to each column
Add the activity, as a factor, for each observation
Add the subject associated to each observation
Merge the two sets
Rewrite column names so that they are more easily understandable
Create the data set needed step 5 and save it in "output.txt"
More info in comments into the code before every line of code
