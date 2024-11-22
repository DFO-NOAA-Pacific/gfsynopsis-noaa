#' Pull biological specimens from AFSC surveys
#'
#' @param survey_definition_id Survey definition identifier.
#' @param area_id Survey area identifier.
#' @param taxa Vector of information on species created by
#'    akfingapdata::get_gap_taxonomic_classification().
#' @param start_year The start year of data to pull.
#' @param end_year The end year of data to pull.
#'
#' @returns Matrix of design-based biomass estimate for a species.
#' @author Chantel Wetzel
#' @import akfingapdata
#' @import dplyr
#' @export
#'
pull_format_gap_specimens <- function(
    survey_definition_id,
    area_id,
    taxa,
    start_year,
    end_year) {
  specimens <- akfingapdata::get_gap_specimen(
    survey_definition_id = survey_definition_id,
    species_code = taxa[, "species_code"],
    start_year = start_year,
    end_year = end_year
  ) |>
    dplyr::mutate(
      sex = factor(case_match(sex, 1 ~ "Male", 2 ~ "Female", 3 ~ "Unsexed"), levels = c("Male", "Female", "Unsexed")),
      length_cm = length_mm / 10,
      mass_kg = weight_g / 1000,
      common_name = taxa[, "common_name"],
      scientific_name = taxa[, "species_name"],
      science_center = "AFSC",
      region = "U.S. Gulf of Alaska",
      survey = survey_definition_id
    )

  # Need to inquire about specimen_subsample_method, specimen_sample_type, and age_determination_method

  columns_to_keep <- c(
    "science_center",
    "region",
    "survey",
    "common_name",
    "scientific_name",
    "year",
    "sex",
    "length_cm",
    "age_years",
    "mass_kg"
  )
  return(specimens[, columns_to_keep])
}
