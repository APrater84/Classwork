library(fpp3)
library(lubridate)
library(tidyverse)
library(stringr)
library(dplyr)
library(ngram)
library(tidyr)
library(tsibble)


#read in table
SunspotData <- read.table("C:/Users/(user name)/Desktop/VCU School Work - Graduate/VCU DAPT Course info/Module3/DAPT 632 - Forecasting/Homework Assignments/monthly-sunspots.csv",sep=",",header=TRUE)

#view table
view(SunspotData)

SunSpotDF <- SunspotData %>%
  mutate(Month = yearmonth(Month)) %>%
  select(Month, Sunspots) %>%
  as_tsibble(index = Month)


SunSpotDF %>%
  filter(year(Month) > 1970) %>%
  mutate(Sunspots = Sunspots/1)
  autoplot(SunSpotDF) +
  labs(title="Number of observed sunspots",
       y="Number of sunspots")
  
#Seasonal differencing

  SunSpotDF %>%
    gg_tsdisplay(difference(Sunspots, 12),
                 plot_type='partial', lag=36) +
    labs(title="Seasonally differenced", y="")
  
#Double Differenced
  SunSpotDF %>%
    gg_tsdisplay(difference(Sunspots, 12) %>% difference(),
                 plot_type='partial', lag=36) +
    labs(title = "Double differenced", y="")
  
  SunSpotDF %>%
    features(difference(Sunspots, 12) %>% difference(),unitroot_kpss)
  
  #Fit Model
  fit <- SunSpotDF %>%
    model(
      auto = ARIMA(Sunspots, stepwise = FALSE, approx = FALSE)
    )
  report(fit)
  gg_tsresiduals(fit)
  augment(fit) %>% features(.innov, ljung_box, lag=24, dof=5)
  
  #Fit Model 1
  fit1 <- SunSpotDF %>%
    model(
      arima210011 = ARIMA(Sunspots ~ pdq(2,1,0) + PDQ(0,1,1)),
    )
  report(fit1)
  gg_tsresiduals(fit1)
  augment(fit1) %>% features(.innov, ljung_box, lag=24, dof=4)
  
  #Fit Model 2
  fit2<- SunSpotDF %>%
    model(
      arima012011 = ARIMA(Sunspots ~ pdq(0,1,2) + PDQ(0,1,1)),
    )
  report(fit2)
  gg_tsresiduals(fit2)
  augment(fit2) %>% features(.innov, ljung_box, lag=24, dof=4)
  
  
  #Train model
  train <-  SunSpotDF %>%
    filter(year(Month) < 1970)
  view(train)
  
  fit3 <- train %>%
    model(
      arima012011 = ARIMA(Sunspots ~ pdq(0,1,2) + PDQ(0,1,1)),
      arima210011 = ARIMA(Sunspots ~ pdq(2,1,0) + PDQ(0,1,1)),
      auto210111 = ARIMA(Sunspots ~ pdq(2,1,0) + PDQ(1,1,1))
    )
  
  fc <- fit3 %>%
    forecast(h="9 months")
  fc %>%
    accuracy(SunSpotDF) %>%
    select(.model, .type, RMSE)
  
  forecast(fit3, h=36) %>%
    filter(.model=='auto210111') %>%
    autoplot(SunSpotDF) +
    labs(title = "Forecasted Sunspots",
         y="Number of Sunspots")
  
  # Let's compare the Seasonal ARIMA and ETS models
  
  
  SunSpotDF %>%
    slice(-n()) %>%
    stretch_tsibble(.init = 10) %>%
    model(
      ets = ETS(Sunspots),
      arima = ARIMA(Sunspots ~ pdq(2,1,0) + PDQ(1,1,1))
    ) %>%
    forecast(h = 1) %>%
    accuracy(SunSpotDF)
