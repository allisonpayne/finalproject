library(tidyverse)

pop_counts <- readRDS(here::here("data/outputs/pop_count.RDS"))
young_count <- readRDS(here::here("data/outputs/young_count_proc.RDS"))
max_mp <- readRDS(here::here("data/outputs/max_metpop.RDS"))

#goose_plots <- function(data, year, response, location, max_mp, rollmeans) {
  ggplot(data = data, aes(x = year, y = response) +
           geom_line(aes(x = year, y = rollmeans)) +
           geom_line(aes(color = location), alpha = 0.5) +
           scale_color_manual(values = c("aquamarine4", 
                                         "dodgerblue3",
                                         "darkorange3")) +
           geom_vline(aes(xintercept = max_mp), linetype = "dashed")) 

}

#goose_plots(young_count, young_count$data_year, young_count$Perc_young, 
            young_count$Ringing.location, max_mp = max_metpop, 
            young_count$roll_mean)

young_plot <- ggplot(young_count, aes(x = data_year, y = Perc_young)) +
         geom_line(aes(x = data_year, y = roll_mean, color = Ringing.location), 
                   size = 2) +
         geom_line(aes(color = Ringing.location), alpha = 0.2, size = 2) +
         scale_color_manual(values = c("dodgerblue3",
                                       "darkorange3")) +
         geom_vline(aes(xintercept = max_mp), linetype = "dashed") +
  theme_bw() +
  theme(panel.grid = element_blank(),
        legend.position = c(.9, .9)) +
  labs(color = "Populations") +
  xlab("Year") +
  ylab("Percentage of juveniles")


pop_plot <- ggplot(pop_counts, aes(x = spring, y = count)) +
  geom_point(aes(color = site), linecolor = "gray60") +
  geom_line(aes(color = site), size = 2) +
  scale_color_manual(values = c("aquamarine4", 
                                "dodgerblue3",
                                "darkorange3")) +
  geom_vline(aes(xintercept = max_mp), linetype = "dashed") +
  theme_bw() +
  theme(panel.grid = element_blank(),
        legend.position = c(.9, .9)) +
  labs(color = "Populations") +
  xlab("Year") +
  ylab("Winter population count")
  

pop_plot
