#Class 5---------------------------------------------------------------
#dplyr -------------------------------------------
library(dplyr)
library("tidyverse")
as_tibble(iris)->ir
head(ir)
ir
ir = iris

glimpse(iris)

View(airquality)
?airquality
aq = as_tibble(airquality)
head(aq)
#select fn - to select the columns which specify some criteria - especially useful when 1000s of columns
select(.data = aq,contains("zon"), ends_with(".R"), starts_with("Wi"),Temp: Day)->var
var
?select
#how to rearrange the cols
select(.data = aq, Temp:Day, Wind, Ozone:Solar.R)
# Move Species variable to the front
select(iris, Species, everything())

select(.data = aq, -c(contains("on"), Temp))

select_if(aq,is.numeric)
select_if(iris, is.numeric)->num_iris

#AND condition: Select all columns that end with "t" and start with "dr"
select(mtcars, ends_with("t"))->p
p
select(p, starts_with("dr"))

#mutate fn - to add a new col---------------------------------------------
head(aq)
?airquality

aq$Date = paste(aq$Day, aq$Month, "1973",sep = "-")
head(aq)
class(aq$Date)

as.Date(aq$Date,format = "%d-%m-%Y")->aq$Date #format represents the format of the current character format date
head(aq)
class(aq$Date)

#%d - Date of month
#%m - numerical month - eg. 3
#%b - month (abbreviated)
#%B - month (full name)
#%y - year (2 digits)
#%Y - year (4 digits)
#%A - day of the week

a = c("May-8, 1897", "July-14, 1993")
as.Date(x = a,format = "%B-%d, %Y")->a
a
a+45

head(aq)
aq$Date = NULL
head(aq)
dt = paste(aq$Day, aq$Month, "1973", sep = "/")
dt
dt = as.Date(dt, format = "%d/%m/%Y")
dt
class(dt)
aq = mutate(.data = aq,Date = dt)
head(aq)
aq = mutate(.data = aq, Date = as.Date(paste(aq$Day, aq$Month, "1973", sep = "/"), format = "%d/%m/%Y"))

#filter ----------------------------------------------------------------
library(hflights)
hf = hflights
View(hf)
?hflights

#all the flights which have flown for > 3900 miles
hf[hf$Distance>3900,]->p
head(p)

library(dplyr)
filter(.data = hf, Distance>3900)

#suppose looking for unique destinations where the flights have flown for >3900 miles
unique(p$Dest)

library(dplyr)
distinct(select(filter(.data = hf, Distance>3900), Dest))

#using piping operator we can combine the functions of dplyr library
hf%>%filter(Distance>3900)%>%select(Dest)%>%distinct()

#arrange function----------------------------------------------------------
#to arrange my data into increasing or decreasing order
arrange(.data = hf, desc(hf$ArrDelay, hf$DepDelay))->p
View(p)

#group_by function----------------------------------------------------------------
group_by(.data = aq,Month)
summarise(group_by(.data = hf,DayOfWeek), n())

#How do we find out the max distance travelled on each week day
hf%>%group_by(DayOfWeek)%>%
  arrange(desc(Distance))%>%
  summarise(NumOfFlights = n(), AveDistTravelled=mean(Distance), MaxDistOnEachWeekDay = max(Distance))


#summarise function --------------------------------------------
#max, min, mean, median, summary, length, first, last, nth, n()
summarise(.data = aq, Max.Ozone = max(aq$Ozone, na.rm = T), 
          Min.Wind = min(aq$Wind, na.rm = T), Fifth_Value_Temp = nth(aq$Temp, 5))

airquality
aq
head(aq)
aq$Date = NULL
aq%>%
  mutate(Date=as.Date(paste(aq$Day, aq$Month, "1973"), format = "%d %m %Y"))%>%
  arrange(Ozone)%>%
  select(Ozone:Temp, Date)->df

df  
class(df)


?substr
a = c("How are you", "Who are you")
substr(x = a,start = 5, stop = 7)

#--------------------------------------------------------------------------------------------------
#DATA VISUALISATION
#Univariate visualization of factor vars: Bar plots and Pie Chart
View(mtcars)
mtcars$vs
table(mtcars$vs)
rownames(table(mtcars$vs))
barplot(height = table(mtcars$vs), col = rainbow(2), ylim = c(0,21), 
          xlab = "vs", ylab = "Frequency", main = "Frequency Table for variable: vs")
legend(2, 21, legend = rownames(table(mtcars$vs)), fill = rainbow(2), col = rainbow(2))

#Pie chart
as.data.frame(table(mtcars$vs))->df
names(df)[1] = "Labels"
df
pie(x = df$Freq, labels = df$Labels, col = c('red', 'blue'), main = "vs")

df
#install.packages("plotrix")
library(plotrix)
pie3D(x = df$Freq, labels = df$Labels, col = rainbow(2), explode = .2, labelcex = .9)

#-----------------------------------------------------------------------------
#Univariate visualizations for continuous vars
#Histograms, density curve and boxplots
mtcars$mpg
hist(x = mtcars$mpg, col= rainbow(5), labels = T, ylim = c(0, 14),breaks = 10 )

#density curve
plot(density(mtcars$mpg), col = "red", main = "Density Chart")

#boxplots
boxplot(mtcars$hp,horizontal = T, col="yellow")->p
p$stats #gives the min, Q1, Q2, Q3, max value
p$out

#----------------------------------------------------------------------------------
#Bi-variate visualizations between 2 continuous vars - scatter plot
plot(x = mtcars$hp, y = mtcars$mpg)

##Bi-variate visualizations between 2 factor vars
mtcars$vs
mtcars$gear
table(vs = mtcars$vs, gear = mtcars$gear) -> freq_table

barplot(height = freq_table,col = rainbow(2), legend = rownames(freq_table), xlab = "gears")

#beside bar plot
barplot(height = freq_table,col = rainbow(2), legend = rownames(freq_table), xlab = "gears", beside = T)

#Bivariate between 1 factor var + 1 continuous var: boxplot, bar plot, pie chart
plot(x = iris$Species, y = iris$Petal.Length)->o
o$stats
o$out

#barplot
#Find the mean petal length  species-wise
aggregate(x = iris[,1:4], by = list(iris$Species), mean)->p
p
class(p)

aggregate(x = iris$Petal.Length, by = list(iris$Species), mean)->p
p
class(p)
names(p) = c("Species", "MeanPetalLength")
p

barplot(height = p$MeanPetalLength, col = rainbow(3))
pie3D(x = p$MeanPetalLength, labels = p$Species, explode = .1, labelcex = .9)
