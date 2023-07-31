# data visualisation in R 

installed.packages("datasets")
# inbuilt data sets.
plot(ChickWeight)
View(ChickWeight)
 #base graphics
# _x , |y 
library(MASS)
plot(UScereal$sugars,UScereal$calories)
title("plot(UScereal$sugars,UScereal$calories)")

x <- UScereal$sugars
y <- UScereal$calories
library(grid)
# grid graphics.
pushViewport(plotViewport())
pushViewport(dataViewport(x,y))
grid.rect()
grid.xaxis()
grid.yaxis()
grid.points(x,y)
grid.text("UScereal$calories", x= unit(-3,"lines"),rot=90)
grid.text("UScereal$sugars", y = unit(-3, "lines"), rot = 0)
popViewport(2)

# we can use ggplots for bar graphs
# ggplots is data visualization package for creating graphs in R 
# ggplots are part of tidyverse which is an ecosystem of packages designed with common API's.

# to create a bar chart we can use the aesthetics parameter in geom_bar function
library(ggplot2)
head(mpg, n=10)
View(mpg)
# it means str = structure 
str(mpg)
library(tidyverse)
library('nycflights13')
View()
ggplot(mpg) + geom_bar(aes(x= class))
library(tidyr)

# in ggplot, change color

# double quotes 
ggplot(mpg) +
  geom_bar(aes(x = class, fill= "blue"))

# stacked bar charts.
# this bar is a variation of bar chart where a bar is divided among a number of different segments.
# this has been used when i have to visualize one categorical variable:
ggplot(mpg) +
  geom_bar(aes(x = class, fill= drv))

# create a dodged bar chart.
# you can create side by side (dodged ) bar chart using the position = position_dodge().
ggplot(mpg) +
  geom_bar(aes(x= class,
  fill= factor(cyl)), position =
    position_dodge(preserve = "single"))

library(dplyr)

# usage of dplyr to calculate the average hwy_mpg by class
by_hwy_mpg <- mpg %>% group_by(class) %>% summarise(hwy_mpg = mean(hwy))

ggplot(by_hwy_mpg) + geom_bar(aes(x= class, y= hwy_mpg),stat= 'identity' )

View(by_hwy_mpg)

# line graphs
library(tidyverse)

# filter the data we need
#Tree_1 <- filter(orange, Tree == 1)

year_chart <- filter(mpg, year == 1999)
# graph the data.
ggplot(year_chart) +
  geom_line(aes(x = class, y = hwy))
# scatter plot, histogram 


# pie charts for different products and units sold

# create data for the graph
# vector:
x <- c(33,45,70,110)
labels <- c("soap", "shampoo", "detergent", "oil")
# chart file name
# png(file = "city.jpg")
 
# plot the chart 
# length <- length of the vector 
pie(x,labels)
pie(x, labels = piepercent, main = "city pie chart", col = rainbow(length(x)))

# 1 is radius., -1 to +1 radius. , value will be in percentage.
piepercent <- round(100*x/sum(x),1)

# table representation. 
pie(x, labels = piepercent, main= "city pie chart", col = rainbow(length(x)))
legend("topright", c("soap", "shampoo", "detergent", "oil","grocery"),cex = 0.8,
       fill= rainbow(length(x)))



# 3D models
install.packages("plotrix")
library(plotrix)
x <- c(33, 45, 70, 110)
lbl <- c("soap", "shampoo", "detergent", "oil")
# plot the chart
pie3D(x, labels = lbl,explode = 0.1, main= "pie chart of countries")

# create data for the graph
v <- c(9,13,21,4,5,96,42,54,32,78,41)
# create the histogram.
hist(v, xlab = "weight", col= "green", border = "black")

hist(v, xlab = "weight", col= "green", border = "black", xlim = c(0,40),
     ylim = c(0,5), breaks = 5)


data("airquality")
View(airquality)
# use the plot function to draw scatter plots
#plot a graph between the ozone and wind values.
plot(airquality$Ozone, airquality$Wind)
plot(airquality$Ozone, airquality$Wind, col = 'red')
plot(airquality$Ozone, airquality$Wind, type='h', col = 'blue') # histogram

plot(airquality)
# assign labels to plot.
plot(airquality$Ozone, xlab= 'ozone concentration', ylab = 'no of instances', main= 'ozone level in NY CITY', col= 'green')

# histogram
hist(airquality$Solar.R)
hist(airquality$Solar.R, main = 'solar radiation values in air', xlab= 'solar.rad', ylab= 'frequency', col = "white")

Temprature <- airquality$Temp
hist(Temprature)
# View(Temprature)
# histogram with labels
h<- hist(Temprature, ylim=c(0,40))
# to give values to different bars
text(h$mids,h$counts, labels=h$counts, adj=c(0.5, -0.5))

# histogram with non uniform width
hist(Temprature,
     main = "Maximum daily temprature at LA guardia Airport",
     xlab= "Temprature in degrees fahrenheit" ,
     xlim = c(50,100),
     col = "pink",
     border="black" ,
     breaks=c(55,60,70,75,80,100)
    )
# Box plot
boxplot(airquality$Solar.R)
# multiple box plot
boxplot(airquality[,0:4], main = 'multiple box plots')

# using ggplot2 library to analyse mtcars dataset.

library(ggplot2)
attach(mtcars)
# _x , |y 
pl <- ggplot(mtcars, aes(factor(cyl),mpg))
# to create a plot.
pl + geom_boxplot()
# coordinate ko flip kar diya x ki jagha y and vice-versa
pl + geom_boxplot() + coord_flip() 
pl + geom_boxplot(aes(fill = factor(cyl)))

# create factors with value labels
# factors and levels
mtcars$gear <- factor(mtcars$gear, levels=c(3,4,5),
          labels=c("3gears", "4gears","5gears"))

mtcars$am <- factor(mtcars$am, levels=c(0,1),
          labels=c("Automatic", "Manual"))

mtcars$cyl <- factor(mtcars$cyl, levels=c(4,6,8),
          labels=c("4cyl", "6cyl","8cyl"))
mtcars$cyl
mtcars$gear
View(mtcars)

# scatter plots
ggplot(data= mtcars, mapping = aes(x = wt, y = mpg)) + geom_point()
# scatter plots by factors
ggplot(data = mtcars,mapping = aes(x=wt, y = mpg,col= "red")) + geom_point()

# scatter plot by size
ggplot(data = mtcars,mapping = aes(x=wt, y = mpg, size = qsec)) + geom_point()
ggplot(data = mtcars,mapping = aes(x =  wt, y = mpg, col = "violet", size = qsec )) + geom_point()

# visualization using mp dataset ------

ggplot2::mpg
View(ggplot2::mpg)

# bar plot
ggplot(data = ggplot2::mpg, aes(class)) + geom_bar()
 
# stacked bar chart
ggplot(data = ggplot2::mpg, aes(class)) + geom_bar(aes(fill = drv))

# using dodge
ggplot(data= ggplot2::mpg, aes(class)) + geom_bar(aes(fill = drv), position = "dodge")

# scatter plot
ggplot(data = ggplot2::mpg) +
  geom_point(mapping = aes(x= displ, y =  hwy))

ggplot(data = ggplot2::mpg) +
  geom_point(mapping = aes(x = displ, y =  hwy, color = class))

# using plotly library
install.packages("plotly")
library(plotly)
p <- plot_ly(data = mtcars, x= ~hp, y = ~wt, marker = list(size = 10, 
    color= 'rgba(255, 182,193, .9)', 
    line = list(color = 'rgba(152,0,0,.8)', width = 2)))
p

p <- plot_ly(data = mtcars, x = ~hp, y = ~wt, color = ~hp, size = ~hp)
p
