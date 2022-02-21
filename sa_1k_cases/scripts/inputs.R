#Packages
library(dplyr)
library(tidyr)
library(purrr)

#Helper functions
source('./scripts/helper_functions.R')
source('./scripts/get_data.R')

#Get the cleaned data
dat <- readRDS('./data/sa_covid_upto_mar5_2020.rds')

#Serial interval distribution
si_sd <- sqrt(log(1 + (2.7/4.7)^2))
si_mean <- log((4.7^2)/(sqrt(2.7^2 + 4.7^2)))


serial_interval <- function(x = 1) {
  si <- rlnorm(x, meanlog = si_mean, sdlog = si_sd)
  return(si)
  }
