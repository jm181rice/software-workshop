# Based on the Software Carpentry Lesson, Introduction to R and RStudio

## intro to R language and RStudio as IDE

## Explain panels (Environment, Files/Plots/Packages, Console, RScripts)

# in console versus script:
print("integrated development environment")

#esc or control C to get out of running operation in console

# https://swcarpentry.github.io/r-novice-gapminder/index.html

# > 1+100
# [1] 101
# > 1 +
#   + 100
# [1] 101
# > 1+
#   + 
#   > 3 + 5 *2
# [1] 13
# > 3 + 5 * 2^2
# [1] 23
# > 2/10000
# [1] 2e-04
# > 5e3
# [1] 5000
# > 5000
# [1] 5000
# > sin(1)
# [1] 0.841471
# > log(1)
# [1] 0
# > log10(10)
# [1] 1
# > exp(0.5)
# [1] 1.648721
# > ?log
# > log1p(0)
# [1] 0
# > 1 == 1
# [1] TRUE
# > 1 != 2
# [1] TRUE
# > 1 < 2
# [1] TRUE
# > 1 <= 1
# [1] TRUE

# Stuff in console not permanent
x <- 1/40

log(x)

# Challenge 1: Which are valid variable names? ----

min_height <- 2
max.height <- 4
_age <- 2 # gives error
.mass <- 2 # "." in front makes it a hidden variable
typeof(.mass)
MaxLength <- 10
min-length <- 10 # doesn't work
2widths <- c(2, 1) # error
celsius2kelvin <- 120

# in console still:

# R is good for vector math!
1:5

ls() # list variables from environment
rm(x)
?rm()

rm(list = ls()) # clears whole environment


##### Challenge 2 ----

mass <- 47.5
age <- 122
mass <- mass*2.3
age <- age-20

age > mass
age == mass
age < mass

## option and dragging cursor allows 
## multiple parts of lines to be selected at once

### Setting up projects for organized and reproducible science
getwd()
setwd("~/Desktop")
setwd("") # once in parentheses, click tab to get suggested folders for wd
setwd("~/Desktop/r-novice-gapminder")

### Make new project
# File >> New Project >> New Directory >> Create Project

# CLOSE R Project

#### BREAK

# R does great with tabular data

getwd()

# Make variables which are vectors with different types of data

?c

coat <- c("calico","black","tabby")
weight <- c(2.1, 5.0, 3.2)
likes_catnip <- c(1,0,1)

typeof(coat)
typeof(weight)
typeof(likes_catnip)

data.frame(coat, weight, likes_catnip)

cats <- data.frame(coat, weight, likes_catnip)

# make new folder for data within working directory
# click folder with green plus in Files panel
# make new "data" folder within wd

write.csv(cats, "data/feline_data.csv", row.names = FALSE)

### Why ".csv" file?

# Universal language that doesn't depend on a specific software,
# like Microsoft
# Changes track easily
# lighter than .xlsx file

rm(list = ls()) # clear environment

cats <- read.csv("data/feline_data.csv") # read back in
cats # check that it looks the same
View(cats)

# Look at individual columns
cats$coat

# we underestimated weight by 2kg for each cat!

# update this column directly in R so that data 
# are original and analysis is clear and reproducible

cats$weight <- cats$weight + 2
cats$weight # check

cats$weight[1] # index the variable vector with the [ ] and number

str(cats)

# Data Types in R ----

typeof(cats$coat)
typeof(cats$weight)
typeof(cats$likes_catnip)
typeof(c(1,2,3))
typeof(as.integer(c(1,2,3)))
new_cat <- data.frame(coat = "tabby", weight = "2.3 or 2.4", likes_catnip = 1)
new_cat
rbind(cats, new_cat)
cats2 <- rbind(cats, new_cat)

str(cats2)

# What has changed about "weights" in "cats2" dataframe?
# Character data was introduced, so must change whole variable to a character

## logical --> integer --> double --> complex --> character

typeof(c("a",TRUE, FALSE))
c("a",TRUE,FALSE) # notice in console that TRUE and FALSE became 
# characters "TRUE" and "FALSE"

c(0, TRUE, FALSE) # combining 0 with TRUE and FALSE makes 
# TRUE and FALSE binary with 0 == FALSE and 1 == TRUE

chr <- c("0","2","4")
chr
as.double(chr)
dbl <- as.double(chr)
dbl
lgl <- as.logical(dbl)
lgl # gives c(FALSE, TRUE, TRUE)
nm <- as.numeric(lgl)
nm


cats2$likes_catnip <- as.logical(cats2$likes_catnip)
cats2$likes_catnip

### Challenge 3 -----

# Correct the weight column in cats2 by taking the average of 
# the 2 values in the 4th cat

cats2$weight
mean(c(2.3,2.4))
cats2$weight[4] <- mean(c(2.3, 2.4))
typeof(cats2$weight)

cats2$weight <- as.numeric(cats2$weight)
# cats2$weight <- as.double(cats2$weight) # will do the same thing as numeric
cats2
mean(cats2$weight)

#### Vectors ----

c("a","b") # a character vector
ab_vector <- c("a","b")
abc_vector <- c(ab_vector, "c")
abc_vector
1:10
seq(10)
mySeries <- seq(from = 1, to = 10, by = 0.1)
head(mySeries) # shows first 6 elements of the object
tail(mySeries) # last 6 elements
tail(mySeries, n = 3)
length(mySeries)
dim(mySeries) # null because doesn't have "dimensions" as a vector
dim(cats2) # 4 rows and 3 columns

#### Lists -----

# NOT the same as vectors

my_list <- list(1,"a","TRUE", 1+4i)
my_list
typeof(my_list)
# lists have elements
# [[]] indicates the nth element of the list, allows different datatypes

typeof(my_list[[1]])
typeof(my_list[[2]])
typeof(my_list[[3]])

another_list <- list(title = "Numbers", numbers = 1:10, data = TRUE)

another_list
View(another_list)

# dataframes are just a special kind of list that requires all elements to be the same length

typeof(cats) # returns "list"!

typeof(another_list)

### Matrices ----

# similar to dataframe BUT all of contents have to be the same data type

# vector with two dimensions

matrix(0, ncol = 6, nrow = 3)
my_matrix <- matrix(0, ncol = 6, nrow = 3)
dim(my_matrix)

another_matrix <- matrix(1:50, nrow = 10, ncol = 5)
another_matrix # Notice matrix values are populated by first column down

another_matrix <- matrix(1:50, nrow = 10, ncol = 5, byrow = TRUE)
another_matrix

### Subsetting Data ----

x <- c(5.4, 6.2, 7.1, 4.8, 7.5) # numeric vector
names(x) # x has no names
names(x) <- c("a","b","c","d","e")
typeof(x) # still just vector of type double/numeric
x
x[1]
x[c(1,3)]
x[c(1,1,3)]
x[6] # gives NA because element #6 doesn't exist
# first element is 1
# (in C, Python, first element is often 0)

x[-2] # give me everything EXCEPT the second [2] element

x[-c(1, 5)]
x[c(-1,-5)]
x <- x[-4]
# now x excludes the 4th element of the original x vector

x["a"] # can also call the name of the element
x[c("a","c")]

# often want to subset based on logical conditions

x > 7

x[x > 7] # keeps only the elements that are TRUE for x > 7

x[x > 4 & x < 7] # elements larger than 4 and smaller than 7

x[x > 4 | x < 7] # elements either greater than 4 or less than 7

# Remove items based on names?
names(x) != "a" # gives vector FALSE, TRUE, TRUE, TRUE
x[names(x) != "a"] # keeps the TRUE elements only

# Because R is vectorized, assumes that lengths match

x[names(x) != c("a","c")] # feels like we will drop "a" and "c" named elements

# but kept c
names(x) # length is 4
c("a","c") # is length 2

# Because c("a","c") is 2 elements long, checks for "a" in first 
# element then "c" in second, the starts again from beginning, 
# looks for "a" in element 3 and "c" in element 4

x[!names(x) %in% c("a","c")]

# Another example of mismatches vector lengths in operations:
1:10 + 1:2

# Below, because length is 1, always recycling same number
1:10 + 100

1:10 + 1:3 # Warning if longer vector length isn't multiple of shorter vector length
# therefore shorter vector wasn't recycled completely to a whole number

?%in%
?`%in%` # Why error?
# Error: unexpected SPECIAL in "?%in%"
# needs to be highlighted

cats
dim(cats)
cats[1,2] # row then column
cats[, 2] # all rows column 2
cats[2, ] # row 2 all columns
cats[2, 1:2]
cats2[-4,]

# Clear console and environment

#### Using real data ----
# get data from this link:
# https://swcarpentry.github.io/r-novice-gapminder/data/gapminder_data.csv

gapminder <- read.csv("gapminder_data.csv")
gapminder # big dataframe, gets truncated in console

str(gapminder) # str (structure) tells us there are 6 variables, 
# country, year, pop, continent, lifeExp, and gdpPercap
head(gapminder)
summary(gapminder) # summarizes each variable

nrow(gapminder) #1704 rows
ncol(gapminder) #6 columns
dim(gapminder)

names(gapminder) # same as colnames if using on a dataframe
colnames(gapminder)
rownames(gapminder)

#### Challenge 5 -----

# Do these operations (fixing errors that come up)

gapminder[gapminder$year = 1957,]
# fixed below
gapminder[gapminder$year == 1957,]

gapminder[,-1:4] 
# fixed below
gapminder[,-c(1:4)]

gapminder[gapminder$lifeExp > 80]
# fixed below
gapminder[gapminder$lifeExp > 80,]
gapminder$lifeExp[gapminder$lifeExp > 80]

gapminder[1,4,5]
# fixed below
gapminder[1,c(4,5)]

dim(gapminder)
gapminder[gapminder$year == 2002|2007,]
gapminder[gapminder$year == 2002 | gapminder$year == 2007,] 
# make sure to fully repeat the logical statement

gapminder[gapminder$year %in% c(2002, 2007),] 
# using match function "%in%"
