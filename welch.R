welch <- function(data, factor, alpha) {
  factor <- as.factor(factor)
  treatment_data <- split(data, factor)
  means <- by(data, factor, mean)
  variances <- by(data, factor, var)
  num_elements <- sapply(treatment_data, length)
  a <- nlevels(factor)
  N <- length(factor)
  
  omega <- num_elements / variances
  yba <- sum(omega * means) / sum(omega)
  lambda <- sum((1 / (num_elements - 1)) * (1 - (omega / sum(omega)))^2)
  
  v1 <- a - 1
  v2 <- (a^2 - 1) / (3 * lambda)
  
  fomega <- ((1 / v1) * sum(omega * (means - yba)^2)) / (1 + ((2 * (a - 2) * lambda) / ((a^2) - 1)))
  critical_value <- qf(1 - alpha, v1, v2)
  
  if (fomega > critical_value) {
    cat("The null hypothesis is rejected because", fomega, "is greater than", critical_value, "\n")
  } else {
    cat("The null hypothesis is accepted because", fomega, "is smaller than", critical_value, "\n")
  }
  
  p_value <- 1 - pf(fomega, v1, v2)
  
  if (p_value < alpha) {
    cat("The null hypothesis is rejected because the p-value", p_value, "is smaller than the significance level", alpha, "\n")
  } else {
    cat("The null hypothesis is accepted because the p-value", p_value, "is greater than the significance level", alpha, "\n")
  }
}

  

