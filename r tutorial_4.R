
# R tutorial
# 4th : Time series
# create a data frame for our data set.

mydata<- read.csv("C:\\Users\\Lenovo\\csv data_files\\csv file sample_data\\doc_1\\opsd_germany_daily.txt"
                  , header= TRUE, row.names = "Date")
mydata
# looking at part of data frame using head() or tail ()
head(mydata)
tail(mydata)
# view data in tabular format
View(mydata)
# Retrieve the dimension of object.
dim(mydata)

# checks datatype of each column in data frame.
str(mydata)
# looking at date column ( will not show date as its index)
# date as a col does not exist because we created as an index
head(mydata$Date)

#looking at row names(index column)
row.names(mydata)

# accessing a specific row
mydata["2006-01-01",]
mydata["2017-08-12",]

# accessing multiple rows
mydata[c("2006-02-12","2017-09-02"),]
# for each column
summary(mydata)
# without parsing date column
mydata2 <- read.csv("C:\\Users\\Lenovo\\csv data_files\\csv file sample_data\\doc_1\\opsd_germany_daily.txt", header = TRUE)
mydata2
# look at Date column (factor format)
str(mydata2$Date)

# convert into date_format
# str is format
x<- as.Date(mydata2$Date)
head(x)
class(x)
str(x)

# now how we are going to extract values from it and make it a part of data frame.
# create year, month, day columns
# Y is year component.
year <- as.numeric(format(x,'%Y'))
head(year)
month <- as.numeric(format(x, '%m'))
head(month)
day <- as.numeric(format(x, '%d'))
head(day)

head(mydata2)
# add columns to the existing data frame
mydata2 <- cbind(mydata2,year,month, day)
head(mydata2)
mydata2[1:10,]
head(sample(mydata2,8))
# visualization
# let's create a line plot of the full time series of Germany.
# daily electricity consumption, using the data frame's plot() method
# using plot()

# option: 1
plot(mydata2$year, mydata2$Consumption, type = "l",xlab = "year", ylab = "Consumption")
# option: 2
plot(mydata2$year, mydata2$Consumption, type = "l",xlab = "year", ylab = "Consumption"
     ,lty=1, ylim = c(800,1700), xlim = c(2006,2018))
# better options :
# option 3:
# for one plot/ window
par(mfrow=c(1,1))
plot(mydata2[,2])

# option : 4
plot(mydata2[,2], xlab = "year", ylab = "Consumption")
plot(mydata2[,2], xlab= "year", ylab = "Consumption", type = "l", lwd=2, col = "blue")
plot(mydata2[,2], xlab= "year", ylab = "Consumption", type = "l", lwd=2, xlim = c(0,2018))
# Rep. is graphical here and precise due to proper limit.
plot(mydata2[,2], xlab= "year", ylab = "Consumption", type = "l", lwd=2, xlim = c(2006,2018))
plot(mydata2[,2], xlab= "year", ylab = "Consumption", type = "l", lwd=2, xlim = c(2006,2018), 
     ylim = c(900, 2000), main= "Consumption Graph")

# Taking log values of consumption and take differences of logs.
plot(10*diff(log(mydata2[,2])), xlab = "year", ylab = "Consumption", type="l", lwd = 2,
    ylim = c(-5,5), main="Consumption Graph", col = "turquoise" )

# *********** ggplot ***********
library(ggplot2)
# option 1 :
ggplot(mydata2, type = "o") + geom_line(aes(x= year, y =  Consumption))

# option 2 :
# point is for scatter plot.
ggplot(data = mydata2, aes(x=  year, y = Consumption, group = 1)) + geom_line() +
  geom_point()

# OPTION 3:
ggplot(data = mydata2, aes(x= year, y =  Consumption, group = 1)) + geom_line(linetype = "dashed") + geom_point()
ggplot(data = mydata2 , mapping = aes(x = year, y = Consumption, col = "red")) + geom_point()

# WE can see that plot() method has chosen pretty good tick location.
# every 2 years and labels (the year) as for the x axis.
# however, with so many data points, the line plot is crowded and hard to read.
# thus we can go with the plot()

# plot the data considering the solar and wind time series too.
 mydata2
# wind column
min(mydata2[,3],na.rm = T)
max(mydata2[,3],na.rm = T)

# Consumption column
min(mydata2[,2],na.rm = T)
max(mydata2[,2],na.rm = T)

# solar
min(mydata2[,4],na.rm = T)
max(mydata2[,4],na.rm = T)

#Wind + solar
min(mydata2[,5],na.rm = T)
max(mydata2[,5],na.rm = T)

# FOR multiple plots.
# graphical parameters
# The mfrow() parameter allows to split the screen in several panels.
# You have to provide a vector of length 2 to mfrow(): number of rows and number of columns.
# multiple plots in one window.
par(mfrow =c(2,2))

# or
plot1 <- plot(mydata2[,2],xlab = "year", ylab="Daily Totals (Gwh)", type = "l",
lwd= 2, main = "Consumption", col = "Orange", ylim= c(840,1750))

# error 
plot1 <- plot(mydata2[,1], mydata2[,2],xlab = "year", ylab="Daily Totals (Gwh)", type = "l",
          lwd = 2, main = "Consumption", col = "Orange", ylim= c(840,1750))



plot2 <-  plot(mydata2[,4],xlab = "year", ylab="Daily Totals (Gwh)", type = "l",
                main = "Solar", col = "blue", ylim= c(0,500))
# error
plot2 <-  plot(mydata2[,1],mydata2[,4], xlab = "year", ylab="Daily Totals (Gwh)", type = "l",
                main = "Solar",  ylim= c(0,500),col = "blue")

plot3 <-  plot(mydata2[,3],xlab = "year", ylab="Daily Totals (Gwh)", type = "l",
          lwd=2, main = "Wind",  ylim= c(0,900),col = "purple")

#    *********error in usage of double columns************.

plot3 <-  plot(mydata2[,1],mydata2[,3],xlab = "year", ylab="Daily Totals (Gwh)", type = "l",
               lwd=2, main = "Wind",  ylim= c(0,900),col = "green")

# lets plot time series in a single year to investigate further.
str(mydata2)
x<- as.Date(mydata2$Date)
head(x)
class(x)
str(x)
# to convert date column into date format.
moddate <- as.Date(x, format = "%m %d %Y")

str(moddate)
mydata3 <- cbind(moddate,mydata2)
head(mydata3)
str(mydata3)

# let's extract data for a particular year.
# data wrangling.
mydata4 = subset(mydata3, subset = mydata3$moddate >= '2017-01-01' & mydata3$moddate <= '2017-12-31')
head(mydata4)

plot4 <- plot(mydata4[,1],mydata4[,3],xlab= "year",ylab = "Daily Totals (Gwh)", type = "l",
              lwd = 2, main = "Consumption", col = "yellow")
# zooming in further.
mydata4 = subset(mydata3,subset = mydata3$moddate >= '2017-01-01' & mydata3$moddate <= '2017-02-28')
head(mydata4)

xmin<- min(mydata4[,1], na.rm = T)
xmax<- max(mydata4[,1], na.rm = T)
xmin
xmax
ymin <- min(mydata4[,3], na.rm = T)
ymax <- max(mydata4[,3], na.rm = T)
ymin
ymax
plot4 <- plot(mydata4[,1],mydata4[,3],xlab= "year", ylab= "Daily Totals (Gwh)", type = " l",
          lwd = 2, main = "Consumption", col = "salmon",
          xlim=c(xmin, xmax), ylim = c(ymin,ymax))

# grid()

# add solid horizontal lines
# abline(h=c(1300,1500,1600))
# add dashed blue vertical line at x = 
# abline(v=seq(xmin,xmax,7),lty = 2, col = "pink")

# seasonality for Box plot.
# ################
boxplot(mydata3$Consumption)
boxplot(mydata3$Solar)
boxplot(mydata3$Wind)

# Box plot is visual display of 5 number summary
# numeric value of probability in vector.
quantile(mydata3$Consumption, prob = c(0,0.25,0.5,0.75,1))
boxplot(mydata3$Consumption, main = "Consumption", ylab = "Consumption",
        ylim = c(600,1800))

# YEARLY
# consumption but group based on year.
boxplot(mydata3$Consumption ~ year, main = "Consumption",
        ylab = "Consumption", xlab = "years", ylim = c(600,1800))

# las is label of axis style.
boxplot(mydata3$Consumption ~ year, main = "Consumption",
        ylab = "Consumption", xlab = "years",
        ylim = c(600,1800), las = 1)

# monthly
boxplot(mydata3$Consumption ~ month, main = "Consumption",
        ylab = "Consumption", xlab = "years",
        ylim = c(600,1800), las = 1)

# multiple plots
par(mfrow = c(2,2))

boxplot(mydata3$Consumption ~ month, main = "Consumption",
        ylab = "Consumption", xlab = "month",
        ylim = c(600,1800), las = 1, col = "red")

boxplot(mydata3$Wind ~ month, main = "Wind",
        ylab = "Wind", xlab = "month",
        ylim = c(0,900), las = 1, col = "pink")

boxplot(mydata3$Solar ~ month, main = "Solar",
        ylab = "Solar", xlab = "month",
        ylim = c(0,200), las = 1, col = "green")
# days
par(mfrow = c(1,1))
boxplot(mydata3$Consumption ~ day, main  = "Consumption",
        ylab = "Consumption", xlab= "days",
        ylim = c(600,1800), las = 1, col = "turquoise")
mydata3
library(dplyr)
summary(mydata3)
# if we want to find out the sum of each column, how many entries does it have and na values should not be consider.
colSums(!is.na(mydata3))
sum(is.na(mydata3$Consumption))
sum(is.na(mydata3$Wind))
sum(is.na(mydata3$Solar))
sum(is.na(mydata3$Wind.Solar))

# Frequencies
xmin <- min(mydata3[,1], na.rm = T)
xmin
# for minimum , day wise frequency and for 5 entries.
freq1 <- seq(from= xmin, by = "day", length.out = 5)
freq1
typeof(freq1)
class(freq1)
# for month
freq2 <- seq(from= xmin, by = "month", length.out = 5)
freq2
# for year
freq3 <- seq(from= xmin, by = "year", length.out = 5)
freq3

# *************************************************
# let's select data which has NA values for wind
# By using the %in% operator in R we can check 
#if the values of the first vector are present in the second vector and get a logical vector indicating 
# if there is a match or not for its left operand. It takes each element of the left vector and checks
# if it is present in the second vector, if it presents the corresponding value is represented as TRUE otherwise FALSE.
selwind1 <- mydata3[which(is.na(mydata3$Wind)),
names(mydata3) %in% c("moddate","Consumption", "Wind","Solar")]
selwind1[1:10,]
View(selwind1)

# let's select data which does not have NA values for wind.
selwind2 <- mydata3[which(!is.na(mydata3$Wind)),
                    names(mydata3) %in% c("moddate","Consumption", "Wind","Solar")]
selwind2[1:10,]
View(selwind2)
# looking at result of above 2 , we know that year 2011 has wind column with some missing values.

selwind3 <- mydata3[which(mydata3$year == "2011"),
                    names(mydata3) %in% c("moddate","Consumption", "Wind","Solar")]
selwind3[1:10,]
class(selwind3)
View(selwind3)
 # no of rows in resultant data frame
nrow(selwind3)
# 253 to 258
# are there any NA values.
###########################################
# find number of NA values for particular year.
sum(is.na(mydata3$Wind[which(mydata3$year == "2011")]))

# find number of non NA values for particular year.
sum(!is.na(mydata3$Wind[which(mydata3$year == "2011")]))
str(selwind3)

selwind4 <- selwind3[which(is.na(selwind3$Wind)),
names(selwind3) %in% c("moddate","Consumption", "Wind","Solar")]
selwind4

# we know the data follows a day wise frequency
# let's select data which has NA and non NA values
# useful for trend detection.
# forward fill and backward fill them using the previous year same month data.
test1<- selwind3[which(selwind3$moddate > "2011-12-12" & selwind3$moddate <" 2011-12-16"),
                names(selwind3) %in% c("moddate","Consumption", "Wind","Solar")]
test1
class(test1)
str(test1)
library(tidyr)
test1 %>% fill(Wind)
# time series to frequency
# convert it to frequency, month, week, daily
# thus we can take care of missing values in our frequency data using direction which allows us to analyze the data in a better way.

# trends of data

install.packages("zoo")
library("zoo")
test_03da = zoo::rollmean(mydata3$Consumption,k = 3, fill = NA)
str(test_03da)

# trend analysis, looking at rolling mean.
mydata3
threedayTest <- mydata2 %>% 
  dplyr:: arrange(desc(year)) %>%   
  dplyr:: group_by(year) %>% 
  dplyr:: mutate(test_03da = zoo::rollmean(Consumption, k = 3, fill = NA),
                 ) %>% 
  dplyr:: ungroup()
threedayTest
# 3 days average we can do it for any no. of days as well
mean(1130, 1441, 1530)

# now let's calculate for 7 day and 365 day rolling mean for consumption
mydayTest <- mydata2 %>% 
  dplyr:: arrange(desc(year)) %>% 
  dplyr:: group_by(year) %>% 
  # every 7 days 
  dplyr:: mutate(test_07da = zoo::rollmean(Consumption, k = 7, fill = NA),
                 test_365da = zoo::rollmean(Consumption, k = 365, fill = NA)) %>% 
  dplyr:: ungroup()

# check your result
mydayTest %>% 
  dplyr::arrange(moddate) %>% 
  dplyr::filter(year== 2017) %>% 
  dplyr::select(Consumption,

                 year,
    test_07da:test_365da ) %>% 
  utils::head(7)

 mydayTest$test_07da
 mydayTest$test_365da
par(mfrow=c(1,1))
plot(mydayTest$Consumption,xlab= "year", ylab="Consumption", type = "l",
     lwd = 2, col = "blue",main = "Consumption Graph")
points(mydayTest$test_07da, type= "l", lwd= 2,
       xlim = c(2000,2018),ylim=c(900,2000), col = "orange")
lines(mydayTest$test_365da , type= "l", lwd= 2,
      xlim = c(2000,2018),ylim=c(900,2000), col = "black")
legend(2500,1800, legend = c("mydayTest$Consumption","mydayTest$test_07da",
                             "mydataTest$test_180da"), col = c("blue","orange","black")
       , pch = c("o","*","+"), lty = c(1,2,3), ncol = 1)







