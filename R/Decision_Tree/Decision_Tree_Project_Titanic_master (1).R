Data18 <- read.csv("C:/Users/Faiq/Downloads/R_DSP/Project3/20191229/titanic_data.csv")

#to view first 6 records
head(Data18)
#to view last 6 records
tail(Data18)
#to shuffle data
shuffle_index=sample(1:nrow(Data18))
head(shuffle_index)
#to shuffle titanic dataset
Data18=Data18[shuffle_index, ]
head(Data18)
library(dplyr)
#drop variables
clean_Data18=Data18%>%
  select(-c(home.dest,cabin,name,x,ticket))%>%
  #convert to factor level
  mutate(pclass=factor(pclass,levels = c(1,2,3),labels = c('Upper','Middle','Lower')),
         survived=factor(survived,levels = c(0,1),labels = c("no","yes")))%>%
  na.omit()
summary(clean_Data18)
head(clean_Data18)
glimpse(clean_Data18)
str(clean_Data18)
dim(clean_Data18)
clean_Data18$age=as.numeric(clean_Data18$age)
clean_Data18$age=ifelse(clean_Data18$age=='?',33,clean_Data18$age)


idx=clean_Data18$embarked=="?"
is.na(clean_Data18$embarked)=idx
clean_Data18 <- na.omit(clean_Data18)
colSums(is.na(clean_Data18))
median(clean_Data18$age)
View(clean_Data18)

set.seed(1234)

create_train_test <-  function(clean_Data18, size = 0.8,train = TRUE)
{
  n_row = nrow(clean_Data18)
  total_nrow = size * n_row
  train_sample <- 1:total_nrow
  
  if(train == TRUE)
  {
    return(clean_Data18[train_sample, ])
    
  }  
  else
  {
    return(clean_Data18[-train_sample, ])
  } 
}

data_train <- create_train_test(clean_Data18, 0.8, train = T)

data_test <- create_train_test(clean_Data18, 0.8, train = F)

dim(data_train)
dim(data_test)

dim(clean_Data18)
