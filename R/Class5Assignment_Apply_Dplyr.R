#Questions for apply and dplyr family 
head(iris)
?iris

#Find the sum of each column and confirm if the sum is greater than 800 or not
#Hint: create a custom function to find the sum and compare it with 800, 
#and apply the function on each numerical column

#Find the sum / mean / median of Sepal Length species-wise

#For all the flowers having sepal width > 3.0, find the number of flowers in each species

#Count how many different petal widths are there in each species.  
#Soln
library(dplyr)
iris%>%group_by(Species)%>%summarise(n_distinct(Petal.Width))

#Titanic Data set-------------------------------------------------------------

#Q. Find the proportion survived of males and females survived
aggregate(Survived ~ Sex, data=train, FUN=function(x) {round(sum(x)/length(x),digits=2)})

#Q. Find the proportion survived of males and females
aggregate(Survived ~ Pclass, data=train, FUN=function(x) {round(sum(x)/length(x),digits=2)})

#Q. Find the proportion of people survived passenger class wise and sex wise
aggregate(Survived ~ Pclass + Sex, data=train, FUN=function(x) {round(sum(x)/length(x),digits=2)})

#Q. Strip off the title from the names of the passengers, and create a sep col named title.

#Q. Ultimately we want only 4 levels in this col: Miss Mr. Mrs and Master
train$Title[train$Title %in% c('Lady', 'the Countess', 'Mlle')] <- 'Miss'
#if train$title is one among c('Lady', 'the Countess', 'Mlle') then give true / false
train$Title[train$Title %in% c('Capt', 'Don', 'Major', 'Sir', 'Col', 'Jonkheer', 'Rev', 'Dr') & train$Sex == "male" ] <- 'Mr'
train$Title[train$Title %in% c('Dona','Lady',"Dr","Mme", 'Ms') & train$Sex == "female"] <- 'Mrs'


#hflights------------------------------------------------------------------------------------------
library(hflights)

#How many flights are not cancelled? Hint: use var cancellation code

#Combine year month and day variables to create a date column

#Find the maximum AirTime for all flights whose Departure delay is not NA

#Find per-carrier mean of arrival delays and arrange them in increasing / decreasing order

#How many airplanes only flew to one destination from Houston? 
# Hint: each tail number represents 1 airplane.
