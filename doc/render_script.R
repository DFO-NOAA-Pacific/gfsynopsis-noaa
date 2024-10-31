library(gfsynopsisnoaa)
setwd(here::here("doc"))

name <- biomass |>
  dplyr::distinct(common_name) |>
  dplyr::pull(common_name) |>
  as.character()

for (a in 1:length(name)) {
reports <- tibble::tibble(
  input = "gfsynopsis-noaa.qmd",
  output_file = stringr::str_glue("{name}_2024.html"),
  execute_params = purrr::map(name, ~list(common_name = .))
)[1,]

purrr::pwalk(reports, quarto::quarto_render)
}
# FYI if you use the targets::tar_render_rep command it does all of the
# purrr nonsense for you
