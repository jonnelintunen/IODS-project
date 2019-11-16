#Jonne Lintunen, 16/11/2019 (dd/mm/yyyy). This is a R Script for creating dataset for IODS course week 2 exercise (logistic regression). Data is from https://archive.ics.uci.edu/ml/datasets/Student+Performance  

getwd()
setwd("/Users/jonnelintunen/Desktop/IODS-project/data")
getwd()

#Reading the datasets 
student_mat <- read.table("student-mat.csv", header = T, sep = ";")     #395 observation (students) and 33 different variables, for example age, family size, mother's and fatrher's job...
student_por <- read.table("student-por.csv", header = T, sep = ";" )     #649 obs. (students) and same variables as in stundent_mat

#Merging the datasets
join_by <- c("school", "sex", "age", "address", "famsize", "Pstatus", "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery","internet")
mat_por <- inner_join(student_mat, student_por, by = join_by, suffix = c(".mat", ".por"))

#Combining duplicated variables 
colnames(mat_por)
alc <- select(mat_por, one_of(join_by))

notjoined_columns <- colnames(student_mat)[!colnames(student_mat) %in% join_by]
notjoined_columns

for (column_name in notjoined_columns) {
  two_columns <- select(mat_por, starts_with(column_name))
  first_column <- select(two_columns, 1)[[1]]
  
  if(is.numeric(first_column)) {
    alc[column_name] <- round(rowMeans(two_columns))
  } else {
    alc[column_name] <- first_column
  }
}

#Creating high_use -variable with mutate-function
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)
alc <- mutate(alc, high_use = alc_use > 2)

glimpse(alc)     #382 obs. and 35 var. 

write.table(alc, file = "alc.txt")




