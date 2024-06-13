# Simulated dataset
data <- data.frame(
  respondent_id = 1:100,
  recruiter_id = c(NA, sample(1:99, 99, replace = TRUE)),
  network_size = sample(1:10, 100, replace = TRUE),
  is_fsw = sample(c(0, 1), 100, replace = TRUE)
)

# Create RDS object
rds_data <- as.rds.data.frame(data, id = "respondent_id", recruiter.id = "recruiter_id", network.size.variable = "network_size")

# Estimate population proportion
population_estimate <- RDS.II.estimates(rds_data, outcome.variable = "is_fsw")

# Print population estimate
print(population_estimate)

# Calculate estimated number of FSWs
total_population_size <- 10000  # Replace with your estimated total population size
estimated_proportion_fsw <- population_estimate$estimates
estimated_number_fsw <- estimated_proportion_fsw * total_population_size

# Print estimated number of FSWs
print(estimated_number_fsw)
