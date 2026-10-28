##### Using tidyr 

# Author: Julieanne Montaquila
# Based on software carpentry modules

# https://swcarpentry.github.io/r-novice-gapminder/13-tidyr.html

rm(list = ls())

remove.packages("tidyr")
install.packages("tidyr") 
library(tidyr)
library(dplyr)

gapminder <- read.csv("data/gapminder_data.csv", header = TRUE)


##### Challenge 1 #####
#' Is gapminder a purely long, purely wide, or some 
#' intermediate format?


### pivot_longer() ####
# https://swcarpentry.github.io/r-novice-gapminder/data/gapminder_wide.csv

gap_wide <- read.csv("data/gapminder_wide.csv", header = TRUE,
                     stringsAsFactors = FALSE)

names(gap_wide)
head(gap_wide)

# Let's make the wide data longer

gap_long <- gap_wide %>%
  pivot_longer(cols = c(starts_with('pop'),
                        starts_with('lifeExp'),
                        starts_with('gdpPercap')),
               names_to = "obstype_year",
               values_to = "obs_values")
head(gap_long)
str(gap_long)

# same way but faster
gap_long <- gap_wide %>%
  pivot_longer(
    cols = c(-continent, -country), ### this line can be shortened
    names_to = "obstype_year", values_to = "obs_values"
  )

str(gap_long)

### separate() #####

# function to make two variables from existing one

gap_long <- gap_long %>% 
  separate(obstype_year, into = c('obs_type', 'year'), 
           sep = "_")
str(gap_long)
gap_long$year <- as.integer(gap_long$year)


##### Challenge 2 ######
#' Using gap_long, calculate the mean life expectancy, 
#' population, and gdpPercap for each continent. Hint: use the group_by() and 
#' summarize() functions we learned in the dplyr lesson ####



#### pivot_wider() #####



### notice the names (column names, or variables) are not in the same order

## Use our dataframe subsetting language to reorganize variables to match order


###### unite() ######


## Challenge 3 ######
#' Take this 1 step further and create a gap_ludicrously_wide 
#' format data by pivoting over countries, year and the 3 metrics? 
#' Hint this new data frame should only have 5 rows.

#### Use "separate()" function #####

