# List of packages to check and install if missing
packages <- c("tidyverse", "readxl", "scales", "DT", "gt", "haven", "rio", "janitor", 
              "data.table", "sjlabelled", "sjmisc", "freqtables", "ggtext", "scales", 
              "prismatic", "gtsummary", "survey", "srvyr", "psych", "extrafont", 
              "likert", "broom", "prettyunits", "tidytext", "RDS", "openxlsx2",
              "summarytools")


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

# data
merged <- read_csv("data/merged.csv")

cascade_data <- merged |>
  transmute(barcode = barcode, 
         county = site_county_name, 
         site = site_name.x,
         typology = typology.x,
         
         ## First 95
         ## FSW & MSM
         q601 = q601_ever_tested_for_hiv, # Ever tested
         q606 = q606_most_recent_hiv_test_results, # recent results
         q609 = q609_result_of_last_selftest_conducted, # self test result
         q609 = q610_confirmed_hiv_pos_result, # confirm self test result
         
         ## PWID and TG typologies
         q701 = q701_ever_tested_for_hiv, # Ever tested
         q706 = q706_results_most_recent_HIV_test, # results
         q710 = q710_results_for_last_time_you_did_selftest, #self test result
         q711 = q711_confirmed_HIV_pos_at_faclitiy_for_selftest, # confirm self test
         
         ## 2nd 95
         ## FSW & MSM
         q704 = q704_ever_been_on_ARVs, # Ever been on ART
         q707 = q707_currently_on_ARVs, # Current on ART
         
         ## PWID and TG typologies
         q804 = q804_been_on_ARVs, #been on ART
         q807 = q807_currently_on_ARVs # Current on ART
         
         ## 3rd 95
         
         ) 


overall <- cascade_data |>
  filter(q606 %in% c("Negative", "Positive")) |>
  freq_table(typology, q606) |>
  freq_format(
    recipe = "percent_row (lcl_row - ucl_row)",
    name = "data_label",
    digits = 2
  ) %>%
  select(row_cat, col_cat, n_row, n, percent_row, lcl_row, ucl_row, data_label)




# Save results
library(openxlsx2)
wb <- wb_workbook(theme = "Office 2013 - 2022 Theme")
wb$add_worksheet("Overall")

## modify base font to size 10 Aptos Narrow in red
wb$set_base_font(font_size = 10, 
                 font_color = wb_color("black"), 
                 font_name = "Arial")

#wb$add_data(x = overall)

## font color does not affect tables
wb$add_data_table(x = overall, 
                  dims = wb_dims(from_col = 1))

## get the base font
wb_save(wb, "text.xlsx", overwrite = TRUE)







