#### load libraries ####
library(tidyverse)
library(here)
library(zoo) #used for calculating moving average 

#### load data ####
pop_count <- read.csv(here("data/OG/GWfG Pop counts.csv"))
pop_count_long <- pivot_longer(data = pop_count, 
                          cols = c("Population.estimate", "Wexford", "Islay"), 
                          names_to = "site", values_to = "count") %>% 
  select(-c("Missing.data", "X"))
saveRDS(pop_count_long, here("data/outputs/pop_count.RDS"))

young_count <- read.csv(here("data/OG/GWfG Islay Wexford young counts long format.csv"))
saveRDS(young_count, here("data/outputs/young_count.RDS"))

#### calculate max of metapop ####
max_mp <- pop_count$spring[which.max(pop_count$Population.estimate)]

saveRDS(max_mp, here("data/outputs/max_metpop.RDS"))

#### 3yr running average ####
young_count <- young_count %>%
  group_by(Ringing.location) %>%
  mutate(roll_mean = rollmean(Perc_young, k = 3, align = "center", fill = NA))

saveRDS(young_count, here("data/outputs/young_count_proc.RDS"))


