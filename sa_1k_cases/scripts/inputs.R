#Inputs

#Serial interval distribution
si_sd <- exp(2.9)
si_mean <- exp(4.7)


serial_interval <- function(x = 1:10) {
  si <- rlnorm(x, meanlog = si_mean, sdlog = si_sd)
  return(si)
  }

chain_lengths <- seq(1, 10, 1)

seed_times <- seq(0, 7, 1) #Assuming time 0 = March 5 and time 7 = March 13

end_times <- seed_times + 14 

library(readr)
covid19za_timeline_confirmed <- read_csv("scripts/covid19za_timeline_confirmed.csv")
View(covid19za_timeline_confirmed)


