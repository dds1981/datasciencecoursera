#Install relevant packages
install.packages(c("dplyr","reshape2","tidyr"))

#Issue Library commands
library(dplyr)
library(reshape2)
library(tidyr)



#Clear Environment
rm(list=ls())

#Extract Data

#Import Test Data
Y_Test<-read.table("./UCI HAR Dataset/test/Y_test.txt")
S_Test<-read.table("./UCI HAR Dataset/test/subject_test.txt")
X_Test<-read.table("./UCI HAR Dataset/test/X_test.txt")
Test_Data<-cbind(Y_Test,S_Test,X_Test)

#Import Train Data
Y_Train<-read.table("./UCI HAR Dataset/train/Y_train.txt")
S_Train<-read.table("./UCI HAR Dataset/train/subject_train.txt")
X_Train<-read.table("./UCI HAR Dataset/train/X_train.txt")
Train_Data<-cbind(Y_Train,S_Train,X_Train)

#Combine the Test and Train Data (RBind)
HAR_Data<-rbind(Test_Data,Train_Data)

#Add the Column Labels to the Combined Data Set
Features <- read.table("./data/UCI HAR Dataset/features.txt")
FeatureNames <- c("Activity","Subject", as.character(Features$V2))
FeatureNames<-make.names(FeatureNames,unique=TRUE)
HAR_Data<-setNames(HAR_Data, FeatureNames)

# Create indices of the mean and std columns, combine the two indices,
# and create an index of integers in numerical order to use with  the
# dplyr select command

index1<-FeatureNames[grepl("*mean\\...*",FeatureNames)]
index2<-FeatureNames[grepl("*std\\...*",FeatureNames)]
index3 <-c(index1,index2)
index4<-sort(match(index3,names(HAR_Data)))

# Extract desired columns into a new data table using dplyr's select command
HAR_Data2<-select(HAR_Data, 1:2,index4)

# Sort the data table by Activity and Subject (arrange())
HAR_Data2<-arrange(HAR_Data2,Activity,Subject)

#Change the Activities from numbers words
ActivityNames<-read.table("./data/UCI HAR Dataset/activity_labels.txt")
ActivityNames$V2<-gsub("[[:punct:]]","",ActivityNames$V2)
HAR_Data2[,1]<-as.character(factor(HAR_Data2[,1],labels=ActivityNames$V2))

#Remove Punctuation from the Column Labels
HAR_Data2<-setNames(HAR_Data2,gsub("[[:punct:]]","",names(HAR_Data2)))

# Create the final tidy data set grouped by Activity and Subject
HAR_Data2$index_column <- paste(HAR_Data2$Activity, HAR_Data2$Subject, sep="_")
character_vector=as.character(names(HAR_Data2[ , 3:68]))
melt_frame=melt(HAR_Data2, id="index_column", measure.vars=character_vector)
tidyHAR_Data=dcast(melt_frame, index_column~variable, mean)
tidyHAR_Data<-separate(tidyHAR_Data, index_column, into=c("Activity","Subject"))
tidyHAR_Data<-arrange(tidyHAR_Data, Activity, as.numeric(Subject))



#Write the tidy data to a text file
write.table(tidyHAR_Data, "tidyHAR_Data.txt", sep=" ", row.names=FALSE)


