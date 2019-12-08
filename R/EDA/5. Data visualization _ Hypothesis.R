## Data visualization

View(mtcars)
# Step 1:
Freq_Gear = table(mtcars$gear)
Freq_Gear
View(Freq_Gear)

# Step 1:
barplot(Freq_Gear)
barplot(Freq_Gear,main="Numer of gears Frequency",xlab="Gears",ylab="# of cars",ylim=20,
        legend = rownames(Freq_Gear),col=c("grey","red","green"))
?barplot

## starting and ending limit 
barplot(Freq_Gear, ylim = c(0,15))


########  pie chart ########


MeanOfWt = aggregate(wt~carb,mtcars,FUN=mean)
MeanOfWt
MeanOfWt$wt
## Option 1 with lables as carborators
pie(MeanOfWt$wt,labels=MeanOfWt$carb)
## Option 2 with data labels
pie(MeanOfWt$wt,labels=MeanOfWt$wt)

## collborating the categorical variable (carborator) and plotted variable (weight)
class(MeanOfWt)
MeanOfWt1 = transform(MeanOfWt, Cab_Wt = paste(carb,"Carb",wt))
MeanOfWt1
pie(MeanOfWt1$wt,labels=MeanOfWt1$Cab_Wt)


# x and y scatter plot
Hsb = read.csv("hsb.csv")
View(Hsb)
plot(Hsb$math,Hsb$science)
plot(Hsb$math[1:3],Hsb$science[1:3],type="l")
plot(Hsb$math,Hsb$science,type="h")


## Bonnies question how to plot means of all variables togethe
# Step 1: use lapply function to take means of all variables
MeanOfAllVars = lapply(Hsb,mean)

class(MeanOfAllVars)
MeanOfAllVars1 = as.data.frame(MeanOfAllVars)
View(MeanOfAllVars1)
# Step 2 - concatenated different variables in to one object
VectorOfSubjectScores = c(MeanOfAllVars1$math,MeanOfAllVars1$read,MeanOfAllVars1$write)
VectorOfSubjectScores
# step 3: Plotting average values
plot(VectorOfSubjectScores)

# converting list into vector. Prashant's question
MeanOfAllVars5 = as.numeric(MeanOfAllVars)
class(MeanOfAllVars5)
MeanOfAllVars5

## heat maps
class(Hsb)
HsbMatrix = as.matrix(Hsb[1:10,c("read","write")])
HsbMatrix

heatmap(HsbMatrix,Rowv = NA, Colv = NA,scale="column", col = heat.colors(256))
?heatmap







# Parking lot - 
## - Scaling on x axis & data labels with bar plot
b = barplot(Freq_Gear)
text(b,0,Freq_Gear,cex=1,pos=3)


## Hypothesis Example 1. New student to be admitted - score of 78 in read
pnorm(78,mean=52,sd=10)
## 1 -.9953 = 0.005. Thus alternate hypothesis is true and new student does not belong to current
    # distribution





## Lesson 8 & 9. Hypothesis 2nd example. Sample Mean of 52 read score for this sample represents the population 53?
View(Hsb)
### Mean of read is 52. Mean from newspapers and journals that Mean for USA is 53
t.test(Hsb$read,mu=53)

t.test(Hsb$read,mu=54)



