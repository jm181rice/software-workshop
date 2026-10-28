# R Lesson 2: ggplot2

# Julieanne Montaquila

library(ggplot2)
?ggplot2

ggplot(data = gapminder) ### omg it's nothing!

ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp))

#### oooo a blank graph with axes

ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp)) +
  geom_point()

#### Challenge 1 #####
#' Modify this above example to show how life expectancy has changed over time
#' Hint: the gapminder dataset has a column called “year”, 
#' which should appear on the x-axis.
#' 

ggplot(data = gapminder, mapping = aes(x = year, y = lifeExp)) +
  geom_point()


#### Layers #####

ggplot(data = gapminder, mapping = aes(x=year, y=lifeExp, 
                                       color=continent)) +
  geom_line()

## ^^^ This is a useless result. Why do we think it plotted this way?

ggplot(data = gapminder, mapping = aes(x=year, y=lifeExp, 
                                       group=country, 
                                       color=continent)) +
  geom_line()


## Add a point for each record
ggplot(data = gapminder, mapping = aes(x=year, y=lifeExp, 
                                       group=country, 
                                       color=continent)) +
  geom_line() + 
  geom_point()


### Each layer is drawn on top of the previous layer.

ggplot(data = gapminder, mapping = aes(x=year, y=lifeExp, 
                                       group=country)) +
  geom_line(mapping = aes(color=continent)) + 
  geom_point()


#### Challenge 3 #####

#' Switch the order of the point and line layers from the 
#' previous example. What happened?
#' 

ggplot(data = gapminder, mapping = aes(x=year, y=lifeExp, 
                                       group=country)) +
  geom_point() +
  geom_line(mapping = aes(color=continent))

#### Transformations & Stats ####
ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp)) +
  geom_point()

ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp)) +
  geom_point(alpha = 0.5) + 
  scale_x_log10()

ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp)) +
  geom_point(alpha = 0.5) + 
  scale_x_log10() + 
  geom_smooth(method="lm")

ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp)) +
  geom_point(alpha = 0.5) + 
  scale_x_log10() + 
  geom_smooth(method="lm", linewidth=1.5)


#### Challenge 4A #####

#' Modify the color and size of the points on the point layer in the 
#' previous example.
#' 
#' Hint: do not use the aes function.
#' 
#' Hint: the equivalent of linewidth for points is size.
#' 


#### Challenge 4B #####

#'Modify your solution to Challenge 4a so that the points are 
#'now a different shape and are colored by continent with new trendlines. 
#'Hint: The color argument can be used inside the aesthetic.



#### Multi-Panel Figures ######

americas <- gapminder[gapminder$continent == "Americas",]
ggplot(data = americas, mapping = aes(x = year, y = lifeExp)) +
  geom_line() +
  facet_wrap( ~ country) +
  theme(axis.text.x = element_text(angle = 45))


### Modifying Text #####
ggplot(data = americas, mapping = aes(x = year, y = lifeExp, color=continent)) +
  geom_line() + facet_wrap( ~ country) +
  labs(
    x = "Year",              # x axis title
    y = "Life expectancy",   # y axis title
    title = "Figure 1",      # main title of figure
    color = "Continent"      # title of legend
  ) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))


### Exporting the Plot #####

lifeExp_plot <- ggplot(data = americas, mapping = aes(x = year, y = lifeExp, color=continent)) +
  geom_line() + facet_wrap( ~ country) +
  labs(
    x = "Year",              # x axis title
    y = "Life expectancy",   # y axis title
    title = "Figure 1",      # main title of figure
    color = "Continent"      # title of legend
  ) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

ggsave(filename = "results/lifeExp.png", plot = lifeExp_plot, width = 12, height = 10, dpi = 300, units = "cm")

#### Challenge 5 #####

#'Generate boxplots to compare life expectancy between the different continents during the available years.
#'
#'Advanced:
#'  
#'Rename y axis as Life Expectancy.
#'Remove x axis labels.


