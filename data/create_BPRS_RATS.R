#Jonne Lintunen, 9/12/19 (dd/mm/yy). This is a RScript for the IODS course week 6 exercise. Data is 
#downloaded to local folder from Kimmo Vehkalahti's GitHub repository. 

BPRS <- read.table("/Users/jonnelintunen/Desktop/IODS-project/data/BPRS.txt", header = T, sep = " ")
str(BPRS)

RATS <- read.table("/Users/jonnelintunen/Desktop/IODS-project/data/rats.txt", header = T, sep = "\t")
str(RATS)

#Categorical variables are: treatment (BPRS dataset), subject (BPRS dataset) and Group (RATS dataset). 
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)
RATS$Group <- factor(RATS$Group)

#Converting to long forms
BPRSlong <-  BPRS %>% gather(key = week, value = bprs, -treatment, -subject)
RATSlong <- RATS %>% gather(key = Time, value = Weight, -ID, -Group)

#Adjusting variables
BPRSlong <- BPRSlong %>% mutate(week = as.integer(substr(BPRSlong$week, start = 5, stop = 5)))
RATSlong <- RATSlong %>% mutate(Time = as.integer(substr(RATSlong$Time, start = 3, stop = 5)))

write.table(BPRSlong, file = "BPRSlong.txt")
write.table(RATSlong, file = "RATSlong.txt")


















