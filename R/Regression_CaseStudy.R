
#Assumptions of linear regression
#1. no multicollinearity
#2. residuals should form a normal distribution

library(MASS)
?Boston
head(Boston)
#if factor variables with more than 2 levels, then make dummy vars using ifelse statement


#check outliars
x=boxplot(Boston$medv)
x$out
index<-Boston$medv %in% x$out #returns true for medv where-ever outliars exist in medv
index
sum(index)
Df = Boston[-which(index),]

#1. Check correlation
correlation_Boston = cor(Df)
correlation_Boston

library(corrplot)
corrplot(correlation_Boston)

#2. Split into training and test data
set.seed(10)
library(caTools)
split=sample.split(Y = Df$medv,SplitRatio = .7)

train_Df = Df[split,]
test_Df = Df[!split,]

#3. Run Linear Regression
LM_Df = lm(medv~. , train_Df)
summary(LM_Df)
model = step(object = LM_Df,direction = "both")
summary(model)
#4. Remove the insignificant vars: indus and age
LM_Df = lm(medv~.-age -indus, train_Df)
summary(LM_Df)


#5. Check for multi-collinearity
library(car)
vif(LM_Df)

#check the correlation between IVs
Model2 = lm(medv~crim + zn + chas + nox + rm + dis + ptratio + black + lstat, train_Df) 
            #remove dis, tax, rad
summary(Model2)
vif(Model2)

Model3 = lm(medv~zn + chas + nox + rm + dis + ptratio + black + lstat, train_Df) 
summary(Model3)

Model3=step(object = LM_Df, direction = "backward")

vif(Model3)
summary(resid(Model3))
#mean is approx. = median - residuals forming an approximate normal distribution

formula(Model3) # to get the formula


#5. Do the prediction
predicted_linreg=predict(Model3, test_Df)
test_Df = cbind(test_Df, predicted_linreg)


#6. Check the average error rate
error = predicted_linreg - test_Df$medv
ptage_error = error/test_Df$medv
average_error = mean(ptage_error)
average_error#mean average percentage error

#calculating sse from linear regression
sse = sum(error^2)
sse

#mse
#mape

#calculate sst on training data (y - ymean)^2
sst = sum((train_Df$medv - mean(train_Df$medv))^2)
sst
#calculate R2 on test data
R2 = 1-sse/sst


#7. trying polynomial models
log_model=lm(formula = log(medv)~ chas + nox + rm + dis + ptratio + black + lstat, train_Df)
summary(log_model)
#-try yourself-----------

#Applying SVR Linear ---------------------------------
#Scaling train and test data
scale(train_Df[,-14]) -> training_scaled
scale(test_Df[,-14])->test_scaled
training_scaled = cbind(medv = train_Df$medv, training_scaled)
head(training_scaled)

#Creating the model
library(e1071)
model = svm(formula = medv ~.,
                 data = training_scaled,
                 kernel = 'linear')

#Predicting on test data
predict(object = model, newdata = test_scaled) -> test_Df$predicted_svr_linear

#Finding the SSE
sum((test_Df$predicted_svr_linear - test_Df$medv)^2)->sse
sse
R2 = 1-sse/sst
R2

#Apply SVR Non Linear --------------------------------------------------
#Creating the model
library(e1071)
model = svm(formula = medv ~.,
                 data = training_scaled,
                 kernel = 'radial')

#Predicting on test data
predict(object = model, newdata = test_scaled) -> test_Df$predicted_svr_radial

#Finding the SSE
sum((test_Df$predicted_svr_radial - test_Df$medv)^2)->sse
sse #we notice a sufficient drop in SSE indicating this is a non-linear problem
R2 = 1-sse/sst
R2

#Applying Decision Tree-----------------------------------------------
library(rpart)
head(train_Df)
head(test_Df)
model=rpart(medv ~.,train_Df)

library(rpart.plot)
prp(model)

#pruning the tree
plotcp(model)
prune(tree = model, cp = .011)-> model
prp(model)

#Predicting on test data
predict(object = model, test_Df,)->test_Df$predicted_decTree


#Finding the SSE
sum((test_Df$predicted_decTree - test_Df$medv)^2)->sse
sse
R2 = 1-sse/sst
R2

#Applying random forest----------------------------------------------------
library(randomForest)
set.seed(100)
model = randomForest(medv~., train_Df)
predict(model, test_Df)->test_Df$predicted_rf
varImpPlot(model)

#Finding the SSE
sum((test_Df$predicted_rf - test_Df$medv)^2)->sse
R2 = 1-sse/sst
R2

#Applying xgboost-------------------------------------------------------------
# Boosted Regression Tree
library(xgboost)
library(Matrix)
sparse<-sparse.model.matrix(medv~.-1,data = train_Df)
sparse@Dimnames #gives the row names and col names
#here sparse matrix will convert all the cat. vars into 0s and 1s
#but all the numeric vars will b left as dense
#we can visualize thru following command
as.matrix(sparse)

names(test_Df)
grepl(pattern = "predicted",x = names(test_Df))->p
test_Df[!p]->test_Df
head(test_Df)

#creating the dense matrix
dtrain<-xgb.DMatrix(data=sparse,label=train_Df$medv)
sparse_test<-sparse.model.matrix(medv~.-1,data = test_Df)
View(as.matrix(sparse_test))
dtest<-xgb.DMatrix(data=sparse_test,label=test_Df$medv)
getinfo(dtrain,"label")
getinfo(dtest,"label")#note: get info will give same class as dependent var; Test$Salary is numeric so this will give numeric
test_Df$medv
# Building the model
watchlist=list(train=dtrain,test=dtest)
model_xgb<-xgb.train(data=dtrain,nrounds=11000,objective="reg:linear",verbose = 2,eta=0.001,max_depth=4,watchlist = watchlist,early_stopping_rounds = 20)
#note objective =reg:linear
#since lot of vars, we need to have more trees
#the test error should decrease
#if test error decreases then increases, then it is over-fitting
#try diff values of eta, nrounds, maxdepth to get min test error
#smaller value of lambda will increase the accuracy but requires more trees
model_xgb
predict(model_xgb,dtest)->p
p
sum((p - test_Df$medv)^2)->sse
sse #we notice a sufficient drop in SSE indicating this is a non-linear problem
R2 = 1-sse/sst
R2



#Applying k-fold cross validation to check the variance error of random-forest model where accuracy is coming to be best 
library(caret)
library(randomForest)
folds = createFolds(y=Df$medv, k = 5)

folds
x=folds$Fold1
cv = lapply(folds, function(x) { 
  training_fold = Df[-x,] 
  test_fold = Df[x,] 
  model = randomForest(formula = medv ~ ., data = training_fold)
  y_pred = predict(model, newdata = test_fold)

  sse = sum((test_fold[,"medv"] - y_pred)^2)
  sst = sum((training_fold$medv - mean(training_fold$medv))^2)
  R2 = 1-sse/sst
 })
cv

#Since the R2 is not varying drastically, 
# hence variance error is controlled on varying the test data, 
# hence we can finalize Randomforest model. We'll train the model 
# through the training data and apply the model on test data to 
# find performance


