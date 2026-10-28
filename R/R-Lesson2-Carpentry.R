#### R Lesson 2

## Data Wrangling and Visualization
## Thursday October 29th, 2026

# Instructor: Julieanne Montaquila

# Clear your global environment

rm(list = ls())

gapminder <- read.csv("gapminder_data.csv", header = TRUE)

# Not working! Why?
# First thing: check your working directory. Is your file in there?
# Is it hidden within another folder?
getwd()

#solution a:
gapminder <- read.csv("data/gapminder_data.csv", 
                      header = TRUE)

# solution b:
setwd()
gapminder <- read.csv("gapminder_data.csv", header = TRUE)

str(gapminder)

gapminder <- read.csv("data/gapminder_data.csv", 
                      header = TRUE,
                      stringsAsFactors = FALSE)

str(gapminder)

## Extra: what is a factor variable?

## shortcut to read in character strings as factors:

## Levels and ordering of factors

gapminder$continent
# Levels: Africa Americas Asia Europe Oceania

# Base R (the "base" package automatically in your library) 
# has lots of useful operations
mean(gapminder$gdpPercap[gapminder$continent == "Africa"])

install.packages("dplyr")
library(dplyr)
?dplyr

### Find out the proper citation for a package and version you are using:####

?select()
?'%>%'
  

# In Chapter 4 we covered how you can rename columns with base R by 
# assigning a value to the output of the names() function. Just like select, this is a bit cumbersome, but thankfully dplyr has a rename() function.

# Within a pipeline, the syntax is rename(new_name = old_name). 
# For example, we may want to rename the gdpPercap column name from our select() 
# statement above.



##### filter() ----



#### Challenge 1 ####

#' Write a single command (which can span multiple lines 
#' and includes pipes) that will produce a data frame that has 
#' the African values for lifeExp, country and year, but 
#' not for other Continents. 
#' 
#' How many rows does your data frame have and why?



######## group_by() #####


##### summarize() #######

#### Challenge 2 #######
#' Calculate the average life expectancy per country. 
#' Which has the longest average life expectancy and 
#' which has the shortest average life expectancy?
#' 

### Can also do multiple variables

##### count() and n() #####

?tally
#' ^^^ notice we used n() here to call the count number for 
#' each grouped row, including it in the equation for standard error 
# without having to make a new variable for count first


#### mutate() #####

#'Suppose we want not only to get new information as an output,
#'but to include this information as a new variable in our data frame()


###### Connect mutate with logical filtering: ifelse ####

## Keeping all data but "filtering" for a certain condition of a variable:
# calculate GDP only for people with a life expectation above 25
gdp_pop_bycontinents_byyear_above25 <- gapminder %>%
  mutate(gdp_billion = ifelse(lifeExp > 25, gdpPercap * pop / 10^9, NA)) %>%
  group_by(continent, year) %>%
  summarize(mean_gdpPercap = mean(gdpPercap),
            sd_gdpPercap = sd(gdpPercap),
            mean_pop = mean(pop),
            sd_pop = sd(pop),
            mean_gdp_billion = mean(gdp_billion),
            sd_gdp_billion = sd(gdp_billion))

## updating only if certain condition is fulfilled
# for life expectations above 40 years, the gpd to be expected in the future is scaled

###### Combine with ggplot2 #####

install.packages("ggplot2")
library(ggplot2)
# Filter countries located in the Americas
americas <- gapminder[gapminder$continent == "Americas", ]
# Make the plot
ggplot(data = americas, mapping = aes(x = year, y = lifeExp)) +
  geom_line() +
  facet_wrap( ~ country) +
  theme(axis.text.x = element_text(angle = 45))
