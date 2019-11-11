#Jonne Lintunen, 9/11/2019 (dd/mm/yyyy). 
#This is a R script for the week 2 exercise of IODS course. 

#Reading the table from the URL 
?read.table 
table1 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep = "\t", header = T)

#Exploring the dataset
dim(table1) #183 rows and 60 columns
structure(table1) #Structure of the dataset, doesn't tell much to be honest... Last 4 variables are "Age", "Attitude", "Points" and "gender"

#Installing dplyr package from CRAN and loading it to make it available 
install.packages("dplyr")
library(dplyr)

#Creating variables "deep_questions", "stra_questions" and "surface_questions" from table1  
deep_questions <- table1[c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")]
stra_questions <- table1[c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")]
surface_questions <- table1[c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")]

#Calculating mean values from the questions 
deep_questions$deep <- rowMeans(deep_questions)
stra_questions$stra <- rowMeans(stra_questions)
surface_questions$surf <- rowMeans(surface_questions)

#Creating columns "deep", "stra" and "surf"
deep <- select(deep_questions, deep)
stra <- select(stra_questions, stra)
surf <- select(surface_questions, surf)

#Creating "analysis" dataset
analysis <- cbind(table1$gender, table1$Age, table1$Attitude, deep, stra, surf, table1$Points)

#Renaming columns 
colnames(analysis)[1] <- "gender"
colnames(analysis)[2] <- "age"
colnames(analysis)[3] <- "attitude"
colnames(analysis)[7] <- "points"

#Excluding those who had zero points
analysis2 <- subset(analysis, points > 0) #166 obs. and 7 var. Note: There are 166 obs. eventhough the last ID in the dataset is 183 (the IDs remain the same after data manipulation, they are not counting the observations).
analysis <- analysis2

#Saving dataset and testing that it opens 
getwd()
setwd("/Users/jonnelintunen/Desktop/IODS-project/data")
write.table(analysis, file = "learning2014.txt")

setwd("/Users/jonnelintunen/Desktop/IODS-project/data")
test <- read.table("learning2014.txt", header = T)
head(test)

