#Packages
library("bpmodels")

#Source the inputs
source('./scripts/inputs.R')

# Chain log-likelihood outcomes ----
ll_chain <- chain_ll(
  x = chain_lengths,
  offspring = "pois",
  lambda = 0.5,
  stat = "length",
  individual = FALSE,
  obs_prob = 1, # assumes a constant observation probability
  nsim_obs = 10
)

#output
ll_chain

plot(ll_chain, type = "l")

## Chain log-likelihood simulation
ll_sim <- chain_sim(
  n = 10,
  offspring = "pois",
  lambda = 0.5,
  stat = "size",
  serial = serial_interval,
  t0 = 0,
  tf = 14,
  tree = TRUE
  #nsim_obs = 100
)

#output
ll_sim

plot(ll_sim$time, ll_sim$n, type = "l")
