a = 5 #press ctrl+enter
b = 10
a+b

a.+b
#to clear the console: ctrl + l

#how to install and load the packages
#on packages tab using install command
install.packages("dplyr")
library(dplyr)

#in order to get the help on some function
?sum
?mean
help(median)

#Logical DataType
a = T
b = TRUE
c = FALSE
d = F

#to delete a variable from the global environment
rm(D)

a
b
c
d
class(a)
class(b)
class(c)
class(d)

#numerical datatype
e = 15
f = 16.3
class(e)
class(f)

#integer datatype
g = 16L #this means 16 of integer type
class(g)
h = g+1L
h
class(h)

#character
i = "Rahul"
i
class(i)

j = 'R'
class(j)

#add integer with float
h
class(h)
e = 15.3
class(e)
k = h + e
class(k) #numeric

#add logical with int
b
h
class(h)
p = h+b
class(p)
#internal type conversion will happen to convert logical to integer

k = NULL
class(k)
