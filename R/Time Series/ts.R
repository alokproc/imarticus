setwd("~/Documents/7 Imarticus/12 Post Graduate Diploma Data Analytics/1. PGA  - R module Material/12: Day12 : Time Series + Case Study for Time Series/2. Case Study/Example4")

# Simple example of a time series object

sales <- c(18, 33, 41, 7, 34, 35, 24, 25, 24, 21, 25, 20,
           22, 31, 40, 29, 25, 21, 22, 54, 31, 25, 26, 35)

t_sales <- ts(sales, start=c(2003, 1), frequency=12)
t_sales

plot(t_sales)

# We can use functions to determine various properties
# of the tiem series
start(t_sales)
end(t_sales)
frequency(t_sales)

# First step of time series analysis
# is to describe it numerically and visually

# We'll use the Nile time series that
# recorded annual flow of the Nile
# between 1871 - 1970

# Plot the data first
# and smooth it to remove significant error components
# through centered moving average

#install.packages("forecast")
library(forecast)
opar <- par(no.readonly=TRUE)
par(mfrow=c(2,2))
ylim <- c(min(Nile), max(Nile))
plot(Nile, main="Raw time series")
# ma() function used to smooth the Nile time series
plot(ma(Nile, 3), main="Simple Moving Averages (k=3)", ylim=ylim)
plot(ma(Nile, 7), main="Simple Moving Averages (k=7)", ylim=ylim)
plot(ma(Nile, 15), main="Simple Moving Averages (k=15)", ylim=ylim)
par(opar)
# As k increases, plot becomes increasingly smooth

# Plotting the ACF chart - measure of how the observations
# in a time series relate to each other
# if the autocorrelation crosses the dashed blue line, it means
# specific lag is significantly correlated with current series
# A stationary time series will have autocorrelation fall quickly
# to 0, with non-stationary series it drops gradually

# Acf() plot
acf_result <- Acf(Nile) # autocorrelation
acf_result

# partial autocorrelation plot
pacf_result <- Pacf(Nile)

# Test if a time series is stationary
library(tseries)
# p-value < 0.05 indicates the TS is stationary
# In this eample, Nile data is not stationary
adf.test(Nile)

# Example of ARIMA model ------------------------------------------
# ARIMA and Nile forecasting example
# First you plot the time series and assess its stationarity
library(forecast)
library(tseries)
plot(Nile)
# Chart data appears stationary
# Could contain a trend
# So we assess presence of a trend in dataset
ndiffs(Nile)

# Since there is a trend, the series is differenced 
# once (lag=1 is the default) and saved as dNile
# Note we had to difference the data by 1
diff_nile <- diff(Nile, lag = 1)

# Plot the differenced time series
plot(diff_nile)

# Show both side-by-side f comparison
opar <- par(no.readonly=TRUE)
par(mfrow=c(1,2))
plot(Nile)
plot(diff_nile)
par(opar)

# And we'll assess the presence of a trend in the data
ndiffs(diff_nile)

# Applying the ADF test to the differenced series 
# suggest that it’s now stationary, so we can 
# proceed to the next step
# Null hypothesis of ADF test = data needs to 
# be differenced to make t stationary
adf.test(diff_nile)

# Identifying one or more reasonable models
# here we examine autocorrelation and partial
# autocorrelation plots for the differenced
# Nile time series
# autocorrelatioin plot
Acf(diff_nile, main = "Autocorrelation plot for differeced Nile time series")
# partial autocorrelation plot
Pacf(diff_nile, main = "Partial autocorrelation plot for differeced Nile time series")

# Fitting an ARIMA model -------------------------------------
# Note we use the original dataset for the ARIMA model
# and modify the d value to suit our earlier findings
# and d = 1
# We apply the model to the original time series
# and not diff_nile
library(forecast)
arima_model <- Arima(Nile, order = c(0, 1, 1))
arima_model
# Accuracy measures
# The mean absolute percentage error (MAPE)
# measures prediction of accuracy
# Here the MAPE is 13% of the river level
# so this is the forecast accuracy of the error

accuracy(arima_model)

# Evaluating model fit ---------------------------------------
# qqnorm produces a normal QQ plot of the values in y. 
# qqline adds a line to a “theoretical”, quantile-quantile plot 
# which passes through the probs quantiles, 
# by default the first and third quartiles
help("qqnorm")
qqnorm(arima_model$residuals)
qqline(arima_model$residuals)
# Box.test() function provides a test that autocorrelations 
# are all zero (H0). The results are significant, suggesting 
# the autocorrelations don ’t differ from zero.
# This ARIMA model appears to fit the data well.
Box.test(arima_model$residuals, type = "Ljung-Box")

# Forecast 3 years ahead for Nile time series
forecast(arima_model, 3)
# Plot function shows the forecast. Point estimates are
# given by the blue dots, 80 % and 95 % confidence bands 
# are represented by dark and light bands, respectively
plot(forecast(arima_model, 3), xlab = "Year", ylab = "Annual Flow")

# Automated ARIMA forecasting -------------------------------
# Comparing the automatic test against our manual method above
library(forecast)
auto_arima_model <- auto.arima(Nile)
auto_arima_model

accuracy(auto_arima_model)
# Compare with manual selected model
accuracy((arima_model))
qqnorm(auto_arima_model$residuals)
qqline(auto_arima_model$residuals)
Box.test(auto_arima_model$residuals, type = "Ljung-Box")

forecast(auto_arima_model)
plot(forecast(auto_arima_model, 3), xlab = "Year", ylab = "Annual Flow")

