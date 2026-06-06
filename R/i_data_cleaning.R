pirl_raw_cleaning = 
  function(
    raw_file_loci, # single character, the location of the datasets
    country_chosen = c("china", "italy", "japan", "korea", "uk", "us") # cose one country
  ) {
    
    # the package I used
    library(tidyverse)
    library(haven)
    library(labelled)
    # self define not in function
    "%!in%" <- function(x, y) !(x %in% y)
    
    # input raw data location ----------
    data_raw = 
      haven::read_dta(
        file = raw_file_loci
      ) %>%
      mutate(across(where(is.labelled), labelled::to_factor))
    
    # cleaning data for summary statistics ------------
    data_us = 
      data_raw |> 
      filter(country %in% country_chosen) |> 
      mutate(
        outside_space = 
          factor(outside_space,
                 levels = c(0, 1),
                 labels = c("No", "Yes")),
        changed_behaviors = 
          factor(changed_behaviors)
      ) 
    
    # cleaning data for regression -------------
    data_us_regression = data_us |> 
      mutate(changed_behaviors = if_else(changed_behaviors == "Yes", TRUE, FALSE))
    
    list_output = 
      list(
        dataset = data_us,
        regression_dataset = data_us_regression
      )
    
    return(list_output)
  }





