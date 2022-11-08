# check for NULL/missing data or zeros
any(is.na(totals)) # FALSE
any(is.na(weights)) # TRUE
any(is.na(sleeping)) # FALSE


totals %>% count(TotalSteps == 0) # 138 zeros
totals %>% count(Calories == 0) # 9 zeros


# summaries to check for outliers
totals %>% count(VeryActiveMinutes + 
                   FairlyActiveMinutes + 
                   LightlyActiveMinutes + 
                   SedentaryMinutes > 1440) # There is only 24 hours in a day after all.
totals %>% 
  summarize(TotalSteps, TotalDistance, SedentaryMinutes)%>% 
  summary() # How many steps did people walk and how far?

weights %>% summarise(WeightPounds) %>% range() # The scale is always honest.
weights %>% summarise(Fat) %>% range(na.rm=TRUE) # Suppresses NA values...
weights %>% summarise(BMI) %>% summary() # ...presumably, people don't track or advertise their BMI or bodyfat %.

sleeping %>% summarize(value) %>% summary() # assumed to be sleep stages or intensity

heartrate %>% summarize(Value) %>% summary() # huge range of heart rates


# distincts
n_distinct(totals$Id) # 35 IDs
n_distinct(sleeping$Id) # 25 IDs

