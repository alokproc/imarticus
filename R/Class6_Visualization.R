library(ggplot2) #grammar of graphics
#geom_bar - barplot
#geom_point - scatter plot
#geom_histogram - histogram
#geom_density - density charts
#geom_boxplot - boxplot

#barplot
View(mtcars)
aggregate(x = mtcars$mpg, list(mtcars$gear), mean)->df
names(df) = c("Gear", "Average_Milage")
df
ggplot(data = df, aes(x = Gear, y = Average_Milage))->p #aes: aesthetics parameters
p + geom_bar(stat = "identity") 
#stat = identity - will inform that we are looking for an bi-variate barplot rather than uni-variate
#if I don't specify clearly stat = identity then it will understand that we are looking for a default bar-plot
#i.e for frequency representation

ggplot(data = mtcars, aes(x = mtcars$gear))->p #aes: aesthetics parameters
p + geom_bar()#here default of stat has not been changed hence it gives the freq. distribution

df$Gear = as.factor(df$Gear) #other-wise it will be show as continuous var
ggplot(data = df, aes(x = Gear, y = Average_Milage))->p #aes: aesthetics parameters
p + geom_bar(aes(fill = df$Gear), stat = "identity") 
#if if want to fill to fill it with some variable in the data then only we'll put in the fill in the aes parameter of geom_
#if a static color is required then you specify the col in ggplot itself

ggplot(data = df, aes(x = Gear, y = Average_Milage, fill = "red"))->p #aes: aesthetics parameters
p + geom_bar(stat = "identity") 

ggplot(data = df, aes(x = Gear, y = Average_Milage))->p #aes: aesthetics parameters
p + geom_bar(aes(fill = df$Gear), stat = "identity") + theme_minimal() + 
  xlab("Number of Gears") + 
  ggtitle("Milage based on number of gears")+
  scale_y_continuous(name = "Average Milage", breaks = seq(0, 27.5, 2.5), limits = c(0,27.5))


