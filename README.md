# Intro

This is an example of how Martin build his reproducible workflow.


## Structure of the analysis folder

-   `_targets`

    -   A folder containing all the outputs from `_targets.R`. It can only be loaded to the R environment using the `targets` package in R
    -   If you want to remove this folder and recreate another one, please set the working directory to the location of `_targets.R`, execute `targets::tar_destroy()`, and then run `targets::tar_make()`

-   `_targets.R`

    -   An `.R` script to reproduce the analysis. To reproduce the analysis, you can set the working directory to the location of this script and execute `targets::tar_make()` on the console.

    -   If you don't want to reproduce the results, you can just set the working directory to the location of this script and execute the R command below on the console to check the established results.

```         
if (!require('targets', character.only = TRUE)) {
  install.packages('targets', dependencies = TRUE)
  library('targets')
}

library(targets)

# cleaed dataset for analysis
tar_load(us_datasets)
# logistic regression outcome of changed_behaviors ~ outside_spaces
tar_load(result_logistic)
# logistic regression outcome of changed_behaviors ~ outside_spaces + income
tar_load(result_logistic_income)
# chi-suqared test results of changed_behaviors * outside_spaces
tar_load(chisq_bc_os)
# poissson regression (w/ robust standard error) outcome of changed_behaviors ~ outside_spaces
tar_load(result_poisson_RSE)
# probit regression outcome of changed_behaviors ~ outside_spaces
tar_load(result_probit)
```

-   `R`

    -   A folder containing all the `R` functions used in the `_targets.R` script.

-   `raw_data`

    -   Raw datasets and codebooks for this data exercise.