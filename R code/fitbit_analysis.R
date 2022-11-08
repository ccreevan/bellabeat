# oft-used variables
power_minutes <- 
  totals$VeryActiveMinutes + 
  totals$FairlyActiveMinutes + 
  totals$LightlyActiveMinutes + 
  totals$SedentaryMinutes
td <- theme_dark(base_size=20)
tg <- theme_gray(base_size=20)

# how often the Fitbit was powered on all day
totals %>% 
  count(power_minutes == 1440)


# summaries
# overviews
totals %>% 
  select(TotalSteps, TotalDistance, SedentaryMinutes) %>% 
  summary()

# sleep patterns
bed %>% 
  select(TotalMinutesAsleep, TotalTimeInBed) %>% 
  summary()

total_bed <- merge(totals, bed, by="Id") # notes use during sleep discards IDs not present in both
n_distinct(total_bed$Id)


# plots
# steps 
steps <- totals %>% 
  ggplot(mapping=aes(x=ActivityDate, y=TotalSteps)) +
  td

steps + 
  geom_point(alpha=.5, 
             color="white",
             show.legend=FALSE) +
  labs(title = "Daily Steps", 
       x="Date", 
       y="Steps Taken")

# battery times
power <- totals %>% ggplot() + theme_test()

power + 
  geom_histogram(mapping=aes(x=power_minutes/60),
                 binwidth=2,
                 color="white",
                 fill="green"
                 ) + 
  labs(title="Daily Fitbit Power", 
       subtitle="How often and how long between charges?",
       x="Hours",
       y="# of Charges"
       ) +
  tg

# usage patterns
patterns <- totals %>% 
  ggplot(mapping=aes(x=ActivityDate,y=power_minutes/60, group=ActivityDate)
         ) + 
  td

patterns +
  geom_line(color="white",
            size=2,
            lineend="round"
            ) +
  labs(title="Fitbit Usage Range",
       x="Date",
       y="Daily Hours Used"
       ) # not being used

          
# sleep patterns
sleep_pattern <- sleeping %>% ggplot(mapping=aes(x=date,
                                                 y=as.character(Id))) +
  theme_classic(base_size=20) +
  theme(axis.text.y=element_blank())

sleep_pattern + geom_bin2d() +
  scale_fill_gradient(low="darkblue",
                   high="orange",
                   guide="legend") +
  labs(title="Sleep Quality",
       subtitle="(or lack of)",
       x="Date",
       y="Participants",
       fill = "Minutes",
       )


# heart rate patterns
heart_pattern <- heartrate %>% 
  ggplot(mapping=aes(x=Time,
                     y=Value)) +
  td

heart_pattern + geom_bin2d(show.legend=FALSE) +
  scale_fill_gradient(low="darkblue",high="orange") +
  labs(title="Heart Rate",
       subtitle="How fast was everyones heart beating?",
       x="Date",
       y="Heart Rates")
