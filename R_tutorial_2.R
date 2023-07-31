library("dplyr")
library('nycflights13')

install.packages('nycflights13')
library('nycflights13')

View(flights)
head(flights)

# subset data using filter function:
# f1 is a variable here : 
f1 <- filter(flights,month==07)
View(f1)
f2 <-filter(flights,month==07, day==3)
View(f2)
View(filter(flights,month==09,day==2, origin=="LGA"))

#OR here we have specified columns more precisely.
head(flights[flights$month==09 & flights$day==2 & flights$origin=='LGA', ])


library("dplyr")
library('nycflights13')
# slice () is used to add new column
slice(flights,1:5)
slice(flights,5:10)

# mutate () is used to add new column , arrival delay minus departure delay.V
over_delay<-mutate(flights, overall_delay = arr_delay - dep_delay)
View(over_delay)
head(over_delay)
View(flights)

# transmute() is used to show only new column
over_delay <- transmute(flights, overall_delay = arr_delay - dep_delay)
View(over_delay)

# Summarize () is used to find descriptive statistics
# usage of inbuilt functions is done here.
# you can find mean, sum, standard deviation on the variables, columns. 
summarize(flights, avg_air_time = mean(air_time, na.rm = T))
summarize(flights, tot_air_time = sum(air_time, na.rm = T))
summarize(flights, std_dev_air_time = sd(air_time, na.rm = T))
summarize(flights, avg_air_time = mean(air_time,na.rm= T),tot_air_time=sum(air_time,na.rm=T))

# group by calculation using group_by()

# example 1 , %>% pipeline
head(mtcars)
View(mtcars)
# here grouping is done using particular column that is gear.
by_gear<-mtcars %>% group_by(gear)
by_gear
View(by_gear)
# sum = summation
a<- summarise(by_gear, gear1= sum(gear), gear2= mean(gear))
a

## confusion...
summarise(group_by(mtcars, cyl), mean(gear))

b<- by_gear %>% summarise(gear1=sum(gear), gear2=mean(gear))
b

library("dplyr")
library('nycflights13')


# example 2 
by_cyl <- mtcars %>% group_by(cyl)

by_cyl %>% summarise(
  gear = mean(gear),
  hp = mean(hp)
)
head(by_cyl)
#sample_n() and fraction  sample_frac are used to creating samples....

sample_n(flights, 15) # gives 15 random samples.
sample_frac(flights, 0.4) # returns 40% of the total data.

# arrange() is used to sort dataset

View(arrange(flights,year,dep_time))
head(arrange(flights,desc(dep_time)))

# usage of pipe operator %>% 
# df = different models
df <- mtcars
df
View(mtcars)

# nesting
# by default arranging order is always ascending

result <- arrange(sample_n(filter(df,mpg>20), size = 5), desc(mpg))
View(result)

# for multiple assignment
# df was assigned mtcars
a <- filter(df, mpg>20)

#  taking sample out of a
b <- sample_n(a, size =5)
# result is shown in desc order.
result <- arrange(b,desc(mpg))
result
View(result)


library("dplyr")
library('nycflights13')

# same using pipe operator 
# syntax: data %>% op1 %>% op2 %>% op3
result<- df %>% filter(mpg>20) %>% sample_n(size=10) %>% arrange(desc(mpg))
result


# here we could have used filter but it will always asks for condition.
# select function is used: for specific column or data.
df
df_mpg_hp_cyl = df %>% select(mpg,hp,cyl)
head(df_mpg_hp_cyl)

# tidyr
library(tidyr)

n= 10
# it is a vector face 1 , face 2 , face 3
wide <- data.frame(
  ID = c(1:n),
  Face.1 = c(411, 456, 423, 976, 376, 207, 389, 678, 299, 674),
  Face.2 = c(678, 390, 290, 499, 100, 348, 109, 290, 103, 477),
  Face.3 = c(103, 260, 299, 192, 408, 149, 167, 476, 200, 500)
  )
View(wide)

# gather() reshaping data from wide format to long format.
# stacking up multiple columns
# response time and Face is column name.
long <- wide %>% gather(Face, ResponseTime, Face.1:Face.3)
View(long)

# separate() - it splits column into multiple column
# face has been split
long_separate <- long %>% separate(Face, c("Target", "number"))
View(long_separate)

# unite() - combines multiple columns into a single column
long_unite <- long_separate %>% unite(Face, Target, number, sep = ".")
View(long_unite)

# spread() - takes two columns (key & value) and spreads into multiple column.
# it makes long data wider.

back_to_wide <- long_unite %>% spread(Face, ResponseTime)
View(back_to_wide)





