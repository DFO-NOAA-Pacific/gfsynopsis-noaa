#' Pull biomass estimates from AFSC surveys
#'
#' @param survey_defition_id Survey definition identifier.
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
pull_format_gap_biomass <- function(
    survey_definition_id,
    area_id,
    taxa,
    start_year,
    end_year) {
  survey <- akfingapdata::get_gap_survey_design()
  area <- akfingapdata::get_gap_area()
  stratum <- akfingapdata::get_gap_stratum_groups()

  stratum <- stratum |>
    dplyr::left_join(
      survey |>
        # remove year specific information from survey, we only need the region codes
        dplyr::group_by(survey_definition_id) |>
        dplyr::summarize(
          survey_definition_id = max(survey_definition_id)
        ),
      by = "survey_definition_id"
    ) |>
    dplyr::left_join(area, by = c("area_id" = "area_id", "survey_definition_id" = "survey_definition_id", "design_year" = "design_year"))


  gap_biomass <- akfingapdata::get_gap_biomass(
    survey_definition_id = survey_definition_id,
    area_id = area_id,
    species_code = taxa[, "species_code"],
    start_year = start_year,
    end_year = end_year
  )

  if (length(gap_biomass) > 0) {
    gap_biomass$common_name <- taxa[, "common_name"]
    gap_biomass$scientific_name <- taxa[, "species_name"]
    
    biomass <- gap_biomass |>
      dplyr::mutate(
        science_center = "AFSC",
        region = "U.S. Gulf of Alaska",
        area = paste0(survey_definition_id, "-", area_id),
        est = biomass_mt,
        lwr = biomass_mt - sqrt(biomass_var),
        upr = biomass_mt + sqrt(biomass_var)
      )
    columns_to_keep <- c(
      "science_center",
      "region",
      "area",
      "common_name",
      "scientific_name",
      "year",
      "est",
      "lwr",
      "upr"
    )
    return(biomass[, columns_to_keep])
  }
  
}
