## initial packages/setup, will be updated over time ##

library(tidyverse)
rundata <- read.csv("run_ww_2019_d.csv")

## Cleaning this behemoth of a dataset 
## Eliminated days where distance = 0. Might revisit those values later, 
## look at runner training plans or something, but am uninterested right now
## kind of interested in looking by country, so is sorted by

rundataclean <- rundata %>%
  filter(distance != 0,
         country != "") %>%
  group_by(athlete) %>%
  select(datetime, athlete, distance, duration, 
         gender, age_group, country, major) %>%
  arrange(country)

## Most of these runs are likely training. I'd like to know how race results 
## vary by country. I wil use the Tokyo marathon on March 3rd 2019 as an example
##
## not all runners on this day will have been Tokyo 2019 marathon runners
## Therefore I must extrapolate that those who have ran the approximate distance
## of a marathon on that day ran that marathon. 
## Some of the results do not show "TOKYO 2019" in the majors section. I know from 
## experience that many marathons occur on the same dates 
## (i mean there are only 52 weeks in a year what was I thinking)
## 
## I might come back and write some code that goes through the boxes to 
## elimanate the non-Tokyo 2019 results. That being said, since the distance 
## is that of a full marathon, I think using these results as-is works 
## well enough (marathon runners generally stop their training 3-4 miles short 
## unless I have been mislead)

## Also I do not know how the data was sourced, and I would expect most of 
## the distance initially found. Without putting a maximum value, we see a 
## few runners who ran well beyond the distance of a marathon. More reason to 
## later ensure that only Tokyo 2019 runners are included. I'm going to assume 
## that anyone who ran above 45 km (~ 1.7 mi over marathon) are training for a 
## ultra and/or are insane for now

tok19 <- rundataclean %>%
  mutate(datetime = as.character(datetime)) %>%
  filter(datetime == "2019-03-03",
         distance >= 42,
         distance <= 45) %>%
  mutate(pace = duration/distance) %>%
  arrange(pace)

