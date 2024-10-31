to_plot <- function(
  biomass,
  specimens,
  parameters,
  samples = NULL) {

  firstup <- function(x) {
    substr(x, 1, 1) <- toupper(substr(x, 1, 1))
    x
  }

  section_name <- firstup(unique(biomass$common_name))
  glue::glue(" \n{section_name} \n \n") |> cat( )
  #glue::glue(" \n# {section_name} {{-}}\n \n") |> cat( )

  bio_plot <- plot_design_based(
    data = biomass,
    plot = 1)

  mass_length <- plot_biology(
    data = specimens,
    parameters = parameters,
    plot = 1)

  length_age <- plot_biology(
    data = specimens,
    parameters = parameters,
    plot = 2)

  suppressWarnings(print(bio_plot))
  suppressWarnings(print(mass_length))
  suppressWarnings(print(length_age))
  #cowplot::plot_grid(
  #  mass_length, length_age, ncol = 1, nrow = 2,
  #  rel_widths = 1.2, rel_heights = 1.2
  #)
}
