

# Create two vectors of different lengths.

vector1 <- c(2,9,3)
vector2 <- c(10,16,17,13,11,15)

# Take these vectors as input to the array.

result <- array(c(vector1,vector2),dim = c(3,3,2))
print(result)

# Different Operations on Rows and Columns

# 1. Naming Columns And Rows

# Create two vectors of different lengths.

vector1 <- c(2,9,6)
vector2 <- c(10,15,13,16,11,12)
column.names <- c("COL1","COL2","COL3")
row.names <- c("ROW1","ROW2","ROW3")
matrix.names <- c("Matrix1","Matrix2")

# Take these vectors as input to the array.

result <- array(c(vector1,vector2),dim = c(3,3,2),dimnames = list(row.names,column.names,
                                                                  matrix.names))
print(result)

# 2. Accessing R Array Elements

# Print the third row of the second matrix of the array.

print(result[3,,2])

# Print the element in the 1st row and 3rd column of the 1st matrix.
print(result[1,3,1])

# Print the 2nd Matrix.

print(result[,,2])

# 3. Manipulating R Array Elements

# Create two vectors of different lengths.

vector1 <- c(1,2,3)
vector2 <- c(3,4,5,6,7,8)

# Take these vectors as input to the array.

array1 <- array(c(vector1,vector2),dim = c(3,3,2))

# Create two vectors of different lengths.

vector3 <- c(3,2,1)
vector4 <- c(8,7,6,5,4,3)
array2 <- array(c(vector1,vector2),dim = c(3,3,2))

# create matrices from these arrays.

matrix1 <- array1[,,2]
matrix2 <- array2[,,2]

# Add the matrices.

result <- matrix1+matrix2
print(result)


# 4. Calculations across R Array Elements

# We will create two vectors of different lengths.

vector1 <- c(1,2,3)
vector2 <- c(3,4,5,6,7,8)

# Now, we will take these vectors as input to the array.
new.array <- array(c(vector1,vector2),dim = c(3,3,2))
print(new.array)

# Use apply to calculate the sum of the rows across all the matrices.

result <- apply(new.array, c(1), sum)
print(result)

