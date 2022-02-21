#Packages
library(dplyr)
library(tidyr)
library(purrr)

#Helper functions
source('./scripts/helper_functions.R')
source('./scripts/get_data.R')

t0s <- c(0,2,3,4,4,4,4,6,6,6,6,6,6,7,7,7,8,8,8,8,8,8,8,8)

#Serial interval distribution
si_sd <- sqrt(log(1 + (2.7/4.7)^2))
si_mean <- log((4.7^2)/(sqrt(2.7^2 + 4.7^2)))


serial_interval <- function(x = 1) {
  si <- rlnorm(x, meanlog = si_mean, sdlog = si_sd)
  return(si)
  }

chain_lengths <- seq(1, 10, 1)

seed_times <- seq(0, 7, 1) #Assuming time 0 = March 5 and time 7 = March 13

end_times <- seed_times + 14 
