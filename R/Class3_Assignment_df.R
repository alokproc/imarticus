#Assignment on data-frames

#Use the data-set iris
View(iris) #iris is a pre-loaded data-set in r
iris$Sepal.Length
#Q. Find the average sepal length of Setosa species. Hint: use function "mean"
  #Hint: Following is the mean function  
  mean(iris$Sepal.Length, na.rm = T)#na.rm = T will remove nas while finding mean
#Q. Find the different categories of species variable. Hint use "table" function on Species variable
    table(iris$Species)
    levels(iris$Species)
#Q. Find which species has the highest Petal Width.

#Q. For all the virginica flowers having petal width = 2.0, make their petal length to 5.5

#titanic dataset
#Q. read the titanic_train file
titanic_train = read.csv("C:\\Users\\Vaibhav\\Desktop\\BA\\simplilearn\\Datasets\\titanic_train.csv")
head(titanic_train, 10)

#Q. Find the number of passengers who survived
#Q. Find the age of Timothy
#Q. Find names of passengers having age>35
#Q. The age of Henry has been entered incorrect. Please change it to 45.
#Q. How many NAs are there in Age column. Replace the NAs by the mean age.Following fn will give the mean age: 
mean(titanic_train$Age,na.rm = TRUE)
#Q. Add another column: Family_Members = 1(Self) + SibSp (gives number of siblings + spouse) + Parch (gives parents + children)
