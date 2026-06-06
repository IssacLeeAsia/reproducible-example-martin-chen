library(tidyverse)
library(broom.mixed)
library(modelbased)
library(parameters)

data_raw = 
  read_csv(
    "raw_data/Data_Exercise_CSV.csv"
  )


data_us = 
  data_raw |> 
  filter(country == "us") |> 
  mutate(
    outside_space = 
      factor(outside_space,
             levels = c(0, 1),
             labels = c("No", "Yes")),
    changed_behaviors = 
      factor(changed_behaviors)
  ) 


data_us_regression = data_us |> 
  mutate(changed_behaviors = if_else(changed_behaviors == "Yes", TRUE, FALSE)) 


model_change_outside_chisq = 
  data_us_regression |> 
  group_by(changed_behaviors, outside_space) |> 
  summarize(freq = n())|> 
  MASS::loglm(formula = freq ~ outside_space+changed_behaviors)

model_change_outside_logistic = 
  glm(data = data_us_regression ,
      formula = changed_behaviors ~ outside_space, family = binomial()) |> 
  tidy()



model_income_added_logistic = 
  data_us_regression |> 
  glm(formula = changed_behaviors ~ outside_space + income, family = binomial()) |> 
  tidy()








