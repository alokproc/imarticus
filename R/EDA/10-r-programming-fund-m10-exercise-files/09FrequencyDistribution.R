library(datasets)
data(iris)
table(iris$Species)
barplot(table(iris$Species))
prop.table(table(iris$Species))
prop.table(table(iris$Species))*100