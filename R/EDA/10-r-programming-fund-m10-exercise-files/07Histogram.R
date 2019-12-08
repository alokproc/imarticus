library(datasets)
data(iris)
hist(iris$Sepal.Length)
hist(iris$Sepal.Length,
     main="Histogram of sepal length",
     xlab="Sepal length")