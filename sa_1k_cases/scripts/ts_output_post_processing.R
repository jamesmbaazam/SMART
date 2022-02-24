#Packages
library('dplyr')
library("ggplot2")
library('lubridate')


#Load the simulation output if it exists, else run the simulation script and load the results
simulation_output <- if (file.exists("./model_output/two_wks_daily_cases_projection.rds")) {
  readRDS("./model_output/two_wks_daily_cases_projection.rds")
} else {
  source("./scripts/generate_joint_ts.R", local = TRUE)
  simulation_output
}


#Source relevant scripts
source('./scripts/inputs.R')


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