x <- 8

if (x >= 10) { # evaluate condition
  print("x is greater than or equal to 10!") # perform actions
}

if (x <= 10) { # evaluate condition
  print("x is greater than or equal to 10!") # perform actions
}

if (x >= 10) { # evaluate condition
  print("x is greater than or equal to 10!") # condition is TRUE
} else {
  print("x is less than 10!") # condition is FALSE
}

x <- 12

if (x >= 10) { # evaluate condition
  print("x is greater than or equal to 10!") # condition is TRUE
} else {
  print("x is less than 10!") # condition is FALSE
}

x <- 7

if (x >= 10) { # evaluate condition
  print("x is greater than or equal to 10!") # condition is TRUE
} else if (x > 5 ) {
  print("x is greater than 5 but less than 10")
} else {
  print("x is less than 10!") # condition is FALSE
}
getwd()
setwd("/Users/julieannemontaquila/Desktop/r-novice-gapminder/data")
cats <- read.csv("feline_data.csv")

if (any(cats$coat == "tabby")) {
  print(cats$weight)
} else {
  print("No tabby")
}

1:10 > 5

if(1:10 > 5) print ("hello")

## Challenge -----

#Add the command to read the gapminder dataset to you R Script and run it.
#Use if() statement to print a suitable message reporting whether there are 
#records from 2002. Now for 2012.

gapminder <- read.csv("gapminder_data.csv")

if (any(gapminder$year == 2002)) {
  print("Records from 2002 detected.")
} else {
  print("No records from 2002 detected")
}

if (any(gapminder$year == 2012)) {
  print("Records from 2012 detected.")
} else {
  print("No records from 2012 detected")
}

year <- 2002

gapminder$year == year

nrow(gapminder[gapminder$year == year,]) >= 1 # is there at least one row in the subsetted data?

year <- 2012

if (nrow(gapminder[gapminder$year == year,]) >= 1) {
  print(paste("Records for year", year, "found."))
} else {
  print(paste("Records for year", year, "NOT found."))
}

any(gapminder$year == year)

if(any(gapminder$year == year)) {
  print(paste("Records for year", year, "found."))
} else {
  print(paste("Records for year", year, "NOT found."))
}

i <- 1:20

for (i in 1:10) {
  print(i)
}

cats <- read.csv("feline_data.csv")

i <- c(1:5)

for (cats$coat[i] == "tabby") {
  print("is tabby")
}

if (any(i == "tabby")) {
  print(cats$weight)
} else {
  print("No tabby")
}

for(i in 1:5) {
  for (j in c("a", "b","c","d","e")) {
    print(paste(i,j))
  }
  
}

cats <- read.csv("feline_data.csv")

for (i in cats) {
  cat <- cats[cats$coat == i,]
  weight <- cats$weight
  if (weight > 4) {
    print(paste("Weight of", i, "is greater than 4 kg"))
  } else {
    print(paste("Weight of", i, "is less than 4 kg"))
  }
  rm(cat, weight)
}


# Loop through countries and print whether lifespan is some condition

i <- unique(gapminder$country)[1]

for (i in unique(gapminder$country)) {
  gm <- gapminder[gapminder$country == i,]
  le <- mean(gm$lifeExp)
  if (le > 70) {
    print(paste("Mean life expectancy for", i, "is greater than 70"))
  } else {
    print(paste("Mean life expectancy for", i, "is less than 70"))
  }
  rm(gm,le)
}

### Using and making functions ----

# clear enviornment
rm(list = ls())

getwd()
source("/Users/julieannemontaquila/Desktop/r-novice-gapminder/data/functions.R") # source runs another R script in the background

# want to make things modular and simple

