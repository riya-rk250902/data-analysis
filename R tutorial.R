
# R tutorial 1 
# dplyr is used to summarize  and transform tabular data with rows and columns.
# select
# basic operations in R 
# 5 + 7 add, abs(-17), x <- -12 , x+7, abs(x), y <- c[12, 6, 0, -1]
# important points to remember while working on R : 

# imagine you have some NA values in your column and you don't want to include them you can simply remove them by using (THIS IS FOR MEAN)
# mean(tablename$columnname, na.rm = TRUE)    ->>>> syntax
# mean(tablename$columnname)  ->>> normal mean implementation syntax.

# very important library to execute
library(tidyverse)
# this will show you a lot of data sets list and you can select them from the following list.
data()
View(mpg)
# when you want to know about the data set 
?mpg
?mean

glimpse(mpg)

?filter
filter(mpg, cty >=20)
mpg_efficient <- filter(mpg, cty >= 20)
# after view we can see that all these cars have these city mileage of at least 20
View(mpg_efficient)

# this represents that all values of manufacturer is ford 
mpg_ford <- filter(mpg, manufacturer == "ford")
View(mpg_ford)

# to add a one more column here:
mpg_metric <- mutate(mpg, city_metric = 0.425144 * cty)

library(dplyr)
# mpg = miles per gallon formula conversion

mpg_metric <- mutate(mpg, cty_metric = 0.425144 * cty)

glimpse(mpg_metric)

# pipe function is used when we don't want to use the mpg (data set) again and again 
# ctrl + shift + m for pipe.
mpg_metric <- mpg %>%
  mutate(cty_metric = 0.425144 * cty)

# group by
View(mpg)
mpg %>%
  group_by(class) %>%
  summarise(mean(cty),
            median(cty))
  # data viz with ggplot 
# ggplot is a one of the core pieces of the tidyverse
# ggplot stands for the grammar of graphics.
# aesthetic is used to give what my x is doing in which way it is going.

ggplot(mpg, aes(x = cty)) + 
  geom_histogram() +
# we have used this to change the value of x 
  labs(x = "City mileage")

# histogram + freq both will appear here 
ggplot(mpg, aes(x = cty)) + 
  geom_histogram() +
  geom_freqpoly()
  labs(x = "City mileage")
# geometric points
  ggplot(mpg, aes(x=cty,
                  y=hwy)) +
   geom_point() +
    # here the gray line is confidence
    geom_smooth(method = "lm")

ggplot(mpg, aes(x = cty,
                y = hwy,
                color= class)) +
  geom_point() +
# for darker colors 
scale_color_brewer(palette = "Dark2")




  
