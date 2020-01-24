#Logistic Regression
#based on MLE - maximum likelihood estimation

read.csv("C:\\Users\\Vaibhav\\Desktop\\BA\\simplilearn\\Datasets\\Lesson 11 Classification Ex 3.csv")->telecom
View(telecom)

#Data Preprocessing
colSums(is.na(telecom))

#split into train and test
library(caTools)
set.seed(20)
sample.split(Y = telecom$Churn, SplitRatio = .7)->split
training = telecom[split,]
test = telecom[!split,]

summary(training)

#create the logistic reg mode
log_model = glm(formula = Churn~., data = training, family = "binomial")
summary(log_model)

step(log_model, direction = "both")->mod
summary(mod)
#Lower the AIC value better my model
#Remove the insignificant vars from the model
#there should be no multi-collinearity - check using vif fn the way we applied for Li Re

#Model interpretation
#log(p/1-p) = ax1 + bx2 + cx3 +... +Constant
#p = e^(ax1+ bx2+cx3+... + constant)/(1+e^(ax1+bx2+cx3+...+constant))
mod$fitted.values #gives the probability computed for the training data
mod$coefficients
#-ve coefficient of COntract Renewal means, as Contract renewal increases, 
#   the probability(y=1) decreases

tapply(mod$fitted.values,training$Churn,summary)

#predict the prob values for test data
predict(mod, test,type = "response")->p
p #prob values for each and every customer in the test data

#assume t = .5
test_prediction = ifelse(p>.5,1,0)
test_prediction #predicted values of DV

#Accuracy of data - confusion matrix
table(actual = test$Churn, predicted = test_prediction)->tab
tab
accuracy = (tab[1,1] + tab[2,2])/nrow(test)
accuracy

library(ROCR)
ROCRpred = prediction(predictions = mod$fitted.values, labels = training$Churn)
ROCRpred@predictions #predicted prob values
ROCRpred@labels #actuals
ROCRpred@cutoffs #threshold cut-offs
ROCRpred@cutoffs
ROCRpred@fp #number of false +ve cases at the above mentioned cut-offs
ROCRpred@tp 
ROCRpred@tn
ROCRpred@fn
ROCRpred@n.pos#total number of actual +ves
ROCRpred@n.neg
ROCRpred@n.pos.pred # number of +ve predictions
ROCRpred@n.neg.pred

ROCRperf = performance(prediction.obj = ROCRpred, "tpr", "fpr")
plot(ROCRperf, colorize = T, print.cutoffs.at = seq(0, 1, .05), text.adj = c(-.2, 1.7))

#threshold .18

#assume t = .5
test_prediction = ifelse(p>.18,1,0)
test_prediction #predicted values of DV

table(actual = test$Churn, predicted = test_prediction)->tab
tab

#computing the auc for our test data
ROCRpred = prediction(predictions = p, labels = test$Churn)
ROCRperf = performance(prediction.obj = ROCRpred,measure = "auc")
ROCRperf
unlist(ROCRperf@y.values)
#Best value of auc = 100% 
#worst value of auc = 50%
#area>70% is considered to b a good model

#If there are categorical columns in our data having 2 categories, then it is easy to label them 0 and 1
#but what if there are more than 2 categories - say n categories, then we will have n-1 dummy variables
nrow(telecom)
telecom$class = c(rep("A", 1111), rep("B", 1111), rep("C", 1111)) 
telecom$class = as.factor(telecom$class)
levels(telecom$class)
table(telecom$class)
y = telecom$Churn
mat = model.matrix(Churn~., data = telecom)
View(mat)
mat = mat[,-1]
mat = cbind(y, mat)
colnames(mat)[1] = "Churn"
as.data.frame(mat)->telecom
telecom$classB = NULL
telecom$classC = NULL

#Decision tree-------------------------------------------------------------------

head(training)

library(rpart)
model = rpart(as.factor(Churn)~., data = training)
#to construct the regression model, y var has to be continuous
library(rpart.plot)
prp(model)
model$variable.importance

#A fully grown decision tree has high complexity and is prone to over-fitting.
# Over-fitting means that the accuracy will be very high on training data but 
# very poor on test data. 
#the errror due to over-fitting is called as variance error 
# (when we vary the data / change the data, the model will under-perform)

#so there are 2 kinds of errors: bias error and variance error
# bias error measures the error on the training - as we make our model more complex,
# the accuracy on the training data will become high.
# but as the model becomes extremely complex it will start over-fitting on the 
# training data and hence under-perform on the 
# test data / unknown data (leading to variance error)



#pruning the tree
plotcp(model)
prune(tree = model, cp = .015)->mod
prp(mod)

predict(object = mod,newdata = test, type = "class") -> pr
pr

table(predicted = pr, actual = test$Churn)->tab
tab
accuracy = (tab[1,1] + tab[2,2])/(tab[1,1]+tab[1,2]+tab[2,1]+tab[2,2])
accuracy

#random forest model
library(randomForest)
set.seed(100)
mod = randomForest(as.factor(Churn)~., data = training, ntree = 500, mtry = 3)
# mtry = (p^.5) can be a good value of mtry, where p is the number of IVs
predict(object = mod,newdata = test, type = "class") -> pr
pr

table(predicted = pr, actual = test$Churn)->tab
tab
accuracy = (tab[1,1] + tab[2,2])/(tab[1,1]+tab[1,2]+tab[2,1]+tab[2,2])
accuracy

varImpPlot(mod)

#Boosting - another ensemble technique
#This is also called as stage-wise additive modeling. 
# In contrast to random forests,
# where trees are trained in parallel, in boosting the trees are 
# trained one after the other.

#Unline fitting a single large decision tree which is prone to over-fitting,
#boosting tries to learn slowly and fitting small 
# decision trees of depth d only on residuals. 

library(xgboost)
library(Matrix)

#create a sparse matrix
View(training)
sparse_matrix = sparse.model.matrix(as.factor(Churn)~., training)
View(as.matrix(sparse_matrix))
sparse_matrix = sparse_matrix[,-1]

sparse_matrix_test = sparse.model.matrix(as.factor(Churn)~. -1, test)
View(as.matrix(sparse_matrix_test))

#convert the data into xgboost format
dtrain = xgb.DMatrix(data = sparse_matrix,label = training$Churn, missing = NA)
dtrain

dtest = xgb.DMatrix(data = sparse_matrix_test,label = test$Churn,missing = NA)
getinfo(dtrain, "label")
getinfo(dtest, "label")

mod = xgb.train(data = dtrain, eta = .01, max_depth = 1, objective = "binary:logistic", nrounds = 100)
#eta is the learning rate - the rate at which the model will slowly learn from each tree
# lower the learning rate, more the number of trees, we need to construct to get an accurate model
#nrounds: number of rounds / trees to be constructed

watchlist = list(train = dtrain, test = dtest)
mod = xgb.train(data = dtrain, eta = .001, max_depth = 5, watchlist = watchlist, 
                objective = "binary:logistic", nrounds = 1000, verbose =3, 
                early_stopping_rounds = 50)
#early_stopping_rounds: once my error rate becomes stable for 50 rounds, 
#then stop making the further decision trees

predict(mod,dtest)->pr
pr
table(predicted = pr>.5, actual = test$Churn)->tab
tab
accuracy = (tab[1,1] + tab[2,2])/(tab[1,1]+tab[1,2]+tab[2,1]+tab[2,2])
accuracy

#Naive Bayes 
#Naive Bayes algo is based on Bayes theorem. It is based on the assumption that
#IVs are independent of each other. 
#Another assumption is - that the continuous variables in our data should follow 
#  normal distribution


#In real life Naive Bayes algo is widely used for problems like:
# - classifying emails into spam or ham
# - Medical diagnosis - given a list of symptoms, predict whether a person has 
# disease X or not 
# - Weather prediction - based on temp, humidity we need to decide 
# whether it's gonna rain or not

#Normalizing the continuous vars
normalize = function(x) #takes a vector x as the argument
{
  return((x- min(x))/(max(x)-min(x)))
}

head(training)

as.data.frame(lapply(training[,-c(1,3,4)], normalize))->df
View(df)
cbind(training[,c(1,3,4)], df)->training_nb

as.data.frame(lapply(test[,-c(1,3,4)], normalize))->df
cbind(test[,c(1,3,4)], df)->test_nb
View(test_nb)

head(training_nb)
library(e1071)
nb = naiveBayes(x = training_nb[,-1], y = as.factor(training_nb$Churn))
predict(object = nb,newdata = test_nb, type = "class")->pr #type = "raw" to get the prob values
pr

table(predicted = pr, actual = test$Churn)->tab
tab
accuracy = (tab[1,1] + tab[2,2])/(tab[1,1]+tab[1,2]+tab[2,1]+tab[2,2])
accuracy
#Since Naive Bayes gives us probabilities, it can't be applied for regression problems


#K-NN - K-Nearest Neighbours Algo
#Since KNN algo is an extension of Naive Bayes (i.e internally it 
#   uses the prob calculations using Naive Bayes Model), hence it is 
#   mandatory to use the normalized continuous variables

#it's only applicable on continuous columns, since internally knn uses
#   euclidean distance formula

library(class)
head(training_nb)

pr = knn(train = training_nb[,-c(1,2,3)], test = test_nb[,-c(1,2,3)], cl = training$Churn, k = 9)
#k should ideally be between 0 and 9 and it should be odd, 
#  other-wise there are chances of tie happening
pr
table(predicted = pr, actual = test$Churn)->tab
tab
accuracy = (tab[1,1] + tab[2,2])/(tab[1,1]+tab[1,2]+tab[2,1]+tab[2,2])
accuracy

# try this knn model on iris data - as home work
#KNN can't be applied on regression problems

#Support Vector Machines
#standardize the data
head(training)
as.data.frame(lapply(training[,-c(1,3,4)], scale))->df
head(df)

cbind(training[,c(1,3,4)], df)->training_scaled

as.data.frame(lapply(test[,-c(1,3,4)], scale))->df
head(df)

cbind(test[,c(1,3,4)], df)->test_scaled

library(e1071)
mod = svm(as.factor(Churn)~., data = training_scaled, 
                type = 'C-classification', kernel = "linear")
?svm

predict(mod, test_scaled)->pr
pr
table(predicted = pr, actual = test$Churn)->tab
tab
accuracy = (tab[1,1] + tab[2,2])/(tab[1,1]+tab[1,2]+tab[2,1]+tab[2,2])
accuracy

#creating a non-linear svm model

library(e1071)
mod = svm(as.factor(Churn)~., data = training_scaled, 
          type = 'C-classification', kernel = "radial")
?svm

predict(mod, test_scaled)->pr
pr
table(predicted = pr, actual = test$Churn)->tab
tab
accuracy = (tab[1,1] + tab[2,2])/(tab[1,1]+tab[1,2]+tab[2,1]+tab[2,2])
accuracy

#K-Fold Cross Validation
library(caret)
library(randomForest)

read.csv("C:\\Users\\Vaibhav\\Desktop\\BA\\simplilearn\\Datasets\\Lesson 11 Classification Ex 3.csv")->telecom
View(telecom)
folds = createFolds(y = telecom$Churn, k = 10)
folds

x = folds$Fold01
x

cross_validate = function(x) #each fold as the argument
{
  test_fold = telecom[x,]
  training_fold = telecom[-x,]
  head(training_fold)
  
  set.seed(100)
  mod = randomForest(as.factor(Churn)~., data = training_fold, ntree = 500, mtry = 3)
  # mtry = (p^.5) can be a good value of mtry, where p is the number of IVs
  predict(object = mod,newdata = test_fold, type = "class") -> pr
  pr
  
  table(predicted = pr, actual = test_fold$Churn)->tab
  tab
  accuracy = (tab[1,1] + tab[2,2])/(tab[1,1]+tab[1,2]+tab[2,1]+tab[2,2])
  accuracy #by default the last line of the function is returned
}

lapply(folds, cross_validate)->p
p
#if the accuracy percentage in p is not varying too much - then we'll conclude low-variance error
#but if the accuracy is varying too much - then high variance error - then we'll try out other cv on other models
# Please note making sure our variance error is low is more important bias error.
