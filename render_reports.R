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
