rm(list = ls())

setwd("C:/Users/User02/Google Drive/Business Analytics/Business Analytics Video/Moodle Upload/8. Time Series/Case study/Final Case - HoltWinters/")

stock <- read.csv("stock_pred.csv")

View(stock)

#MAPE Function
mape = function(act, pred){
  res = mean(abs((act-pred)/act))
  return(res)
}

#Convert data to a time series object

stock_ts <- ts(stock[,1],start=2008,freq=12)

head(stock_ts)
tail(stock_ts)
#Plot time series
plot(stock_ts)

#Divides into Seasonal, Trend and Remainder. S.Window controls how rapidly the seasonal component can change
#STL means Seasonal Trend Decomposition using Loess

stock_1 <- stl(stock_ts,s.window="periodic")

stock_1

#Plot sales time series into three components - seasonal, trend and remainder
plot(stock_1)
#Looking at the plot it looks we have all the 3 components i.e. Level, Trend & Seasonality so we would consider triple exponential smoothing i.e. set all 3 parameters alpha, beta, gamma to TRUE (default)

stock_hws <- HoltWinters(stock_ts)

stock_hws
#From the parameter values it indicates that there is no trend in the data as the coef is 0 for beta

plot(stock_hws)

#Pred and act

pred = as.numeric(stock_hws$fitted[,1])

act = as.numeric(stock_ts[(1:96)])

#Calculating the in-sample error

mape(act, pred)

#The error is around 9.83% which is pretty good

#Now lets forecast for the next 12 months
pred = predict(stock_hws, n.ahead = 12, prediction.interval = TRUE, level = 0.95)

pred

#Plotting forecasted values
plot(stock_hws, pred)

#Check for the assumption
err = act-as.numeric(pred[,1])

err

#Errors should follow normal distribution

par(mfrow=c(1,2))

hist(err)

qqnorm(err)
#The errors seem to follow normal distribution

#Check for autocorrelation of errors using acf plot
par(mfrow=c(1,1))

acf(err,lag.max=30)

#There seem to be some spikes going out of the thresholds. Lets do a Ljung-Box test if these spikes are statistically significant

# H0: independence in a given time series

Box.test(err, lag = 30, type ="Ljung-Box")

#Since p-value > 0.05 we reject our null hypothesis which means there is autocorrelation in errors  

