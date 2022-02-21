#Packages
library(dplyr)
library(tidyr)
library(purrr)

#Helper functions
source('./scripts/helper_functions.R')
source('./scripts/get_data.R')

#Get the cleaned data
dat <- readRDS('./data/sa_covid_upto_mar5_2020.rds')

#bpmodels inputs
dat <- dat %>% 
  mutate(days_from_t0 = as.integer(date - min(date)))


serial_interval <- function(x = 1) {
  si <- rlnorm(x, meanlog = si_mean, sdlog = si_sd)
  return(si)
  }
