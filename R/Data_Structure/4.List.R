

# Create a list
list_data <- list("Red", "White", c(1,2,3), TRUE, 22.4)
print(list_data)

class(list_data)

# Name List Elements
# Let’s create a list containing a vector, matrix, and list.
data_list <- list(c("Jan","Feb","Mar"), matrix(c(1,2,3,4,-1,9), nrow = 2),list("Red",12.3))
names(data_list) <- c("Monat", "Matrix", "Misc")
print(data_list)


# Access List Elements

#In order to give names to the elements of the list:
names(data_list) <- c("Monat", "Matrix", "Misc")

# Access the first element of the list.

print(data_list[1])     #Accessing the First element

# Access the third element. As it is also a list, all its elements will print.
print(data_list[3])     #Accessing the Third element

# By using the name of the element access the list elements.
print(data_list$Matrix)  #Using name of access element

# Manipulate List elements

##Give names to the elements in the list.

names(data_list) <- c("Monat", "Matrix", "Misc")

# Add an element at the end of the list.

data_list[4] <- "New element"
print(data_list[4])

# Remove the last element.

data_list[4] <- NULL
print(data_list[4])

# Update the 3rd Element.
data_list[3] <- "updated element"

# Merge Lists
num_list <- list(1,2,3,4,5)       #Author DataFlair
day_list <- list("Mon","Tue","Wed", "Thurs", "Fri")
merge_list <- c(num_list, day_list)
merge_list

# Convert R List to Vector

# Create lists.
int_list <- list(1:5)     
print(int_list)
int_list2 <- list(10:14)
print(int_list2)

# Convert the lists to vectors.

vec1 <- unlist(int_list)
vec2 <- unlist(int_list2)
print(vec1)
print(vec2)

# Now add the vectors.

sum <- vec1 + vec2 
print(sum)

# to Generate Lists
# We can use a colon to generate a list of numbers.

-5:5       #Generating a list of numbers from -5 to 5


# Operation on Lists 

# R allows operating on all list values at once.
c(1,2,3) + 4


# Predefined Lists

# Lists for letters and month names are predefined:
letters
LETTERS
month.abb
month.name

# c function in R

# The c function in R combines the parameter into a list and
# converts them to the same type.

c("April", 4)
typeof("4")

