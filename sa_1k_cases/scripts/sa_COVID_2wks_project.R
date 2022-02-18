#Packages
library("bpmodels")
library('dplyr')
library('ggplot2')

#Source the inputs
source('./scripts/inputs.R')

set.seed(1234)
## Chain log-likelihood simulation
ll_sim <- chain_sim(
  n = length(t0s),
  offspring = "nbinom",
  mu = 2.0,
  size = 0.38,
  stat = "size",
  infinite = 1E5,
  serial = serial_interval,
  t0 = t0s,
  tf = 14,
  tree = TRUE
)

#output
ll_sim_mod <- ll_sim %>% 
  mutate(day = floor(time)) %>% 
  group_by(day) %>% 
  summarise(cases = n()) %>% 
  ungroup() %>% 
  summarise(cum_cases = cumsum(cases)) %>% 
  mutate(date = lubridate::as_date('2020-03-27') + 1:12)

cases_plot <- ggplot(data = ll_sim_mod) + 
  geom_line(aes(x = date, y = cum_cases), 
           stat = 'identity', 
           color = 'blue',
           size = 1
           )

print(cases_plot)
