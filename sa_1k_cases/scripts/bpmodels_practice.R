library("bpmodels")

# Chain log-likelihood outcomes ----
?chain_ll

chain_lengths <- c(1, 2, 3, 4, 5)

ll_chain <- chain_ll(
  x = chain_lengths,
  offspring = "pois",
  lambda = 0.5,
  stat = "size",
  obs_prob = 1#, # assumes a constant observation probability
  #nsim_obs = 100
)

ll_chain

plot(ll_chain, type = "l")

## Chain log-likelihood simulation
?chain_sim

ll_sim <- chain_sim(
  n = 10,
  offspring = "pois",
  lambda = 0.5,
  stat = "size",
  tree = FALSE
  #nsim_obs = 100
)

ll_sim

plot(ll_sim, type = "l")
