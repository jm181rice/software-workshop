#### R Lesson 2

## Data Wrangling and Visualization

## Thursday October 29th, 2026

# Julieanne Montaquila

# Clear your global environment

rm(list = ls())

gapminder <- read.csv("gapminder_data.csv", header = TRUE)

getwd()

gapminder <- read.csv("data/gapminder_data.csv", 
                      header = TRUE)

str(gapminder)

gapminder <- read.csv("data/gapminder_data.csv", 
                      header = TRUE,
                      stringsAsFactors = TRUE)

str(gapminder)

gapminder$continent
# Levels: Africa Americas Asia Europe Oceania

# Base R (the "base" package automatically in your library) 
# has lots of useful operations
mean(gapminder$gdpPercap[gapminder$continent == "Africa"])
mean(gapminder$gdpPercap[gapminder$continent == "Americas"])
mean(gapminder$gdpPercap[gapminder$continent == "Asia"])

install.packages("dplyr")
library(dplyr)
?dplyr

### Find out the proper citation for a package and version you are using:####
citation("dplyr")

?select()
?'%>%'
  
year_country_gdp <- select(gapminder, year, country, gdpPercap)
smaller_gapminder_data <- select(gapminder, -continent)

year_country_gdp <- gapminder %>% 
  select(year, country, gdpPercap)

# In Chapter 4 we covered how you can rename columns with base R by 
# assigning a value to the output of the names() function. Just like select, this is a bit cumbersome, but thankfully dplyr has a rename() function.

# Within a pipeline, the syntax is rename(new_name = old_name). 
# For example, we may want to rename the gdpPercap column name from our select() 
# statement above.

tidy_gdp <- year_country_gdp %>% 
  rename(gdp_per_capita = gdpPercap)

head(tidy_gdp)


##### filter() ----

year_country_gdp_euro <- gapminder %>%
  filter(continent == "Europe") %>%
  select(year, country, gdpPercap)


europe_lifeExp_2007 <- gapminder %>%
  filter(continent == "Europe", year == 2007) %>%
  select(country, lifeExp)


#### Challenge 1 ####

#' Write a single command (which can span multiple lines 
#' and includes pipes) that will produce a data frame that has 
#' the African values for lifeExp, country and year, but 
#' not for other Continents. 
#' 
#' How many rows does your data frame have and why?

Africa <- gapminder %>%
  filter(continent == "Africa") %>%
  select(lifeExp, country, year)

# 624 rows
str(Africa)
Africa$country


######## group_by() #####
str(gapminder)
str(gapminder %>% group_by(continent))


##### summarize() #######
gdp_bycontinents <- gapminder %>%
  group_by(continent) %>%
  summarize(mean_gdpPercap = mean(gdpPercap))

gdp_bycontinents

#### Challenge 2 #######
#' Calculate the average life expectancy per country. 
#' Which has the longest average life expectancy and 
#' which has the shortest average life expectancy?
#' 

names(gapminder)

lifeExp_bycountry <- gapminder %>%
  group_by(country) %>%
  summarize(mean_lifeExp = mean(lifeExp))

lifeExp_bycountry %>%
  filter(mean_lifeExp == min(mean_lifeExp) 
         | mean_lifeExp == max(mean_lifeExp))

summary(mean_LE_country)
# 36.77 
# 76.51 
min(mean_LE_country$mean_lifeExp)

View(mean_LE_country)
# Sierra Leone	36.76917
# Iceland	76.51142


### Can also do multiple variables

gdp_bycontinents_byyear <- gapminder %>%
  group_by(continent, year) %>%
  summarize(mean_gdpPercap = mean(gdpPercap))

gdp_pop_bycontinents_byyear <- gapminder %>%
  group_by(continent, year) %>%
  summarize(mean_gdpPercap = mean(gdpPercap),
            sd_gdpPercap = sd(gdpPercap),
            mean_pop = mean(pop),
            sd_pop = sd(pop))

##### count() and n() #####

gapminder %>%
  filter(year == 2002) %>%
  count(continent, sort = TRUE)



gapminder %>%
  group_by(continent) %>%
  summarize(se_le = sd(lifeExp)/sqrt(n()))

#' ^ notice we used n() here to call the count number for 
#' each grouped row, including it in the equation for standard error 
# without having to make a new variable for count first

gapminder %>%
  group_by(continent) %>%
  summarize(
    mean_le = mean(lifeExp),
    min_le = min(lifeExp),
    max_le = max(lifeExp),
    se_le = sd(lifeExp)/sqrt(n()))


#### mutate() #####

#'Suppose we want not only to get new information as an output,
#'but to include this information as a new variable in our data frame()
#'
#'

gdp_pop_bycontinents_byyear <- gapminder %>%
  mutate(gdp_billion = gdpPercap*pop/10^9) %>%
  group_by(continent,year) %>%
  summarize(mean_gdpPercap = mean(gdpPercap),
            sd_gdpPercap = sd(gdpPercap),
            mean_pop = mean(pop),
            sd_pop = sd(pop),
            mean_gdp_billion = mean(gdp_billion),
            sd_gdp_billion = sd(gdp_billion))



###### Connect mutate with logical filtering: ifelse ####

#' When creating new variables, we can hook this with a logical condition. 
#' A simple combination of mutate() and ifelse() facilitates filtering 
#' right where it is needed: in the moment of creating something new. 
#' This easy-to-read statement is a fast and powerful way of discarding 
#' certain data (even though the overall dimension of the data frame will 
#' not change) or for updating values depending on this given condition.
#' 
#' 
#' 

## keeping all data but "filtering" after a certain condition
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

## updating only if certain condition is fullfilled
# for life expectations above 40 years, the gpd to be expected in the future is scaled
gdp_future_bycontinents_byyear_high_lifeExp <- gapminder %>%
  mutate(gdp_futureExpectation = ifelse(lifeExp > 40, gdpPercap * 1.5, gdpPercap)) %>%
  group_by(continent, year) %>%
  summarize(mean_gdpPercap = mean(gdpPercap),
            mean_gdpPercap_expected = mean(gdp_futureExpectation))

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



### using tidyr #####

install.packages("tidyr")
library(tidyr)
library(dplyr)

gapminder <- read.csv("data/gapminder_data.csv", header = TRUE)
str(gapminder)

#' Challenge 1
#' Is gapminder a purely long, purely wide, or some 
#' intermediate format?


### From wide to long format with pivot_longer() ####

gap_wide <- read.csv("data/gapminder_wide.csv", stringsAsFactors = FALSE)
str(gap_wide)

gap_long <- gap_wide %>%
  pivot_longer(
    cols = c(starts_with('pop'), starts_with('lifeExp'), starts_with('gdpPercap')),
    names_to = "obstype_year", values_to = "obs_values"
  )
str(gap_long)

gap_long <- gap_wide %>%
  pivot_longer(
    cols = c(-continent, -country),
    names_to = "obstype_year", values_to = "obs_values"
  )
str(gap_long)

gap_long <- gap_long %>% 
  separate(obstype_year, into = c('obs_type', 'year'), sep = "_")
gap_long$year <- as.integer(gap_long$year)

##### Challenge 2 ######
#' Using gap_long, calculate the mean life expectancy, 
#' population, and gdpPercap for each continent. Hint: use the group_by() and 
#' summarize() functions we learned in the dplyr lesson ####
#' 


#### From long to intermediate format with pivot_wider() #####

gap_normal <- gap_long %>%
  pivot_wider(names_from = obs_type, values_from = obs_values)
dim(gap_normal)
# 1704 rows and 6 columns

dim(gapminder)

names(gap_normal)
names(gapminder)
### notice the names (column names, or variables) are not in the same order

## Use our dataframe subsetting language to reorganize variables to match order

gap_normal <- gap_normal[, names(gapminder)]
all.equal(gap_normal, gapminder)

head(gap_normal)
head(gapminder)

gap_normal <- gap_normal %>% 
  arrange(country, year)
all.equal(gap_normal, gapminder)

###### Unite() function ######
gap_temp <- gap_long %>% unite(var_ID, continent, country, sep = "_")
str(gap_temp)

gap_temp <- gap_long %>%
  unite(ID_var, continent, country, sep = "_") %>%
  unite(var_names, obs_type, year, sep = "_")
str(gap_temp)


gap_wide_new <- gap_long %>%
  unite(ID_var, continent, country, sep = "_") %>%
  unite(var_names, obs_type, year, sep = "_") %>%
  pivot_wider(names_from = var_names, values_from = obs_values)
str(gap_wide_new)

## Challenge 3 ######
#' Take this 1 step further and create a gap_ludicrously_wide 
#' format data by pivoting over countries, year and the 3 metrics? 
#' Hint this new data frame should only have 5 rows.

gap_ludicrously_wide <- gap_long %>%
  unite(var_names, obs_type, year, country, sep = "_") %>%
  pivot_wider(names_from = var_names, values_from = obs_values)
head(gap_ludicrously_wide)

#### Use "separate()" function #####

gap_wide_betterID <- separate(gap_wide_new, ID_var, c("continent", "country"), sep="_")
gap_wide_betterID <- gap_long %>%
  unite(ID_var, continent, country, sep = "_") %>%
  unite(var_names, obs_type, year, sep = "_") %>%
  pivot_wider(names_from = var_names, values_from = obs_values) %>%
  separate(ID_var, c("continent","country"), sep = "_")
str(gap_wide_betterID)

all.equal(gap_wide, gap_wide_betterID)
