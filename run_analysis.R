### QN 1 ####
features <- read.table("~/features.txt", quote="\"", comment.char="")
subject_train <- read.table("~/train/subject_train.txt", quote="\"", comment.char="")
X_train <- read.table("~/train/X_train.txt", quote="\"", comment.char="")
y_train <- read.table("~/train/y_train.txt", quote="\"", comment.char="")
colnames(subject_train) <- c("subject")
colnames(y_train) <- c("y")
colnames(X_train) <- features$V2
train <- cbind(subject_train,X_train,y_train)

subject_test <- read.table("~/test/subject_test.txt", quote="\"", comment.char="")
X_test <- read.table("~/test/X_test.txt", quote="\"", comment.char="")
y_test <- read.table("~/test/y_test.txt", quote="\"", comment.char="")
colnames(subject_test) <- c("subject")
colnames(y_test) <- c("y")
colnames(X_test) <- features$V2
test <- cbind(subject_test,X_test,y_test)

data <- rbind(train,test)



### QN 2 ###
df1 <- data[ , grepl( "mean|std" , names( data ) ) ]
data <- cbind(data$subject,df1,data$y)
colnames(data)[colnames(data) == 'data$y'] <- 'y'
colnames(data)[colnames(data) == 'data$subject'] <- 'subject'


## QN 3 ## 
activity_labels <- read.table("~/activity_labels.txt", quote="\"", comment.char="")
colnames(activity_labels) <- c('y', 'Activity')
data <- merge(data,activity_labels)
data <- subset(data, select=-c(y))

## QN 4: labelled ##

## QN 5 ##
library(dplyr)

data1 <- data %>%
  group_by(Activity,subject) %>%
  summarize_all(mean)



write.table(data1,"~/final.txt",row.names=FALSE)



