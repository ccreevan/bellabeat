# load libraries
library(tidyverse)
library(lubridate)

# set directory
setwd("~/R/Case Studies/Bellabeat")


# load data
# overall
mar <- read_csv("~/R/Case Studies/Bellabeat/Fitabase Data 3.12.16-4.11.16/dailyActivity_merged.csv")
apr <- read_csv("~/R/Case Studies/Bellabeat/Fitabase Data 4.12.16-5.12.16/dailyActivity_merged.csv")
# weights
weight1 <- read_csv("~/R/Case Studies/Bellabeat/Fitabase Data 3.12.16-4.11.16/weightLogInfo_merged.csv")
weight2 <- read_csv("~/R/Case Studies/Bellabeat/Fitabase Data 4.12.16-5.12.16/weightLogInfo_merged.csv")
# sleep
sleep1 <- read_csv("~/R/Case Studies/Bellabeat/Fitabase Data 3.12.16-4.11.16/minuteSleep_merged.csv")
sleep2 <- read_csv("~/R/Case Studies/Bellabeat/Fitabase Data 4.12.16-5.12.16/minuteSleep_merged.csv")
# time in bed
bed <- read_csv("~/R/Case Studies/Bellabeat/Fitabase Data 4.12.16-5.12.16/sleepDay_merged.csv")
# heartrate
heart1 <- read_csv("~/R/Case Studies/Bellabeat/Fitabase Data 3.12.16-4.11.16/heartrate_seconds_merged.csv")
heart2 <- read_csv("~/R/Case Studies/Bellabeat/Fitabase Data 4.12.16-5.12.16/heartrate_seconds_merged.csv")


# merge data frames, change date from string to date type, validates dates, and sorts by user ID and date
totals <- list(mar, apr) %>% 
  reduce(full_join) %>%  
  arrange(Id,ActivityDate) %>% 
  mutate(ActivityDate = mdy(ActivityDate))

weights <- list(weight1, weight2) %>% 
  reduce(full_join) %>% 
  select(Id,Date,WeightPounds,Fat,BMI) %>% 
  arrange(Id,Date) %>% 
  mutate(Date = mdy_hms(Date))

sleeping <- list(sleep1, sleep2) %>% 
  reduce(full_join) %>% 
  select(Id,date,value) %>% 
  arrange(Id,date) %>% 
  mutate(date = mdy_hms(date))

bed %>% 
  mutate(SleepDay = mdy_hms(SleepDay))

heartrate <- list(heart1, heart2) %>% 
  reduce(full_join) %>% 
  select(Time,Id,Value) %>% 
  arrange(Id,Time) %>% 
  mutate(Time = mdy_hms(Time))
