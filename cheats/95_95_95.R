# List of packages to check and install if missing
packages <- c("tidyverse", "readxl", "scales", "DT", "gt", "haven", "rio", "janitor", 
              "data.table", "sjlabelled", "sjmisc", "freqtables", "ggtext", "scales", 
              "prismatic", "gtsummary", "survey", "srvyr", "psych", "extrafont", 
              "likert", "broom", "prettyunits", "tidytext")


install_if_missing <- function(packages) {
  for (package in packages) {
    if (!require(package, character.only = TRUE)) {
      install.packages(package, dependencies = TRUE)
      library(package, character.only = TRUE)
    }
  }
}


# Call the function
install_if_missing(packages)
