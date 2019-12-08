library(datasets)
data(iris)
install.packages("psych")
library(psych)
describeBy(iris,group = iris$Species)
library(lattice)
histogram(~Sepal.Length|Species,
          data=iris,
          layout=c(1,3),
          col="black")
boxplot(Sepal.Length~Species,
        data = iris)