
# Create Data Frame

employee_data <- data.frame(
  employee_id = c (1:5),
  employee_name = c("James","Harry","Shinji","Jim","Oliver"),
  sal = c(642.3,535.2,681.0,739.0,925.26),
  join_date = as.Date(c("2013-02-04", "2017-06-21", "2012-11-14", "2018-05-19","2016-03-25")),
  stringsAsFactors = FALSE)

print(employee_data)

class(employee_data)

# Get the Structure Data Frame
str(employee_data)

# Extract data from Data Frame

# By using the name of the column,
# extract a specific column from the column.

output <- data.frame(employee_data$employee_name, employee_data$employee_id)
print(output)

class(output)

# Extract the first two rows and then all columns
output <- employee_data[1:2,]
print(output)

#Extract 1st and 2nd row with the 3rd and 
# 4th column of the below data.
result <- employee_data[c(1,2),c(3,4)]
result

# Expand R Data Frame

# Add the column vector using a new column name.
Add the “dept” column

employee_data$dept <- c("IT","Finance","Operations","HR","Administration")
out <- employee_data
print(out)

# Add Row

# Create the second R data frame

employee_new_data <- data.frame(
  employee_id = c (6:8),
  employee_name = c("Aman", "Piyush", "Aakash"),
  sal = c(523.0,721.3,622.8),
  join_date = as.Date(c("2015-06-22","2016-04-30","2011-03-17")),
  stringsAsFactors = FALSE
)

# Bind the two data frames.

employee_out_data <- rbind(employee_data,employee_new_data)
employee_out_data     


  
