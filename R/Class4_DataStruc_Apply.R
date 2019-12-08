titanic_train = read.csv("C:\\Users\\Vaibhav\\Desktop\\BA\\simplilearn\\Datasets\\titanic_train.csv")
head(titanic_train)

#Q. Find the number of passengers who survived
sum(titanic_train$Survived)

#what %age of passengers survived?
#=total number of ppl survived / total number of passengers
sum(titanic_train$Survived)/nrow(titanic_train)
mean(titanic_train$Survived)

#convert male to 1 and female to 0 in titanic train dataset
titanic_train$Sex = ifelse(titanic_train$Sex=='male', 1, 0)

#interchange name and pclass
n = titanic_train$Name
titanic_train[,4] = titanic_train$Pclass
titanic_train[,3]=n
nm = names(titanic_train)[4]
names(titanic_train)[4] = names(titanic_train)[3]
names(titanic_train)[3] = nm



#how to handle missing values
colSums(is.na(titanic_train))

#2 options:
#if there are very few rows having missing values, then we can delete those rows
#2nd option is to impute the missing values by 1 of the measure of central tendency: mean / med / mode

na.omit(object = titanic_train)->t
colSums(is.na(t))

titanic_train$Age[is.na(titanic_train$Age)]= mean(titanic_train$Age, na.rm = T)
colSums(is.na(titanic_train))



#how to import excel file

p = "C:\\Users\\Vaibhav\\Desktop\\22DecBatch\\Lesson13.xlsx"
path = "C:/Users/Vaibhav/Desktop/22DecBatch/Lesson13.xlsx"

install.packages("readxl")
library(readxl)

#gives the names of the sheets in the path
excel_sheets(path = p)->sheets
excel_sheets(path = "C:\\Users\\Vaibhav\\Desktop\\22DecBatch\\Lesson13.xlsx")
excel_sheets("C:\\Users\\Vaibhav\\Desktop\\22DecBatch\\Lesson13.xlsx")
sheets

read_excel(path = path,sheet = "Sheet1", trim_ws = T, skip=2)->file_sheet1
#skip =2 means skip the top 2 lines, while reading the excel file

read_excel(path = path,sheet = "Sheet1", trim_ws = T)->file_sheet1
#Rahul Gandhi " - trim_ws will delete the leading and trailing white spaces

#how do we export files
setwd("C:\\Users\\Vaibhav\\Desktop\\22DecBatch")
write.csv(x = file_sheet1, file = "exceltocsv.csv")

#Lists - multi-dimensional heterogenous data structures
# it can have vectors / df / matrix / lists as it's components
ID = c(1:3)
Name = c("Raj", "Suman", "Santosh")
Gender = c("M", "F", "M")
Phy = c(60, 65, 70)
students = data.frame(ID, Name, Gender, Phy)
students_list = list(ID, Name, Gender, Phy, students)
students_list
class(students_list) #list

#how to seperate out the first component of the list 
students_list[[1]] -> a #gives the id vector
class(students_list[[1]])
class(a)
a

n = students_list[[2]]
class(students_list[[2]])
class(n) #char vector

#how to seperate out the 4th component
class(students_list[[4]])

#how to seperate out the 5th component
students_list[[5]]->d # gives a df
d
class(d) #df


complex = list(ID, students, students_list)
complex
complex[[1]]->first_component
class(first_component)

complex[[2]]->second_com
class(second_com)

complex[[3]]->third_com
class(third_com)
third_com
class(third_com[[5]])
third_com[[5]] ->df
df

students_list
names(students_list) = c("ID", "Names", "Gender", "Marks", "Students")
students_list
students_list[[1]]
students_list[[2]]
students_list[[3]]

#we can also use names of the components to fetch the components
class(students_list$Students)
students_list$Gender

unlist(students_list) #is used unlist our list and gives a named vector

unlist(students_list)[1]

students_list$Chem = c(100, 89, 67)
students_list



fn = function(students)
{
  students[,1] = c("A", "B", "C")
  students[, 2] = c(90, 45, 90)
  
  class_df = students
  class_df[,1] = c("P", "Q", "R")
  
  lst = list(students, class_df)
  return(lst)
}

students
fn(students)->l
l[[1]]->students
l[[2]]->class

#Data-frames ----------------------------------------------------------

#Apply family

#1. Apply function: which can be used to apply any function either row-wise or column-wise on matrices
#   if using in data-frame(apply the fn on matrix i.e columns having common data-type)
#   Apply function returns a matrix - i.e all columns returned will be homogenous
?apply
mtcars
as.matrix(mtcars)->mt
mt

#margin = 1 for row-wise, margin = 2 for col.wise
apply(X = mt, MARGIN = 2, sum)
apply(X = mt[,c(10,11)], MARGIN = 1, FUN = sum)

#in data-frames
View(mtcars)
head(mtcars)
apply(X = mtcars[,c("cyl", "vs", "am", "gear", "carb")], MARGIN = 2, FUN = as.factor)->dummy
dummy
summary(dummy)


#summary fn on iris data
apply(X = iris[, c(1:4)], MARGIN = 2, FUN = summary)-> a
a
class(a)

head(iris)
apply(X = iris, MARGIN = 2, FUN = summary)-> a
class(a) #gives character class since, species is character class and apply returns a matrix
a


lst = (lapply(X = iris, FUN = summary))
lst
#lapply - can be applied on each component of lists / vectors / matrices
#returns a list
#for a dataframe, lapply will apply the function to each and every column

matrix(data = c(1:15),nrow = 3, ncol = 5, byrow = T)->matr
matr
matr[2,2]= NA
matr
matrix((lapply(X = matr, is.na)), nrow = 3, ncol = 5)

quadratic = function(a, b)
{
  c = a^2 + b
}

matrix(lapply(X = matr,FUN = quadratic, 5), nrow = 3, ncol = 5)
matr

#let's compare the behaviour with the data frames
class(mtcars) #data.frame
lapply(mtcars, summary) #here the fn is applied to each and every col. of df
lapply(as.matrix(mtcars), summary) #fn is applied to each and every element of a matrix

lapply(iris, is.na) #input parameter for is.na is column vector
lapply(as.matrix(iris[,c(1:4)]), is.na) #input parameter is each element of the matrix

View(titanic_train)


#Apply will apply the fun f either row-wise or col-wise on my matrix. It will not apply the fn f on each and every component of the vector / matrix.
#apply fn returns a matrix, lapply returns a list
#apply fn input is also homogenous, where-as lapply can take a df / list / matrix /vecor

View(titanic_train)
strsplit("Knight, Mr. Robert J",split = "[ .]")
strsplit("Dooley, Mr. Patrick ", split = "[ .]")

p = c("Dooley, Mr. Patrick", "Knight, Mr. Robert J")
strsplit(p, split = "[ .]")

name = "Knight, Mr. Robert J"
fn = function(name)
{
  strsplit(name, split = "[ .]")[[1]][2]  
}

fn("Knight, Mr. Robert J")

p = c("Dooley, Mr. Patrick", "Knight, Mr. Robert J", "Behr, Mr. Karl Howell")

title = unlist(lapply(X = p,FUN = fn))
title

class(titanic_train$Name)
titanic_train$Name = as.character(titanic_train$Name)
title = unlist(lapply(X = titanic_train$Name,FUN = fn))
title

#lapply can also be used to simultaneously read all the sheets in an excel file 
p = "C:\\Users\\Vaibhav\\Desktop\\22DecBatch\\Lesson13.xlsx"
path = "C:/Users/Vaibhav/Desktop/22DecBatch/Lesson13.xlsx"

install.packages("readxl")
library(readxl)

#gives the names of the sheets in the path
excel_sheets(path = p)->sheets
excel_sheets(path = "C:\\Users\\Vaibhav\\Desktop\\22DecBatch\\Lesson13.xlsx")
excel_sheets("C:\\Users\\Vaibhav\\Desktop\\22DecBatch\\Lesson13.xlsx")->sheets
sheets

read_excel(path = path,sheet = sheets[1],trim_ws = T)
read_excel(path = path,sheet = sheets[2])


lapply(sheets[c(1,2)], read_excel, path = path, trim_ws = T)

#sapply - it is exactly similar to lapply - the only difference is it returns a vector

fn = function(name)
{
  strsplit(name, split = "[ .]")[[1]][2]  
}

fn("Knight, Mr. Robert J")

titanic_train$Name = as.character(titanic_train$Name)
title = sapply(X = titanic_train$Name,FUN = fn)
title
titanic_train$title = title

#tapply - is used for level-wise summarization of our data
iris$Species

#suppose we want the mean sepal length for each of the species
mean(iris$Sepal.Length[iris$Species=="setosa"])
mean(iris$Sepal.Length[iris$Species=="versicolor"])
mean(iris$Sepal.Length[iris$Species=="virginica"])

tapply(X = iris$Sepal.Length, INDEX = list(iris$Species), FUN = mean)->t
class(t)
as.vector(t)
tapply(X = iris$Sepal.Length, INDEX = list(iris$Species), FUN = length)
tapply(X = iris$Sepal.Length, INDEX = list(iris$Species), FUN = summary)

View(iris)

#aggregate
aggregate(iris[,-5], list(iris$Species), mean)
aggregate(iris[,-5], list(iris$Species), median)->d
aggregate(iris[,-5], list(iris$Species), summary)
class(d)

aggregate(iris, list(iris$Species), summary)
aggregate(iris[,-5], list(iris$Species), mean)


tapply(X = titanic_train$Age, INDEX = list(titanic_train$Survived), FUN = mean)

#how to remove the duplicate rows
ID = c(1,2,3, 2,4,2)
Names = c('A','B', "C", 'B', "D", 'B')
p = data.frame(ID, Names)
p

q = unique(p)
q

duplicated(p)
p[!duplicated(p),]

#if there are duplicate columns in the data
p
cbind(p, ID)->p
p

duplicated(names(p))
p[,!duplicated(names(p))]

unique(names(p))

#dplyr -----------------------------------------------------------------------

library("tidyverse")
as_tibble(iris)->ir
head(ir)
ir
iris

glimpse(iris)

View(airquality)
?airquality
aq = as_tibble(airquality)
head(aq)
#select fn - to select the columns which specify some criteria - especially useful when 1000s of columns
select(.data = aq,contains("zon"), ends_with(".R"), starts_with("Wi"),Temp: Day)
?select
#how to rearrange the cols
select(.data = aq, Temp:Day, Wind, Ozone:Solar.R)
# Move Species variable to the front
select(iris, Species, everything())

select(.data = aq, -c(contains("on"), Temp))

select_if(aq,is.numeric)
select_if(iris, is.numeric)->num_iris

#Say cond can be starts with solar and ends with R using AND
select(mtcars, ends_with("t"))->p
select(p, starts_with("dr"))
