#1111
# 111
#  11
#   1


l = seq(4, 1, -1)
l


for(i in c(1:4))
{
  p = NULL
  for(j in c(1:4))
  {
    
    if(j>=i)
      p = paste(p, "1", sep ="")
    else 
      p = paste(p, " ", sep = "")
  }
  print(p)
}

# & operator
TRUE & F
T & T
F & T
F & F

T && F
T && T
F && T
F && F

T | F
T || F
T | T
T || T
F | T
F || T

#| - condition gives us true even if there is only 1 true and rest all are false

T | z
T || z 
# || will give true if either of these is T. If the condition find 1 true, then will not search ahead
z || T

#&& will not look further as soon as it finds the first false
F & z
F && z #still gives us false
z && F

x =3 
y=10
if ((x< 6) & (x>y))
{
  print(x,y)
}

x = 1:4
x
rev(x)


#Reversing a string by characters
string = "abcde"

reverse_chars = function(string)
{
  l = strsplit(x = string, split = "")
  l
  l[[1]]
  v = l[[1]]
  rev(v)
  length(v)
  paste(rev(v), collapse = "")
}
 
reverse_chars("string") 

#to get the number of characters in a string
nchar(string)

View(iris)
View(mtcars)
?iris
?mtcars

#Named Vectors
a = c("Rahul", "Modi")
class(a)
names(a) = c("Sec A", "Sec B")
a
names(a)
names(a)[1]
names(a)[2]

#to retrieve the vector components
a[1] #will give the named component incase of a named vector
a["Sec A"]

#to retrieve the unnamed vector components
a [[1]]
a[["Sec A"]]

#Matrices - 2 dimensional homogenous data structures
View(mtcars)

a = c(10, 40, 89, 93)
a
a[1]
a[2]
a[1:3]

#to retrieve multiple components in a vector
a[c(2,3)]

#-------------------------------------------------------------
#Matrices - 2-D homogenous data structures
matrix(data = c(1,10, 20,4, 6,8), nrow = 2, ncol = 3)->mat
mat
#by default the matrix gets populated column-wise

#to populate it row-wise
matrix(data = c(1,10, 20,4, 6,8), nrow = 2, ncol = 3, byrow = T)->mat
mat
mat[,1] # gives me the first col
mat[1,] #gives the 1st row

mat[1,1]

#to retrieve elements from 2nd and 3rd col of 1st row
mat[1, c(2,3)]

mtcars
class(mtcars)
mt = as.matrix(mtcars)
mt
class(mt)
str(mt)
summary(mt)

mt[1,]
mt[,1]

#to retrieve row numbers 3,5, 8 and column numbers 2,4,6 from mt matrix
mt[c(3,5,8),c(2,4,6)]->m
class(m)


mat
colnames(mat)
rownames(mat)

rownames(mt)
colnames(mt)

#how to assign row names and colnames
mat
colnames(mat) = c("ClassA", "ClassB", "ClassC")
rownames(mat)= c("SchoolA", "SchoolB")
mat

#to retrieve vector ClassA
mat[,"ClassA"]

#to retrieve vector SchoolA
mat["SchoolA",]

schoolC = c(20, 10, 45)
rbind(mat, schoolC)->mat
mat

ClassD = c(10, 4, 12)
cbind(mat, ClassD)->mat
mat

nrow(mat)
ncol(mat)
dim(mat)

#to delete columns 2nd and 4th
mat[,-c(2,4)]->a
a
mat

#suppose i want to delete the last row of my matrix mt
x=nrow(mt)
mt[-x, ]->b
b
#suppose i want to delete the last 2 rows of my matrix mt
mt
x = c(nrow(mt), nrow(mt)-1)
x
mt[-x,]
mt[-c(32,31),]
mt[-c(nrow(mt), nrow(mt)-1),]

#Assignment: From this mt matrix, delete the col named wt and vs

mat[1,1]=23
mat['SchoolA', 'ClassA'] = 4
mat

?replace

#Assignment: interchage the positions of columns ClassB and ClassD in mat

#Dataframe - heterogenous data-structure of 2-dimensions
View(iris)

ID = c(1:3)
Name = c("Raj", "Ken", "Archana")
Gender = c("M", "M", "F")
Phy = c(60, 56, 89)
students = data.frame(ID, Name, Gender, Phy)
students

#inspection of the dataframe
nrow(students)
ncol(students)
dim(students)
summary(students)
str(students)

students[,2] = as.character(students[,2])
str(students)

install.packages("dplyr")
library("dplyr")
glimpse(students)
glimpse(iris)

class(mtcars)

#frequency distribution of the factor col
table(iris[,5])
table(iris$Species)
levels(iris[,5])
levels(iris$Species)

iris$Sepal.Length
iris$Sepal.Width
length(iris$Sepal.Width)

View(iris)
#to retrieve all the rows from iris having species = "setosa"
iris$Species=="setosa"
rn = which(iris$Species=="setosa")
iris[rn,]->df

iris$Species=="setosa"
students
students[c(T,F,T),]

iris[iris$Species=="setosa",]

#Retrieve the data having petal length <0.3
iris[iris$Petal.Width<0.3,]

iris$Petal.Width[iris$Petal.Width<0.3]

#Retrieve the sepal width of all the flowers having sepal length bw 4 and 5
iris$Sepal.Width[iris$Sepal.Length<5 & iris$Sepal.Length>4]

#For all the flowers having sepal length bw 4 and 5, 
# I want to make sepal width = 2.0
iris$Sepal.Width[iris$Sepal.Length<5 & iris$Sepal.Length>4]=2.0

iris$Sepal.Width[iris$Sepal.Length<5 & iris$Sepal.Length>4]

colnames(iris)
names(iris)[4] = "Petal_Width"
names(iris)
stu = students
names(students) = c("A", "B", "C")
names(students)
students

is.na(names(students))
names(students)[is.na(names(students))] = "D"
names(students)
names(students)=c("ID", "Names", "Gender", "Phy")

#how to add a new column
students$Chem = c(89, 67, 45)
students

cricket = c(67, 89, 78)
bb = c(67, 56,90)
badminton =c(67, 89, 45)
sports = data.frame(cricket, bb, badminton, Phy)
sports
students
cbind(students, sports)
students

#row bind - rbind
x = data.frame(4, "Manju", "F", 67, 93)
x
rbind(students, x)
names(x)=names(students)
names(x)
x
rbind(students,x)->students
students

#create a new col having total marks 
students$total = students$Phy + students$Chem
students

#how to delete a col
students$Phy = NULL
students
students[,-4]->students
students

#to del all the rows having total marks < 140
which(students$total<140)->rn
students[-rn,]->s
s

#how to address the missing values 
titanic = read.csv("C:\\Users\\Vaibhav\\Desktop\\BA\\simplilearn\\Datasets\\titanic_train.csv")
head(titanic)

summary(titanic)
str(titanic)

colSums(is.na(titanic))

titanic$Age[is.na(titanic$Age)] = mean(titanic$Age, na.rm = T)
colSums(is.na(titanic))

