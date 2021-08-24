library(faraway)
library(ggplot2)
library(lme4)
library(lmerTest)
library(plyr)
library(dplyr)
library(data.table)
library(tidyr)
library(reshape2)


#GLM Model - Student Data

student <- read.csv("C:\\Users\\adamk\\Desktop\\VCU School Work - Graduate\\VCU DAPT Course info\\Practicum Work\\Data\\Student_main_cleanup.csv")
View(student)


#Poisson Regression
mymodel <- glm(Step2 ~ M1_Avg + M2_Avg + 
                 Total + M1_Exam_Avg + M2_Exam_Avg + PracScore + TotalGPA + AvgShelfScore,
               family="poisson",data=student)

summary(mymodel)

#Check for overdispersion
disperse <- glm(Step2 ~ M1_Avg + M2_Avg + 
                  Total + M1_Exam_Avg + M2_Exam_Avg + PracScore + TotalGPA, AvgShelfScore,
                family="quasipoisson",
                data=student)
summary(disperse)

#Overall model test (Deviance Test: higher values of deviance indicate a worse fit)
#Null hypothesis: Model is correctly specified
pchisq(mymodel$deviance,df=mymodel$df.residual,lower.tail=FALSE)

#Effect Tests
library(car)
Anova(mymodel,type=3)

#Diagnostics
plot(mymodel)

#----------------------------------------------------------------------------------------------

#Student Data Set - Linear Model
student3 <- read.csv("C:\\Users\\adamk\\Desktop\\VCU School Work - Graduate\\VCU DAPT Course info\\Practicum Work\\Data\\Student_main_cleanup.csv")

#Usual linear model
reg <- lm(Step2~M1_Exam_Avg+M2_Exam_Avg+PracScore+M1_Avg+M2_Avg+AvgShelfScore+AvgM1OSCE+AvgM2OSCE,
          data=student3)
summary(reg)

plot(reg)

#--------------------------------------------------------------------------------------------

#Imputed - Mean - Lineaer Model
ImputedStudent <- read.csv("C:\\Users\\adamk\\Desktop\\VCU School Work - Graduate\\VCU DAPT Course info\\Practicum Work\\Data\\Student_main_cleanup2.csv")

sapply(ImputedStudent,function(x) sum(is.na(x)))

#Usual linear model

ImputedStudent$AvgM1OSCE[is.na(ImputedStudent$AvgM1OSCE)]<-median(ImputedStudent$AvgM1OSCE,na.rm=TRUE)
ImputedStudent$AvgM2OSCE[is.na(ImputedStudent$AvgM2OSCE)]<-median(ImputedStudent$AvgM2OSCE,na.rm=TRUE)
ImputedStudent$M1_Exam_Avg[is.na(ImputedStudent$M1_Exam_Avg)]<-median(ImputedStudent$M1_Exam_Avg,na.rm=TRUE)
ImputedStudent$M2_Exam_Avg[is.na(ImputedStudent$M2_Exam_Avg)]<-median(ImputedStudent$M2_Exam_Avg,na.rm=TRUE)
ImputedStudent$M1_Avg[is.na(ImputedStudent$M1_Avg)]<-median(ImputedStudent$M1_Avg,na.rm=TRUE)
ImputedStudent$M2_Avg[is.na(ImputedStudent$M2_Avg)]<-median(ImputedStudent$M2_Avg,na.rm=TRUE)
ImputedStudent$AvgShelfScore[is.na(ImputedStudent$AvgShelfScore)]<-median(ImputedStudent$AvgShelfScore,na.rm=TRUE)
ImputedStudent$Step2[is.na(ImputedStudent$Step2)]<-median(ImputedStudent$Step2,na.rm=TRUE)
ImputedStudent$PracScore[is.na(ImputedStudent$PracScore)]<-median(ImputedStudent$PracScore,na.rm=TRUE)

reg <- lm(Step2~AvgM1OSCE+AvgM2OSCE+PracScore+M1_Avg+M2_Avg+AvgShelfScore+M1_Exam_Avg+M2_Exam_Avg,
          data=ImputedStudent)

summary(reg)

plot(reg)

View(ImputedStudent)

