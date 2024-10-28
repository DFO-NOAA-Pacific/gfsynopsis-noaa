#' Pull taxa information for AFSC data
#'
#' @param spp_list A list of species common_names.
#'
#' @author Chantel Wetzel
#' @import akfingapdata
#' @import purrr
#' @export
#'
get_afsc_species_survey <- function(spp_list) {

  species_survey <- list()

  species_survey$taxa <- purrr::lmap(
    .x = spp_list,
    .f = get_taxa
  )

  species_survey$survey_definition_id <- 47
  species_survey$area_id <- 99903
  species_survey$start_year <- 1990
  species_survey$end_year <- 2050

  return(species_survey)
}
