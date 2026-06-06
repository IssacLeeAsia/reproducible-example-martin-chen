poisson_RSE = 
  function(
    data,
    outcome_var,
    covariates
  ) {
    
    library(sandwich)
    library(tidyverse)
    library(lmerTest)
    
    formula_i = reformulate(c(covariates), response = outcome_var)
    
    model_i = 
      glm(data = data, formula = formula_i, family = poisson())
    
    robust_cov <- vcovHC(model_i, type = "HC0")
    model_robust_cov = coeftest(model_i, vcov = robust_cov)
    
    return(model_robust_cov)
  }
