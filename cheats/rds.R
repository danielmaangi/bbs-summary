
merged <- read_csv("data/merged.csv")

waldo::compare(c("a", "b", "c"), c("a", "b"))

compare(c("a", "b", "c"), c("a", "b", "c"))

options(width = 20)
compare(letters[1:5], letters[1:5])

options(width = 10)
compare(letters[1:5], letters[1:6])

# Simulated dataset
data <- data.frame(
  id = 1:100,
  recruiter.id = c(NA, sample(1:99, 99, replace = TRUE)),
  network.size.variable = sample(1:10, 100, replace = TRUE),
  is_fsw = sample(c(0, 1), 100, replace = TRUE)
)

library(RDS)

# Create RDS object
rds_data <- as.rds.data.frame(data)

dat <- data.frame(id=c(1,2,3,4,5), recruiter.id=c(2,-1,2,-1,4),
                  network.size.variable=c(4,8,8,2,3))
as.rds.data.frame(dat)


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
