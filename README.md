Get-and-Clean-Samsung-Data
==========================

The goal of this project is to get and clean data from a study using Samsung Galaxy S Smartphones found at http://archive.ics.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.
Anyone running the code in this repo will need to download and unzip the files (UCI HAR Dataset) to get the files referred to in the R program. 

A basic discussion of the data collection comes from the original Readm:

>The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

>###For each record it is provided:

>- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
>- Triaxial Angular velocity from the gyroscope. 
>- A 561-feature vector with time and frequency domain variables. 
>- Its activity label. 
>- An identifier of the subject who carried out the experiment.


In this repo, in addition to this README, you will find two other files:
CodeBook.md which will describe all of the variables in this data, the data, and the transformations to clean up the data. 
An R script called run_analysis.R where the actual transformations are performed, variables are renamed to follow a new convention, and the final tidy data set is produced.

The data used by this repo was provided by:

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.