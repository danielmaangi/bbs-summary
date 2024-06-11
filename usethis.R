# gitcreds::gitcreds_set()
# 
# usethis::use_git_ignore("data/")
# usethis::use_github()


# Filter data for the specified county
county_specific_data <- county_data %>% filter(County == params$county)

# List of counties
counties <- c("NAIROBI", "MOMBASA")



# Render the Quarto document for each county
for (county in counties) {
  quarto_render(
    input = "index.qmd",
    output_file = paste0("BBS_REPORT_", county, ".docx"),
    execute_params = list(county = county)
  )
}


print(formatted_date)
