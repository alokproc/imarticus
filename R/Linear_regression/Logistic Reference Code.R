setwd("C:/Users/User02/Google Drive/Business Analytics/Business Analytics Video/Moodle Upload/7. Logistic regression/Class Room Case Study/")
Data <- read.csv("titanic.csv")
#View the Data
View(Data)

#Check the missing values and the mean, madian, mode
summary(Data)

#Histogram to see how the data is skewed
hist(Data$age)

#replacing the NA values for variable 1 with 29
Data$age[is.na(Data$age)]=29

#Check if the missing values are replaced
summary(Data)

#Since we have handled the missing values, lets have a look at the data
head(Data)

#As seen in the data, some of our variables are categorical, which we need to create as a dummy variables first 
Data$female<-ifelse(Data$sex=="female",1,0)
Data$embarked_s<-ifelse(Data$embarked=="S",1,0)
Data$embarked_c<-ifelse(Data$embarked=="C",1,0)

#Checking the dummy variables
head(Data)

#removing the categorical columns(3,4,9)(i.e Names, sex and embarked)
final_data <- Data[ -c(3,4,9) ]

#lets check our final data
head(final_data)

#Since all the values are either continuous or binary we can now begin with the analysis process
#we first start with Univariate Analysis
bx = boxplot(final_data$age)
bx$stats
# Getting the quantile values
quantile(final_data$age, seq(0,1,0.02))

#Checking the quantile values
bx$stats

#Based on the boxplot outliers we are capping below 4% & above 96%
final_data$age<-ifelse(final_data$age>=52,52,final_data$age)
final_data$age<-ifelse(final_data$age<=4,4,final_data$age)

#Checking the outlier
boxplot(final_data$age)

#lets see the outliers for fare as well
boxplot(final_data$fare)
bx$stats

#quantile values for fare
bx$stats
quantile(final_data$fare, seq(0,1,0.02))

#fare capping at 96 percentile
final_data$fare<-ifelse(final_data$fare>=136,136,final_data$fare)
boxplot(final_data$fare)

#Now lets check do the bi-variate analysis just to analyze the data
library(car)
scatterplot(final_data$age,final_data$survived)

#survived vs fare
scatterplot(final_data$fare,final_data$survived)

#lets divide the data into test and train
set.seed(222)
t=sample(1:nrow(final_data),0.7*nrow(final_data))
t_train=final_data[t,]
t_test=final_data[-t,]

#checking the multi-collinearity
library(car)
mod<- lm(survived ~ ., data=t_train)
t = vif(mod)
sort(t, decreasing = T)

#Since all the variable are below the threshold of 5, we can proceed with the model
mod1 <- glm(as.factor(survived) ~ ., family="binomial", data=t_train)
summary(mod1)

#instead of removing all these variables one by one, we use the step function, which automatically calculated the best equation
stpmod = step(mod1, direction = "both")
formula(stpmod)
summary(stpmod)

#checking the probability for each observation by creating a variable names score
mod2 <- glm(as.factor(survived) ~ pclass + age + sibsp + female + embarked_c, family="binomial", data=t_train)
summary(mod2)
t_train$score=predict(mod2,newdata=t_train,type = "response")
head(t_train$score)
tail(t_train$score)

#Lets try to analyse the confusion matrix and model accuracy
library(lattice)
library(ggplot2)
library(caret)
library(e1071)
prediction<-ifelse(t_train$score>=0.6,1,0)
confusionMatrix(prediction,t_train$survived,positive = "1")

##Mcfadden test
library(pscl)
pR2(mod2)

# Concordance Test #
library(InformationValue)
library(caret)
concor <- Concordance(t_train$survived,t_train$score)
concor

#lets check the AUC and ROC
##AUC
library(InformationValue)
plotROC(actuals = t_train$survived,predictedScores = as.numeric(fitted(mod2)))
ks_plot(actuals = t_train$survived,predictedScores = as.numeric(fitted(mod2)))
ks_stat(actuals = t_train$survived,predictedScores = as.numeric(fitted(mod2)))
t_test$score2= predict(mod2, t_test, type="response")
View(t_test)
