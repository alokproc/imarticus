library(MASS)
names(iris)
dim(iris)
head(iris)
train <- sample(1:nrow(iris), nrow(iris)/2)
iris_train <- iris[train,]
iris_test <- iris[-train,]

fit <-lda(Species~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width, data = iris)

pred<- predict(fit,iris_test)
pred_class <- pred$class
table(pred_class, iris_train$Species)

library("caret")
library("pROC")
library("e1071")

confusionMatrix(pred_class, iris_test$Species)
confusionMatrix(pred_class, iris_train$Species)
