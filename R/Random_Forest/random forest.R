#Random Forest Model
library(randomForest)
require(caret) 
library(pROC)
library(e1071)
#Reading Data
hr_data = read.csv("C:/Users/User02/Google Drive/Business Analytics/Business Analytics Video/Moodle Upload/9. Classification/Case study/HR dataset.csv")
#hr_data = choose.files()
View(hr_data)

colnames(hr_data)

#Removing role & salary as we are using role_code & salary_code
hr_data1 = hr_data[,-c(9,10)]

hr_data1$role_code = as.factor(hr_data1$role_code)
hr_data1$salary.code = as.factor(hr_data1$salary.code)

View(hr_data1)

summary(hr_data1)
# Creating train and test samples
set.seed(1234)
splitIndex <- createDataPartition(hr_data1$left, p = .70,list = FALSE, times = 1)
trainSplit <- hr_data1[ splitIndex,]
testSplit <- hr_data1[-splitIndex,]
print(table(trainSplit$left))
print(table(testSplit$left))

# Random Forest Model #
modelrf <- randomForest(as.factor(left) ~ . , data = trainSplit, do.trace=T)
modelrf

importance(modelrf)
#The variable importance plot displays a plot with variables sorted by MeanDecreaseGini
varImpPlot(modelrf)

### predict
predrf_tr <- predict(modelrf, trainSplit)
predrf_test <- predict(modelrf, testSplit)


### score prediction using AUC
confusionMatrix(predrf_tr,trainSplit$left)
confusionMatrix(predrf_test,testSplit$left)

aucrf_tr <- roc(as.numeric(trainSplit$left), as.numeric(predrf_tr),  ci=TRUE)
aucrf_test <- roc(as.numeric(testSplit$left), as.numeric(predrf_test),  ci=TRUE)

aucrf_tr
aucrf_test

plot(aucrf_tr, ylim=c(0,1), print.thres=TRUE, main=paste('Random Forest AUC:',round(aucrf_tr$auc[[1]],3)),col = 'blue')
plot(aucrf_test, ylim=c(0,1), print.thres=TRUE, main=paste('Random Forest AUC:',round(aucrf_test$auc[[1]],3)),col = 'blue')


#NaiveBayes Model
modelnb <- naiveBayes(as.factor(left) ~. , data = trainSplit)
modelnb

prednb_tr <- predict(modelnb,trainSplit)
prednb_test <- predict(modelnb,testSplit)

### score prediction using AUC
confusionMatrix(prednb_tr,trainSplit$left)
confusionMatrix(prednb_test,testSplit$left)

###################### kNN Model #################################

hr_data1$left = as.factor(hr_data1$left)

library(dummies)
dummy_df = dummy.data.frame(hr_data1[, c('role_code', 'salary.code')])

hr_data2 = hr_data1
hr_data2 = cbind.data.frame(hr_data2, dummy_df)
hr_data2 = hr_data2[, !(names(hr_data2) %in% c('role_code', 'salary.code'))]
hr_data2$Work_accident = as.numeric(hr_data2$Work_accident)
hr_data2$promotion_last_5years = as.numeric(hr_data2$promotion_last_5years)

#Scale the variables
X = hr_data2[, !(names(hr_data2) %in% c('left'))]
hr_data2_scaled = as.data.frame(scale(X))
str(hr_data2_scaled)

hr_train <- hr_data2_scaled[splitIndex,]
hr_test <- hr_data2_scaled[-splitIndex,]

hr_train_labels <- hr_data2[splitIndex, 'left']
hr_test_labels <- hr_data2[-splitIndex, 'left']

## Let's use diff k values (no of NNs) to see how they perform in terms of correct proportion of classification and success rate. 

#install.packages("class")
library(class)
#install.packages("gmodels")
library(gmodels)

test_pred_1 <-  knn(train = hr_train, test = hr_test, cl = hr_train_labels, k=1)
CrossTable(x=hr_test_labels ,y=test_pred_1 ,prop.chisq = FALSE)
#accuracy = 4341/4499 = 96.48%

test_pred_5 <-  knn(train = hr_train, test = hr_test, cl = hr_train_labels, k=5)
CrossTable(x=hr_test_labels ,y=test_pred_5 ,prop.chisq = FALSE)
# accuracy = 4250/4499 = 94.46%

test_pred_10 <-  knn(train = hr_train, test = hr_test, cl = hr_train_labels, k=10)
CrossTable(x=hr_test_labels ,y=test_pred_10 ,prop.chisq = FALSE)
# accuracy = 4237/4499 = 94.17%

test_pred_50 <-  knn(train = hr_train, test = hr_test, cl = hr_train_labels, k=50)
CrossTable(x=hr_test_labels ,y=test_pred_50 ,prop.chisq = FALSE)
# accuracy = 4058/4499 = 90.19%

test_pred_100 <-  knn(train = hr_train, test = hr_test, cl = hr_train_labels, k=100)
CrossTable(x=hr_test_labels ,y=test_pred_100 ,prop.chisq = FALSE)
# accuracy = 3891/4499 = 86.48%

test_pred_122 <-  knn(train = hr_train, test = hr_test, cl = hr_train_labels, k=122)
CrossTable(x=hr_test_labels ,y=test_pred_122 ,prop.chisq = FALSE)
# accuracy = 3827/4499 = 85.06%

#or alternatively we can use this below command
confusionMatrix (hr_test_labels,test_pred_122)

# Thumb rule to decide on k for k-NN is sqrt(n)/2
k = sqrt(nrow(hr_train))/2
k
test_pred_rule <-  knn(train = hr_train, test = hr_test, cl = hr_train_labels, k=k)
CrossTable(x=hr_test_labels ,y=test_pred_rule ,prop.chisq = FALSE)
# accuracy = 4050/4499 = 90.02%

# Another method to detremine the k for k-NN
set.seed(400)
ct <- trainControl(method="repeatedcv",repeats = 3)
fit <- train(left ~ ., data = hr_data2, method = "knn", trControl = ct, preProcess = c("center","scale"),tuneLength = 20)
fit

# Using the above code it indicates that k=7 is the best for this data and it is better to go with this value because it has been cross validated

test_pred_7 <-  knn(train = hr_train, test = hr_test, cl = hr_train_labels, k=7)
CrossTable(x=hr_test_labels ,y=test_pred_7 ,prop.chisq = FALSE)
# accuracy = 4357/4499 = 96.84%

#or alternatively we can use this below command
confusionMatrix (hr_test_labels,test_pred_7)


