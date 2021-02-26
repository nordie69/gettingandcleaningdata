# Final course project of Getting and CLeaning Data

## Explaining script run_analysis.R
The script run_analysis.R is structured in severak sections.

* Reading the data files
* Get the features row names
* Combining data files for test and training data seperately
* Merging both data sets
* Setting row names verbosely
* Get the verbose activity labels and relabel the coloumns
* Refactoring of the activities in the combined data set
* Selecting only the wanted columns (std, mean) and the rows needing for later grouping
* Duplicate the data, melt and dcast the data by subject and activity with mean-calculation for all variables
* wrting the data to the hard drive

## Codebook
The Codebook can be found in the extra file CodeBook.MD in thsi directory.
