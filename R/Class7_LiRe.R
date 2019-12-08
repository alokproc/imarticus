#Linear Regression
#Regression problem means: y (DV) is a continuous var 

library(MASS)
head(Boston)
?Boston

summary(Boston)

#Uni-dimensional analysis - with the help of visualizations
#take log values if the distribution is extremely right skewed (median < mean)
str(Boston)
table(Boston$chas)
Boston$chas = as.factor(Boston$chas)

# outliars detection and deletion / imputation
Boston$crim
x = boxplot(Boston$crim)
x$out

a = c(1,2,3,1,5,3,2) 
ou = c(1,2)
ou %in% a
a %in% ou #this will give T / F corresponding to a 
#i.e for each component of a, it will check, if it is there in ou or not
which(a %in% ou)

Boston$crim[Boston$crim %in% x$out] = mean(Boston$crim, na.rm = T)
x = boxplot(Boston$crim)
#this indicates that imputing outliars will not help here, because the entire distribution is right skewed
#if we take the log of the entire distribution then the skewness will reduce a lot

Boston$log_crim = log(x = Boston$crim)
x = boxplot(Boston$log_crim)
Boston$crim = NULL
View(Boston)

#exponential is for extremely left skewed distributions
# for little skewness / medium skewness  x^2 or x^3 will do the job

colSums(is.na(Boston))

#Suppose missing values in indus col
Boston$indus[is.na(Boston$indus)] = mean(Boston$indus, na.rm = T)

#checking the correlations
library(corrplot)
cor(Boston) #can be calculated only for continuous columns
corrplot(cor(Boston))
#Creating of training and test data-set
#training data-set will be used to train the model 
#test data-set will be used to validate the model

col = colorRampPalette(c("blue", "white", "red"))(20)
heatmap(cor(Boston), symm = T, col = col)

#looking at correlations:
#-correlation bw the DV and each of the IVs. 
#   If the correlation is weak, then the IV is not contributing to the variance in DV
#-we don't want inter-correlations (-ve or +ve) bw the IVs as it leads to 
#    mult-collinearity (i.e redundancy of information conveyed) 

#Splitting the data into train and test data
library(caTools)
split = sample.split(Y = Boston$medv,SplitRatio = .7)
split
train_Df = Boston[split,]
test_Df = Boston[!split,]
dim(train_Df)
dim(test_Df)

#Create the linear regression model
lm(formula = medv~., data = train_Df)->model
summary(model)
?sum
#baseline model is y = ymean - this is the worst model
#OLS - ordinary least squares is the algorithm used in the lm fun. It attempts to minimize our sse (sum of square errors) or rss (residual sum of squares)

#R2 value increases on adding any var to our model eqn 
#But adjusted R2 value will increase only on adding significant variables to our data

step(object = model,direction = "both")->mod
#direction can be forward or backward or both
# forward means - it will add the variables and check if the adj R2 value 
#   increases, if yes, the var will be added else the var will not be 
#   added to our model equation
# backward means - it will start with all the variables and then will try 
#   removing the variable from the model, if the adj R2 decreases then the var will be retained as a part of the model, else it will be removed from the model eqn
summary(mod)

#residuals distribution should be approx normal (symmetrical)
#there should be no multi-collinearity in our model
# signs of coefficients should be intutive 
#only significant variables should be included in our model

#let's check the multi-collinearity

library(car)
vif(mod) #variance inflation factor

corrplot(cor(train_Df))

lm(medv~zn + chas + nox + rm +dis+tax+ptratio+black+lstat , data = train_Df)->mod1
summary(mod1)

#model performance is checked based on R2 (Rsquared) = 1 - RSS/TSS 
#   where RSS is residual sum of squares / unexplained variation  (error)
#   TSS = Total sum of sq. i.e distance between yactual and y mean = explained variation + unexplained variation


lm(medv~zn + chas + nox + rm +dis+ptratio+black+lstat , data = train_Df)->mod2
summary(mod2)
vif(mod2)

#predictions on test data
predict(object = mod2,newdata = test_Df)->p
p

test_Df$residual=p - test_Df$medv
sse = sum(test_Df$residual^2)
View(test_Df)
sst = sum((test_Df$medv-mean(train_Df$medv))^2)
sst
Rsq = 1-sse/sst # 1- unexplained variation / (explained var + unexplained var)
Rsq

#try your hands on mtcars data for the li re problem with mpg as the y var

a = c("May-8, 1897", "July-14, 1993")
as.Date(x = a,format = "%B-%d, %Y")->a
a
class(a)
a
class(Sys.Date())
