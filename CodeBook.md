#Code Book to get and clean data from Samsung smartphone data set.

The orginal unzipped folder (UCI HAR Dataset) was subdivided, with some of the necessary files stored under "train" or "test" folders.  So the first challenge was to find all the necessary files and learn to interpret them.

###Combining the datasets
The main data (measurements of 561 variables taken from each subject for each activity) were in two datasets:  "train/x_train.txt" and "test/x_test.txt".  The original volunteers had measurements taken during a training phase, then again during a test phase.  For the purposes of this study, these phases are combined.
Each file was read in separately using read.table, then the associated y and subject files were read to provide the activity codes and subject numbers,respectively, for each row of x, and were concatenated in front of the x datasets using cbind().
Then the two resulting files were combined using rbind() to create one large dataset (allSet) with observations all 561 variables and their identifiers.
The last step was to use grep() to remove all columns not needed. The "features.info.txt" file discusses 17 different variables that were calculated from the original observations.
I assume that only the first application of mean() as one of these calculated variables is to be included in the final dataset.  This means that the last 7 columns (which are gravityMeans calculated from the angle) will be eliminated, since angle() is a function on the same "level" as mean, so the gravityMean is a secondary calculation. I remove them first because it is easy to do so, and will avoid confusion when choosing the mean and standard deviation (std) columns. 
In all, the number of columns was reduced to 68.

###Readability
To make the datasets more understandable, gsub was used with the "activity_level.text" file to replace activity codes with the actual activity (Walking, Walking Upstairs, Walking Downstairs, Sitting, Standing, and Laying).

Renaming the variables (columns) is more cumbersome.  I decided to keep the basic paradigm used in the original dataset, with an initial t signifying calculations from the raw data (referred to in the README as the "time domain"), and an initial f indicating calculations after Fast Fourier Transforms were applied to the data (referred to as the "frequency domain").
"Acc" was changed to "Accel" for readability, and first letter of all words/abbreviations was capitalized (to avoid adding _ characters to already long variable names), and any extraneous symbols (.) were removed.

###The final summary
aggregate() was used to created the required means for all variables by subject and activity.  (A dataset 180 x 68).  "mean_" was pasted to the front of all variable names to indicate a change in what each column now represented.
I am assuming that this is the required "tidy dataset".
The dataset was then written to a new file: "Mean_Samsung_data.txt".
