#to find relationshib between 2 continuous variables
mtcars
cor(mtcars$mpg, mtcars$disp)
#also this can be confirmed using scatter plots and line charts

#Anova - analysis of variance

marks = c(82,83, 97,83, 78, 68, 38, 59, 55)
length(marks)
schools = c(rep("A", 3), rep("B", 3), rep("C", 3))
df = data.frame(schools, marks)
df
model = aov(formula = df$marks~df$schools)
summary(model)
#H0: As my school changes from A to B to C, the mean marks don't vary
#HA: As my school changes from A to B to C, the mean marks vary
#Mean(A) != Mean(B)
#or Mean(A)!= Mean(C)
#or Mean(B)!= Mean(C)

#2-sided t-test is used to find out where is the variance high (bw which 2 schools)
a = df$marks[df$schools=="A"]
b = df$marks[df$schools=="B"]
c = df$marks[df$schools=="C"]
a
b
c
t.test(a,b)
#H0 Hypothesis is retained i.e the Mean(A) = Mean(B) 
#or the means of schools A and B are not significantly different

t.test(b,c)
#H0 is rejected, i.e mean(A) is significantly different from mean(B)

t.test(c,a)
#H0 is rejected, mean difference b/w schools A and C is very high


#Multi-variate Analysis using Anova model to find the multi-variate relationship with the continuous var
mtcars 
#How does the mpg variable vary according to the other IV
model = aov(formula = mtcars$mpg~., data = mtcars)
summary(model)
#*** indicates that the prob. value is 0 and .1% - extremely significant var
#** indicates that the prob. value is bw .1% and 1% - var is significant at alpha = 1%
