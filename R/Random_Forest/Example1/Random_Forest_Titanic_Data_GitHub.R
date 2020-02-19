################################################################################################################################################
## Objective: Machine learning of Titanic data's survival classification with ensemble methods (random forest and boosted decision tree)       #
## Data source: titanic.csv                                                                                                                    #
## Please install "rpart" package: install.packages("rpart") for decision trees                                                                #
## Please install "e1071" package: install.packages("e1071")                                                                                   #
## Please install "caret" package: install.packages("caret") for K-Fold Cross Validation                                                       #
## Please install "rpart.plot" package: install.packages("rpart.plot") for Decision Tree Visualization                                         #
## Please install "randomForest" package: install.packages("randomForest")                                                                     #
################################################################################################################################################

## load the library
library(randomForest)
#install.packages("randomForest")

## DATA EXPLORATION AND CLEANING
## load the Titanic data in R
## Be sure your working directory is set to bootcamp base directory
titanic.data <- read.csv("C:/Users/muckam/Desktop/DataScienceBootcamp/Datasets/titanic.csv", header=TRUE)
## explore the data set
head(titanic.data)
dim(titanic.data)
str(titanic.data)
summary(titanic.data)

## remove PassengerID, Name, Ticket, and Cabin attributes. Removing columns 1,4,9 and 11
titanic.data <- titanic.data[, -c(1, 4, 9, 11)]

colnames(titanic.data)

## Cast target attribute to factor. Absolutely needed, otherwise it will be numeric, 0 or 1. It will do regression if its numeric, not trees
titanic.data$Survived <- as.factor(titanic.data$Survived)

## there are some NAs in Age, fill them with the median value. na.rm=TRUE if its a missing value
titanic.data$Age[is.na(titanic.data$Age)] <- median(titanic.data$Age, na.rm=TRUE)

## BUILD MODEL
## randomly choose 70% of the data set as training data
set.seed(27)
train.index <- sample(1:nrow(titanic.data), 0.7*nrow(titanic.data)) #nrow is last row, sampling 70% of them
titanic.train <- titanic.data[train.index,] #select train rows
dim(titanic.train)
summary(titanic.train$Survived)
## select the other 30% as the testing data
titanic.test <- titanic.data[-train.index,] #select test rows due to -
dim(titanic.test)
summary(titanic.test$Survived)

## You could also do this
#random.rows.test <- setdiff(1:nrow(titanic.data),random.rows.train)
#titanic.test <- titanic.data[random.rows.test,]

## Fit decision model to training set
titanic.rf.model <- randomForest(Survived ~ ., data=titanic.train, importance=TRUE, ntree=500)
print(titanic.rf.model)

varImpPlot(titanic.rf.model) #Tells you what varibles are important, use when add Importance = TRUE. 
#No matter when the variable comes in on average this is the best reduction in gini value. If features are not in the same order they are weaker.


titanic.rf.model <- randomForest(Survived ~ ., data=titanic.train, mtry=3, ntree=100)
print(titanic.rf.model)

## MODEL EVALUATION
## Predict test set outcomes, reporting class labels
titanic.rf.predictions <- predict(titanic.rf.model, titanic.test, type="response")
titanic.rf.predictions


## calculate the confusion matrix
titanic.rf.confusion <- table(titanic.rf.predictions, titanic.test$Survived)
print(titanic.rf.confusion)
## accuracy
titanic.rf.accuracy <- sum(diag(titanic.rf.confusion)) / sum(titanic.rf.confusion)
print(titanic.rf.accuracy)
## precision
titanic.rf.precision <- titanic.rf.confusion[2,2] / sum(titanic.rf.confusion[2,])
print(titanic.rf.precision)
## recall
titanic.rf.recall <- titanic.rf.confusion[2,2] / sum(titanic.rf.confusion[,2])
print(titanic.rf.recall)
## F1 score
titanic.rf.F1 <- 2 * titanic.rf.precision * titanic.rf.recall / (titanic.rf.precision + titanic.rf.recall)
print(titanic.rf.F1)
# We can also report probabilities
titanic.rf.predictions.prob <- predict(titanic.rf.model, titanic.test, type="prob")
print(head(titanic.rf.predictions.prob))
print(head(titanic.test))

## show variable importance
importance(titanic.rf.model)
varImpPlot(titanic.rf.model)

