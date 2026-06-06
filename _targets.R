

# Load packages required to define the pipeline:
library(targets)
library(tarchetypes) # Load other packages as needed.

# Set target options:
tar_option_set(
  packages = c(
    "tidyverse",
    "broom.mixed",
    "lmtest",
    "sandwich",
    "modelbased",
    "parameters"
  ) # Packages that your targets need for their tasks.
 
)

# Run the R scripts in the R/ folder with your custom functions:
tar_source("R")
# tar_source("other_functions.R") # Source other scripts as needed.

# Replace the target list below with your own:
list(
  
  # cleaning datasets --------
  tar_target(
    name = us_datasets,
    command = pirl_raw_cleaning("raw_data/DATA_EXERCISE.dta", 
                                country_chosen = "us")
  ),
  
  # chi-squared test results -------
  tar_target(
    name = chisq_bc_os,
    command = chisq.test(with(us_datasets$dataset, table(changed_behaviors, outside_space)))
      
  ),
  
  # logistic regression results -------
  tar_target(
    name = result_logistic,
    command = glm(data = us_datasets$regression_dataset ,
                  formula = changed_behaviors ~ outside_space, family = binomial()) 
  ),
  
  # probit regression result -----------
  tar_target(
    name = result_probit,
    command = glm(data = us_datasets$regression_dataset ,
                  formula = changed_behaviors ~ outside_space, family = binomial(link = "probit")) 
  ),
  
  # logistic regression results with income -------
  tar_target(
    name = result_logistic_income,
    command = glm(data = us_datasets$regression_dataset ,
                  formula = changed_behaviors ~ outside_space + income, family = binomial()) 
  ),
  
  # poisson regression with robust standard error
  tar_target(
    name = result_poisson_RSE,
    command = poisson_RSE(
      data = us_datasets$regression_dataset,
      outcome_var = "changed_behaviors", 
      covariates = c("outside_space")
    )
  ),
  
  tar_quarto(
    name = report,
    path = "analysis_report.qmd"
  )
  
  
)
