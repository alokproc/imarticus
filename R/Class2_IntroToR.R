a = 5
class(a)
b = 7L
class(b)

c = b*a

#Arithmetic operators
#+, -, *, /, %%(gives us remainder), %/% gives us quotient

d = b%/%a
d
class(d)

e ="Rahul"
f = T
g = paste(e,f) 
# a default space will be introduced between the values of e and f
g

paste(e,f,sep = "-")

paste(e,f, sep = "")


#Workspace or working directory is the directory in which all my files
#   will be saved. 
#Any file that I read, will be by default checked first in the workspace
#Any file that I write while doing the coding will get written in the workspace

getwd()

setwd("C:\\Users\\Vaibhav\\Desktop\\22DecBatch")

setwd("C:/Users/Vaibhav/Desktop/22DecBatch")
getwd()

#by default the file name is looked for in the workspace, 
#   and if the file is not there in the workspace, 
#   then we have to provide the complete path. 
x = read.csv("abc.csv")

read.csv("C:\\Users\\Vaibhav\\Desktop\\BA\\simplilearn\\Datasets\\Lesson 13 Association Rules Ex 1.csv")->z
y
a = 5
a

#Assignment operation
a <- 5
a = 7
9->a

#How do we change the datatypes
a = as.integer(a)
a
a = as.character(a)
a
a = as.numeric(a)
a

#Relational Operators: <, >, <=,>=,==,!=
a<b
a==b
a!=b

#Logical operators: !,|, &
!T
!F
!(a > 9)
(a>6)|(a<7) #if either of these is true, the answer will be true
T | F  # if either of the conditions is true, my answer will be true
T & F #if either of these is false, the answer will be false
(a <8) & (b==7)
b ==7
b=8 #assigning the value 8 to b

8L == 8
rm('TRUE')
'TRUE' == TRUE
'FALSE'==FALSE

#Data Structures in R: Vectors, Matrices, Dataframes, Lists
#Vectors - uni-dimensional homogenous data structure 
p = c(1,2,3,4)
class(p)

q = c(1L, 100L, 12L, 300L)
class(q)

r = c("How are you", "I am great!", "How do you do", "?")
class(r)

s = c(T, F, F, T)
class(s)
s

a = c(1,3,5.6, 8.9, 'p', 1L, TRUE)
a

b = c(FALSE, 4L)
b
b = c(FALSE, 4L, 3)
class(b)
b
b = c(FALSE, 4L, 3,"5")
b
class(b)

#if we explicitly type-cast then there are chances that we'll get nas 
#  - if there are strings in the as.integer / as.numerical, then they will be converted to NAs
#  - while doing as.logical, any non-logical number will be converted to na
b = as.integer(b)

b = c(1L, 6L, 4.3, "FALSE", "56")
b
class(b)
b = as.integer(b) # if there are strings in the as.integer / as.numerical, then they will be converted to NAs

b =as.logical(b)


#how do we access the components of vector
b = c(1L, 6L, 4.3, "FALSE", "56")
b
class(b)
b = as.integer(b) # if there are strings in the as.integer / as.numerical, then they will be converted to NAs
b
length(b) #length of vector b
b[2]

#how do we append the vector
b[5] = 89
b

b[7]=100
b[6]
b

#to find out the missing values in b
q = is.na(b)
q

which(is.na(b))->p #which all components of the logical vector are true
p
b[p] = 1000
b


b = c(1L, 6L, 4.3, "FALSE", "56")
b =as.logical(b)
b

#impute the missing values by 1000
b[which(is.na(b))]=1000
b
is.na(b)

b
b[c(TRUE, FALSE, TRUE, TRUE, FALSE)]->c
c

b = c(1L, 6L, 4.3, "FALSE", "56")
b =as.logical(b)
b
#i want to impute the nas with 1000
b[is.na(b)] = 1000
b

#how to delete some component of a vector
#to delete 1st and 3rd component of vector b
b[-c(3,5)]->b
b

#how do we take some input from the user
readline(prompt = "Please input your age: ") -> age
age = as.numeric(age) #by default the input will be read as char type
age

#when to use paranthesis and when to use sq braces?
# all the functions will have paranthesis
median(b)
sum(b)
#when I am defining a vector, matrix, df - we use the paranthesis
a = c(1:10)
#when trying to access the components of a vector/matrix/df/list, we use []
a
a[3]
a[5]

#inside the square braces, we can define a vector of indexes to be retrieved
p = c(3,7)
a[p]
a[c(3,6)]

#functions--------------------------------------------------------------
?seq
seq(from = 100, to = 1000, by = 25)->sequence
sequence
sequence*5 #each and every element of the vector will be multiplied by 5

sequence<200 -> var
var
which(var) #which command always gives the location of the trues in my vector

length(sequence)

ifelse(test = sequence%%2==0,yes="even", no = "odd")->p
p

op = ifelse(sequence < 200, yes = "<200", no = ">=200")
op

sequence[which(sequence<200)]
sequence[sequence<200]


c(1,2,4)->vector
as.character(vector)
as.integer(vector)

#if else loop -  can't be used for a vector comparison
p = 300
if(p<200) #can't be used for a vector comparison, can only be used for uni-valued variable
{
  a = "p<200"
  paste(a, "The value of p is: ", sep = ";")->a
  paste(a, p, sep = "")->a
  print(a)
} else #else should be in the same line as the closing curly brace, 
{
  a = "p>=200"
  paste(a, "The value of p is: ", sep = ";")->a
  paste(a, p, sep = "")->a
  print(a)
}

#ifelse function to be used for vector operations
#if else loop to be used for a uni-valued variable


#multiple else
a = 5
c = 6
if(a<4 | c<6)
{
  b = paste("a =", a)
  print(b)
}else if(a==4)
{
  print("a is equal to 4")
}else
{
  b = paste("either a>4 or c<=6. The value of c is", c, sep=": ")
  print(b)
}

#string functions
names = c("Mr. Ram Das", "Mrs. Shalini Kumar", "mr. ram kumar")
#we are looking for all the ram in our data
#grep fn will tell me the indices of the vector where the pattern is matched
grep(pattern = "ram", x = names,ignore.case = FALSE)

#where-ever there is ram - substitute those names by Sita
grep(pattern = "ram", x = names,ignore.case = TRUE)->p
names[p] = "Sita"
names


#to substitute all the occurrence of a certain pattern - using the gsub
#eg. all the occurrences of the pattern " " to be substituted by "/"
names = c("Mr. Ram Das", "Mrs. Shalini Kumar", "mr. ram kumar")
gsub(pattern = " ",replacement = "/",x = names)

#if we are are required to susbstitute only the first 
#   occurrence of the pattern in each component - use sub command
#I want to replace only the first occurrence of " " in each component by ""
names = c(" Mr. Ram Das", " Mrs. Shalini Kumar", " mr. ram kumar")
sub(pattern = " ", replacement = "", x = names)->names
names
names = c(" Mr. Ram Das", " Mrs. Shalini Kumar", " mr. ram kumar")
gsub(pattern = " ", replacement = "", x = names)->names
names

names = c(" Mr. Ram Das", " Mrs. Shalini Kumar", " mr. ram kumar")
names[2] = "Mrs. ShaliniKumar"
#. \ | ( ) [ { ^ $ * + ? ->meta-characters to be escaped by the escape characters

a = c("a.b" , "b.c")
a
#to replace all the occurrences of . by a -
sub(pattern = "\\.", replacement = "-", x = a)

name=c(" Mr Ram das"," mohit","Hello Ram")
sub(pattern = " ", replacement="",x=name)->name2
name2

#for loop 
cal_year = c("Jan", "Feb", "Mar", "Apr","May", "Jun","July","Aug", "Sep", "Oct", "Nov", "Dec")
a = c(1:12)
j =1
for(i in cal_year)
{
  paste("The current month is:", i)->a[j]
  j = j+1
}
a


#for loop for alternate months
cal_year = c("Jan", "Feb", "Mar", "Apr","May", "Jun","July","Aug", "Sep", "Oct", "Nov", "Dec")
a = NULL
j =1
i = 1
for(i in 1:length(cal_year)) #i will take values 1:12
{
  if(i%%2==0)
  {
    paste("The current month is:", cal_year[i])->a[j]
    j = j+1
  }
}

#if i want to end the loop after october, 
#   and i want to skip the vacation months Apr and may
cal_year = c("Jan", "Feb", "Mar", "Apr","May", "Jun","July","Aug", "Sep", "Oct", "Nov", "Dec")
a = NULL
j =1
i = 1
for(i in 1:length(cal_year)) #i will take values 1:12
{
  
  if((cal_year[i] == "Apr")|(cal_year[i]=="May"))
    next #next will mean skip the loop for these months 
  
  paste("The current month is:", cal_year[i])->a[j]
  j = j+1
  
  if(cal_year[i]=="Oct")
    break #i will not take the next value after break command
    #break means break the loop
}

a

#Assignment: Print the table of 2
# 2 X 1 = 2
# 2 X 2 = 4
# 2 X 3 = 6

# 2 X 10 = 20

#Assignment nested for loop 
#1111
# 111
#  11
#   1

#Nested for loop
rows= 1:4
cols = 1:4
for(i in rows)
{
  for(j in cols)
  {
    print("1")
  }
}

#while loop
i = 0
while(i<length(cal_year))
{
  i = i+1
  paste(cal_year[i], i)->p
  print(p)
}


#while loop
i = 0
while(i<length(cal_year))
{
  i = i+1
  
  if((cal_year[i] == "Apr")|(cal_year[i]=="May"))
    next #next will mean skip the loop for these months 
  
  paste(cal_year[i], i)->p
  print(p)
  
  if(cal_year[i]=="Oct")
    break #i will not take the next value after break command
  #break means break the loop
}