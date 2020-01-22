rm(list = ls())
#Import Data

setwd("C:/Users/User02/Google Drive/Business Analytics/Business Analytics Video/Moodle Upload/6. Linear Regression/Case study/Updated Case/")

Data<-read.csv("Regression.csv")

#Check the missing values and the mean, median, mode

summary(Data)


hist(Data$Age)

# replacing the NA values for variable Age with mean 39

Data$Age[is.na(Data$Age)]=39

#Check if the missing values are replaced from the variable Age

summary(Data)


#Since we have handled the missing values, lets have a look at the data

head(Data)

#As seen in the data, four of our variables are categorical, which we need to create as a dummy variables first 

Data$Job.type_employed<-as.numeric(Data$Job.Type=="Employed")

Data$Job.type_retired<-as.numeric(Data$Job.Type=="Retired")

Data$Job.type_unemplyed<-as.numeric(Data$Job.Type=="Unemployed")

Data$Married_y<-as.numeric(Data$Marital.Status=="Yes")

Data$Education_secondary<-as.numeric(Data$Education=="Secondry")

Data$Education_gra<-as.numeric(Data$Education=="Graduate")

Data$Metro_y<-as.numeric(Data$Metro.City=="Yes")

#Checking the dummy variables

head(Data)
#removing the categorical columns(2,3,4,5)

final_data <- Data[ -c(2,3,4,5) ]

set.seed(56952)

#lets check our final data

head(final_data)

#we first start with Univariate Analysis, outlier detection of independent variables using a box plot

par(mfrow=c(1,2))

bx = boxplot(final_data$Age)

#lets check the distribution of the variable age

quantile(final_data$Age, seq(0,1,0.02))

#Checking the quantile values

bx$stats

#Since the 98th percentile is 57, we cap the outliers with the same value

final_data$Age<-ifelse(final_data$Age>60,57,final_data$Age)

#box plot to again check the outliers

boxplot(final_data$Age)

#Now checking the outlier for our other variable sign in since days

boxplot(final_data$Signed.in.since.Days.)

#Outlier treatment for signed in since

quantile(final_data$Signed.in.since.Days., seq(0,1,0.02))

#Thus, capping the value of values less than 45 with 48(8 percentile)

final_data$Signed.in.since.Days.<-ifelse(final_data$Signed.in.since.Days.<45,48,final_data$Signed.in.since.Days.)

#boxplot to check the outliers

boxplot(final_data$Signed.in.since.Days.)

#now lets check the dependent variable

par(mfrow=c(1,2))

hist(final_data$Purchase.made, main = 'Dependent')

#boxplot for the dependent 

boxplot(final_data$Purchase.made)

#Now lets check do the bi-variate analysis to check the relationship between variables(Age and Purchase made

library(car)

scatterplot(final_data$Age,final_data$Purchase.made)

#Sign.in.days vs Puchase made

scatterplot(final_data$Signed.in.since.Days.,final_data$Purchase.made)

# since we are done with the EDA, lets check the co-relation

cor(final_data)

#checking the multi-collinearity

final_data1<- lm(Purchase.made~.,data=final_data)

vif(final_data1)

#Since all the variable are not below the threshold of 5, we need to correct the model, lets remove Education_secondry variable first

final_data2<- lm(Purchase.made~Age + Signed.in.since.Days. + 
                   Married_y  +  Job.type_retired  + Job.type_unemplyed +Education_gra+Metro_y,data=final_data)


vif(final_data2)

#Graduation was highly co-linear with the other variables, lets verify once again using a step function

step(final_data1)

final_data3<- lm(Purchase.made~Age + Signed.in.since.Days. + 
                   Married_y  +  Job.type_retired  + Job.type_unemplyed +Education_gra+Metro_y,data=final_data)

summary(final_data3)

final_data4<- lm(Purchase.made~ Signed.in.since.Days. + 
                   Married_y   + Job.type_unemplyed +Education_gra+Metro_y,data=final_data)

summary(final_data4)

#Now since we have the best fit equation, lets try to check with the assumptions for a linear model

#loading package lmtest
library(lmtest)

par(mfrow=c(2,2))
plot(final_data4)

# Quantile Values

quantile(final_data$Purchase.made, seq(0,1,0.02))


# Lets consider 4% and 96% as the cut-off

final_data_new = final_data[(final_data$Purchase.made >=510 & final_data$Purchase.made <=13500),]

# Lets re-run the model on this filtered data

mod2 <- lm(Purchase.made~ Signed.in.since.Days. + 
             Married_y  +Education_gra+Metro_y+Job.type_unemplyed,data=final_data_new)

summary(mod2)

#final linear equation

mod2 <- lm(Purchase.made~ Signed.in.since.Days. + 
             Married_y  +Education_gra+Metro_y,data=final_data_new)

summary(mod2)

# Now analysing the residual plot

par(mfrow=c(2,2))

plot(mod2)

#1 - Autocorrelation

durbinWatsonTest(mod2)

#2 - Normality of errors

hist(residuals(mod2))

#3 - Homoscedasticity

plot(final_data_new$Purchase.made, residuals(mod2))

#Checking the cook's distance
library(predictmeans)

cooksd=CookD(mod2)

