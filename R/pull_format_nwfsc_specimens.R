#' Pull biological specimens from NWFSC survey
#'
#' @param common_name The common name used in the NWFSC data warehouse.
#' @param survey_name The survey name used in the NWFSC data warehouse.
#'
#' @returns Matrix of design-based biomass estimate for a species.
#' @author Chantel Wetzel
#'
#' @import nwfscSurvey
#' @import ggplot2
#' @import dplyr
#' @export
#'
pull_format_nwfsc_specimens <- function(
    common_name,
    survey = "NWFSC.Combo") {

  specimens <- nwfscSurvey::pull_bio(
    common_name = common_name,
    survey = survey,
    convert = FALSE,
    verbose = FALSE
    ) |>
    dplyr::mutate(
      sex = factor(dplyr::case_match(sex, "M" ~ "Male", "F" ~ "Female", "U" ~ "Unsexed"), levels = c("Male", "Female", "Unsexed")),
      age = age_years,
      mass_kg = weight_kg,
      science_center = "NWFSC",
      region = "U.S. West Coast",
      survey = project)

  columns_to_keep <-  c(
    "science_center",
    "region",
    "survey",
    "common_name",
    "scientific_name",
    "year",
    "sex",
    "length_cm",
    "age",
    "mass_kg"
  )
  return(specimens[, columns_to_keep])
}
