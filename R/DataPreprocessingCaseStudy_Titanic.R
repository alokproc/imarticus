train<-read.csv(file.choose(),header=T)
test<-read.csv(file.choose(),header=T)
names (train)
names(test)
nrow(train)
ncol(train)


View(train)

sum(is.na(train$Age))
sum(is.na(train$Fare))
sum(is.na(train$Embarked))

#### Apply Functions

m <- matrix(c(1,2,3,4),2,2)
w<-apply(m,2,sum)


lst <- list(a =c(1,1),b=c(2,2), c=c(3,3,4,4))
lst
lapply(lst,range)
sapply(lst,range)

#### Data Cleaning and feature engineering

class(train$Name)

train$Name <- as.character(train$Name)

sapply(train$Name,strsplit,split = '[,.]')

f<- function(x){ strsplit(x,split= '[,.]')[[1]][2]}

train$Title<-sapply(train$Name,f)
head(train$Title)

train$Title<-sub(' ',"",train$Title)
train$Title[1]

table(train$Title,train$Sex)


### Mr. Miss Mrs. Master

# convert them to limited categories

train$Title[train$Title %in% c('Lady', 'the Countess', 'Mlle')] <- 'Miss'

train$Title[train$Title %in% c('Capt', 'Don', 'Major', 'Sir', 'Col', 'Jonkheer', 'Rev', 'Dr') & train$Sex == "male" ] <- 'Mr'

train$Title[train$Title %in% c('Dona','Lady',"Dr","Mme", 'Ms') & train$Sex == "female"] <- 'Mrs'

table(train$Title)

### Missing Value imputation
sum(is.na(train$Age))
tapply(train$Age,train$Title,mean,na.rm=T)
tapply(train$Age,train$Sex,mean,na.rm=T)
train$Age [train$Title == "Master" & is.na(train$Age) == TRUE] <- 5
train$Age [train$Title == "Miss" & is.na(train$Age) == TRUE] <- 22
train$Age [train$Title == "Mr" & is.na(train$Age) == TRUE] <- 33
train$Age [train$Title == "Mrs" & is.na(train$Age) == TRUE] <- 36

sum(is.na(train$Age))


### Demo dplyr Package
install.packages("dplyr")
library(dplyr)
library(datasets)
data()

data<- select(train, Title, Age,Fare)
View(data)
data1 <- filter (train, Title == "Master"  )
View(data1)

data2 <- arrange(data, desc(Fare))
data2

summarise(group_by(train,Sex),mean(Age,na.rm=T))

### Data Visualization


count <- table(train$Sex)

barplot(count,horiz = T)
table(train$Pclass,train$Sex)
barplot(table(train$Pclass,train$Sex),main = "Pclass And Gender",legend.text = rownames(table(train$Pclass,train$Sex)),col = c("red","green","blue"))

pie(table(train$Sex),labels = rownames(table(train$Sex)))


hist(train$Age)
hist(train$Age,breaks = 200,freq = FALSE)
lines(density(train$Age,na.rm = T),col = "red")

polygon(density(train$Age,na.rm = T), col= "red")


plot(density(train$Age))

boxplot(train$Age,horizontal=T,range=0)
abline(v=c(mean(train$Age,na.rm=T),
           median(train$Age,na.rm = T),quantile(train$Age,c(.75,.25),na.rm = T),
           outlier=quantile(train$Age,0.25,na.rm=T)-1.5*IQR(train$Age,na.rm=T),outlier2 = quantile(train$Age,0.75,na.rm=T)+1.5*IQR(train$Age,na.rm=T)),
       col=c("red","royal blue","green","orange","yellow","yellow"),
       lwd=2
)




