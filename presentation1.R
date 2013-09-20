# Presentation 1 - IS607 - James Quacinella
#
# The goal of this presentation is to go over some very basic R and its two data structures we'll use often:
# vectors and data frames. A lot of this can be found in http://www.r-tutor.com/r-introduction/. Also, the
# book "R Cookbook" is awesome, especially chapter 5.



#### Part 1: Vectors ####

### Section 1.1: What is a vector? ###

# A vector is simply sequence of data elements of the same basic type.  
# Pneumonic: c = components, as a vector is made up of components
a <- c(1, 2, 3, 4, 5)

# Note: no such things as scalars, only one-component vectors

# This doesn't work like you would expect (note the integers are 'coerced' (or casted) to characters)
c(1, 'a', 3)    # c('1', 'a', '3')

# Same issue here: 1 and TRUE are coerced to doubles
# NOTE: boolean values are TRUE and FALSE in R. Python has it True and False. 
c(1, TRUE, 2.3) # c(1.0, 1.0, 2.3)

# You can concatenate vectors as well using c(), (but the casting issue is still a problem)
c(a, 10, 9, 8)  # c(1, 2, 3, 4, 5, 10, 9, 8)

### Section 1.2: What can we do with vectors? ###

# We can do math!
a <- c(1, 2, 3)
b <- c(2, 3, 4)
a + b           # c(3, 5, 7)
a - b           # c(-1, -1, -1)
a * b           # c(2, 6, 12)
a / b           # c(0.5000000, 0.6666667, 0.7500000)

# Tricky: what happens if the vector lengths are not the same??
# ANSWER: R 'recycles' the shorter vector
a = c(1, 2, 3)
b = c(5, 6, 7, 8, 9, 10, 11)
a + b
# The operation acts like a is c(1, 2, 3, 1, 2, 3, 1)

# Properties of vectors
length(a)          # 3

### Section 1.3: How can access vector components

## 1.3.1 - Using a numeric index
# NOTE: Not 0-based like Python! Start with 1 ...
vec = c(10, 9, 8, 7)
vec[1]                # 10
vec[2]                # 9
vec[3]                # 8

# What happens here? 
# NOTE: This is very different than python
vec[10]                # ANSWER: returns NA

# What happens here? 
# NOTE: This is very different than python
vec[-1]               # ANSWER: returns copy of the vector without the first element

# This is how we can remove elements from a vector
vec <- vec[-1]

## 1.3.2 - Using more than one numeric index
vec[c(1,2)]           # c(9, 8)

# Even out of order!
vec[c(2, 1, 3)]         # c(8, 9, 7)

# Range (inclusive) queries. NOTE: similar to Python (but exclusive)
vec[1:3]                # c(9, 8, 7)


## 1.3.3 - Logical indexing

# Question: what does this do?
vec %% 2                # ANSWER: c(1, 0, 1)
vec %% 2 == 0           # ANSWER: c(FALSE, TRUE, FALSE])
vec[vec %% 2 == 0]      # ANSWER: c(8)


## 1.3.4 - Named indexing
data <- c("James", "Quacinella")
data

# Add a name to each column / component of the vector
names(data) <- c("First", "Last")
data

# Now we can index based on component name!
data['First']



#### Part 2: Lists ####

## 2.1 - What is a list
# A list is a generic vector containing other objects. Similar to a vector 
# but does not need to have the same mode, or data-type
mylist <- list(1, 2, 3, vec)
mylist 

## 2.2 - Indexing. This is tricky!

# Question: what is the difference bewteen these?
mylist[[1]]         # ANSWER: double-brackets return the components; single brackets return a list
mylist[1]           # This is known as a list-slice

## 2.3 - Named columns - Similar to vectors
names(mylist) <- c('first_col', 'second_col', 'third_col', 'fourth_col')
mylist

mylist['fourth_col']
mylist[['fourth_col']]

## 2.4 - Be careful!!
mean(mylist)

unlist(mylist)          # Flattens the list into a vector, using coercion if needbe
mean(unlist(mylist))    # Now we can use mean(), since it expects a vector

## 2.5 - Can be used like a dictionary in python
dict <- list(apple=1.00, orange=0.75, soda=2.75)
dict
dict['apple']
dict['bread'] <- 3.00
dict




#### Part 3: Matricies ####

### Section 3.1: What is a matrix? ###

# Creates a 2x3 matrix from a 6-component vector. 
A <- matrix(c(1, 2, 3, 4, 5, 6), nrow=2, ncol=3, byrow=TRUE)
A

# Question: how do you think this will differ?
# Answer: byrow changes how the matrix gets filled in by the components of the vector

# Creates a 2x3 matrix from a 6-component vector. 
B <- matrix(c(1, 2, 3, 4, 5, 6), nrow=2, ncol=3, byrow=FALSE)
B

# Creates a 3x2 matrix from a 6-component vector. 
C <- matrix(c(1, 2, 3, 4, 5, 6), nrow=3, ncol=2, byrow=TRUE)
C

# Still works ...
D <- matrix(c(1, 2, 3, 4, 5, 6), nrow=2, ncol=2, byrow=TRUE)
D

# Also still works (recycles values from the vector)
E <- matrix(c(1, 2, 3, 4, 5, 6), nrow=2, ncol=6, byrow=TRUE)
E

# This works but gives you a warning
F <- matrix(c(1, 2, 3, 4, 5, 6), nrow=2, ncol=5, byrow=TRUE)
F

# We can index just like vectors
A[1, 1]
A[1, ]      # Extract just the row vector
A[, 1]      # Extract just the column vector

# We can assign row and column names, just like vectors
rownames(A) <- c("row1", "row2")
A
colnames(A) <- c("col1", "col2", "col3")
A
#dimnames(A) = list( c("row1", "row2"),         # row names 
#                    c("col1", "col2", "col3")) # column names 
#A

# Flatten the matrix
c(A)






#### Part 4: Data Frames ####
#### Again, inspired by http://www.r-tutor.com/r-introduction/data-frame/

### Section 4.1 - Why use a Data frame over a matrix?
### Summary: http://stackoverflow.com/questions/5158790/data-frame-or-matrix



### Section 4.2 - How do we get data frames?
### http://msenux.redwoods.edu/math/R/dataframe.php

# 4.2.1 - read.table() or read.csv()
# setwd("/home/james/Code/Masters/IS607/Presentation1")
data <- read.csv('Desktop/test.data')
data
data$weight > 140                   # Logical vector
data[ data$weight > 140, ]          # Use the logical vector to get all rows where weight > 140
data[ data$weight > 140, ]$height   # Get only the heights of people whose weight > 140

# 4.2.2 - Create your own
data2 <- data.frame(age=c(18, 19, 20), name=c("James", "Bob", "Marc"))
data2

# 4.2.3 - Use built in data sets
data()                      # or data(package = .packages(all.available = TRUE))
head(mtcars)                # Preview data
str(mtcars)                 # Summarize the data frame

### Section 4.3 - Data frame properties
nrow(mtcars)                # Number of rows in the data set
ncol(mtcars)                # Number of columns in the data set
dim(mtcars)

### Section 4.4 - How to Access Data Frames 

# 4.3.1 - Row indexing
mtcars[1, ]                 # Shows the first row (data entry)
mtcars["Valiant", ]         # Shows a specific row, indexed by name

# 4.3.2 - Column indexing
# TODO: confirm what the differences are
mtcars[, 6]                 # These are all the same
mtcars[[6]]
mtcars[["wt"]]
mtcars$wt             

mtcars[c("mpg", "hp")]      # Similar to vectors

# 4.3.3 - Logical indexing
mtcars$cyl > 6
mtcars[mtcars$cyl > 6, ]
mtcars[mtcars$cyl > 6,]$mpg