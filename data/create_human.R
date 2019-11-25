#Jonne Lintunen, 24/11/19 (dd/mm/yy). This is a R Script for creating dataset for IODS course week 5 exercise.  

#Reading the datasets
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

#Structure and summary of the datasets
str(hd)
str(gii)
summary(hd)
summary(gii)

#Renaming columns 
colnames(hd)[1] <- "HDI_Rank"
colnames(hd)[3] <- "HDI"
colnames(hd)[4] <- "Life_Exp"
colnames(hd)[5] <- "Edu_Exp"
colnames(hd)[6] <- "Edu_Mean"
colnames(hd)[7] <- "GNI"
colnames(hd)[8] <- "GNI_minus_HDI"

colnames(gii)[1] <- "GII_Rank"
colnames(gii)[3] <- "Gender_Ineq"
colnames(gii)[4] <- "Mat_Mort"
colnames(gii)[5] <- "Ado_Birth"
colnames(gii)[6] <- "Parliament"
colnames(gii)[7] <- "Second_Edu_F"
colnames(gii)[8] <- "Second_Edu_M"
colnames(gii)[9] <- "Labour_F"
colnames(gii)[10] <- "Labour_M"

#Creating new variables with mutate function
gii <- mutate(gii, Second_Edu_Ratio = (Second_Edu_F / Second_Edu_M))
gii <- mutate(gii, Labour_Ratio = (Labour_F / Labour_M))

#Joining hd and gii datasets together
human <- inner_join(hd, gii, by = "Country", suffix = c(".hd", ".gii"))

#Saving the dataset
write.table(human, file = "human.txt" )






