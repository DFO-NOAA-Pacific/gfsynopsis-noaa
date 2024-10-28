#' Pull length composition estimates from AFSC surveys
#'
#' @param survey_defition_id Survey definition identifier.
#' @param area_id Survey area identifier.
#' @param taxa Vector of information on species created by
#'    akfingapdata::get_gap_taxonomic_classification().
#' @param start_year The start year of data to pull.
#' @param end_year The end year of data to pull.
#' @param comp_type Text string indicating whether to process length or age
#' composition data. Default "length_cm".
#'
#' @returns Matrix of composition estimates for a species.
#' @author Chantel Wetzel
#' @import akfingapdata
#' @import dplyr
#' @export
#'
pull_format_gap_size_comp <- function(
    survey_definition_id,
    area_id,
    taxa,
    start_year,
    end_year,
    comp_type = "length_cm") {
  survey <- akfingapdata::get_gap_survey_design()
  area <- akfingapdata::get_gap_area()

  if (comp_type == "length_cm") {
    gap_sizecomp <- akfingapdata::get_gap_sizecomp(
      survey_definition_id = survey_definition_id,
      area_id = area_id,
      species_code = taxa[, "species_code"],
      start_year = start_year,
      end_year = end_year
    )

    gap_sizecomp <- gap_sizecomp |>
      dplyr::filter(length_mm > 0) |>
      dplyr::mutate(
        sex = dplyr::case_match(sex, 1 ~ "Male", 2 ~ "Female", 3 ~ "Unsexed"),
        length_cm = length_mm / 10
      ) |>
      dplyr::group_by(year) |>
      dplyr::mutate(
        total = sum(population_count),
        proportion = 100 * population_count / unique(total)
      )
  }

  if (comp_type == "age") {
    gap_sizecomp <- akfingapdata::get_gap_agecomp(
      survey_definition_id = survey_definition_id,
      area_id = area_id,
      species_code = taxa[, "species_code"],
      start_year = start_year,
      end_year = end_year
    )

    gap_sizecomp <- gap_sizecomp |>
      dplyr::filter(age > 0) |>
      dplyr::mutate(
        sex = dplyr::case_match(sex, 1 ~ "Male", 2 ~ "Female", 3 ~ "Unsexed")
      ) |>
      dplyr::group_by(year) |>
      dplyr::mutate(
        total = sum(population_count),
        proportion = 100 * population_count / unique(total)
      )
  }

  gap_sizecomp$common_name <- taxa[, "common_name"]
  gap_sizecomp$scientific_name <- taxa[, "species_name"]

  gap_sizecomp <- gap_sizecomp |>
    dplyr::mutate(
      science_center = "AFSC",
      region = "U.S. Gulf of Alaska",
      area = paste0(survey_definition_id, "-", area_id)
    )
  columns_to_keep <- c(
    "science_center",
    "region",
    "area",
    "common_name",
    "scientific_name",
    "year",
    "sex",
    dplyr::if_else(
      comp_type == "length_cm",
      true = "length_cm",
      false = "age"
    ),
    "population_count",
    "total",
    "proportion"
  )
  return(gap_sizecomp[, columns_to_keep])
}
