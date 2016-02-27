# 1 read tables
X_train<-read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")
X_test<-read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")
features<-read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt")
activity_label<-read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")

# look for dim of each data and merge it
dim(y_train);dim(X_train)
dim(y_test);dim(X_test)
train<-cbind(y_train,X_train)
test<-cbind(y_test,X_test)
data<-rbind(train,test) #this is the "total" data set

# 2 extract measurements on the mean and standard deviation
idx=sort(c(grep("mean()",features[,2],fixed=T),grep("std()",features[,2],fixed=T)))
data_selected<-data[,c(1,idx+1)]  #1 is label, following is mean and std

# 3 name the activities in the data set
data_merged<-merge(activity_label,data_selected,by.x="V1",by.y="V1")
data_merged<-data_merged[,2:dim(data_merged)[2]]

# 4 labels the data set with variable names
names(data_merged)<-c("label",as.character(features[idx,2]))