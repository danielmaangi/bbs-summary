library(summarytools)

data("exams")
# All stats for all numerical variabls
descr(exams)
# Only common statistics
descr(exams, stats = "common")
# Arbitrary selection of statistics, transposed
descr(exams, stats = c("mean", "sd", "min", "max"), transpose = TRUE)
# Rmarkdown-ready
descr(exams, plain.ascii = FALSE, style = "rmarkdown")
# Grouped statistics
data("tobacco")
with(tobacco, stby(BMI, gender, descr))
# Grouped statistics, transposed
with(tobacco, stby(BMI, age.gr, descr, stats = "common", transpose = TRUE))
## Not run:
# Show in Viewer (or browser if not in RStudio)
view(descr(exams))
# Save to html file with title


## Desriptives

# Define the function to perform frequency summary
frequency_summary <- function(data, variables) {
  # Select the specified variables using all_of
  selected_data <- data %>%
    select(all_of(variables))
  
  # Initialize an empty list to store the frequency summaries
  freq_summaries <- list()
  
  # Loop through each column and apply the frq function
  for (col in colnames(selected_data)) {
    freq_summaries[[col]] <- frq(selected_data[[col]])
  }
  
  return(freq_summaries)
}

cols <- c("q601_ever_tested_for_hiv",
          "q606_most_recent_hiv_test_results",
          "q609_result_of_last_selftest_conducted",
          "q610_confirmed_hiv_pos_result")

freq_summary_result <- frequency_summary(data = cascade_data, 
                                         variables = cols)

# Print the frequency summaries
# print(freq_summary_result)