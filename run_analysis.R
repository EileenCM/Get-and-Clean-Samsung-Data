run_analysis<-function(){
  
  #Step 1  Merges the training and the test sets to create one data set.
  
  testSet<-read.table("x_test.txt",sep="")            #Read test data files.
  activity<-read.table("y_test.txt",sep="")
  subject<-read.table("subject_test.txt",sep="")
  
  testSet<-cbind(activity,subject,testSet)            #Combine test actities and subjects with data collected. 
  
  trainSet<-read.table("x_train.txt",sep="")          #Read training data files.
  activity<-read.table("y_train.txt",sep="")
  subject<-read.table("subject_train.txt",sep="")
  
  trainSet<-cbind(activity,subject,trainSet)          #Combine training activities and subjects with data collected.       
  
  allSet<-rbind(testSet,trainSet)                     #Combine test and training data.
       
  features<-read.table("features.txt",sep="")         #Reads the column variable descriptions.
  featNames<-make.names(features[,2])                 #Take out illegal character symbols to create first round of variable names.
  featNames<-gsub("BodyBody","Body",featNames,fixed=TRUE)  #Correct one know typo in data.  Names will be "cleaned" later.
  
  names(allSet)<-c("activity","subject",featNames)    #Rename the columns.
  
  
  #Step 2  Extracts only the measurements on the mean and standard deviation for each measurement.
  
       #The features.info.txt file discusses 17 different variables that were calculated from the original observations.
       #I will assume that only the first application of mean() as one of these calculated variables is to be included in the final dataset.
       #This means that the last 7 columns (which are gravityMeans calculated from the angle) will be eliminated, since angle() is an 
       #    function on the same "level" as mean, so the gravityMean is a secondary calculation.
       #I am removing them first because it is easy to do so, and will avoid confusion when choosing the mean and standard deviation (std) columns.
  
  allSet<-allSet[,1:556]
  
       #Now I choose only the mean and std columns.
  
  indexer<-grep(".mean|.std",names(allSet))
  allSet<-allSet[,c(1,2,indexer)]                        #Remember to keep activity and subject!
  index2<-grep("meanFreq",names(allSet),invert=TRUE)
  allSet<-allSet[,index2]                                #Take out meanFreq as this is a different variable than mean.
  
  
  #Step 3  Uses descriptive activity names to name the activities in the data set.
  
  activNames<-read.table("activity_labels.txt",sep="")
  for (i in 1:6){allSet[,1]<-gsub(activNames[i,1],activNames[i,2],allSet[,1],fixed=TRUE)} 
  
  
  #Step 4  Appropriately labels the data set with descriptive activity names.
  
       #I am just going to do a few substitutions to make the names look a little cleaner.
       #Rather than underscores to separate, I will use capital letters for the beginning of new words/abbreviations.
  
  names(allSet)<-gsub("Acc","Accel",names(allSet),fixed=TRUE)               #A more readable abbreviation
  names(allSet)<-gsub(".","",names(allSet),fixed=TRUE)                      #Removes periods.
  names(allSet)<-gsub("mean","Mean",names(allSet),fixed=TRUE)               #Uses the capitalization convention above.
  names(allSet)<-gsub("std","StanDev",names(allSet),fixed=TRUE)             #Like Mean, and also more readable.
  names(allSet)<-gsub("X","Xdir",names(allSet),fixed=TRUE)                  #X,Y,Z represent the various vectors in component form.  
  names(allSet)<-gsub("Y","Ydir",names(allSet),fixed=TRUE)                  #They show the strength of the measured vectors along that axis.
  names(allSet)<-gsub("Z","Zdir",names(allSet),fixed=TRUE)
  
  
  #Step 5  Creates a second, independent tidy data set with the average of each variables for each activity & each subject.
  
       #Aggregate to create the tidy dataset.
  
  allSet[,3:68]<-as.numeric(allSet[,3:68])
  meanagg<-aggregate(allSet[3:68],by=list(allSet$activity,allSet$subject),FUN=mean)
 
       #Rename all columns
       #A different naming convention here, since mean is an aggregate of the original values.
  
  names(meanagg)<-c("activity","subject",paste("mean",holdNames[3:68],sep="_")) 
 
  write.table(meanagg,file="Mean_Samsung_data.txt",append=FALSE)
  
   
}