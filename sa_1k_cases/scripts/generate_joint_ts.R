# Packages
library("bpmodels")
library("dplyr")

# Source the inputs
source("./scripts/inputs.R")

set.seed(1234)

## Chain log-likelihood simulation
simulation_output_list <- lapply(
  1:number_of_sims,
  function(ii) {
    chain_sim(
      n = length(days_from_t0), # number of chains to simulate.
      offspring = "nbinom",
      mu = 2.0,
      size = 0.38,
      stat = "size",
      infinite = 10E6,
      serial = serial_interval,
      t0 = days_from_t0,
      tf = projection_end_day
    ) %>%
      mutate(sim_id = ii)
  }
)

# Unlist and bind simulation results.
simulation_output <- bind_rows(simulation_output_list, .id = "column_label")


# Calculate cases per simulation per day. 
simulation_output_mod <- simulation_output %>%
  mutate(day = ceiling(time))%>%
  group_by(sim_id, day) %>%
  summarise(cases = n(), .groups = "drop_last") %>%
  ungroup()
  
# Calculate daily median cases and attach observed dates.  
final_output <- simulation_output_mod %>% 
  arrange(day) %>% 
  group_by(day) %>% 
  summarise(median_cases = median(cases)) %>% 
  ungroup() %>% 
  mutate(date = dmy("05-03-2020") + 0:projection_end_day)

# Save time series.

if(dir.exists('./data')){
  saveRDS(final_output, file = './data/sa_covid_ts_14_days_from_march13.rds')
}else{
  dir.create('./data')
  saveRDS(final_output, file = './data/sa_covid_ts_14_days_from_march13.rds')
}

# Make plots.
cases_plot <- ggplot(data = final_output) +
  geom_bar(aes(x = date, y = median_cases),
    stat = "identity",
    fill = "blue",
    size = 1
  )

print(cases_plot)
