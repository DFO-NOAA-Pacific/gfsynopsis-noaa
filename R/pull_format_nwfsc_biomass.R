#' Pull biomass estimates from NWFSC survey
#'
#' @param common_name The common name used in the NWFSC data warehouse.
#' @param survey The survey name used in the NWFSC data warehouse.
#'
#' @returns Matrix of design-based biomass estimate for a species.
#' @author Chantel Wetzel
#'
#' @import nwfscSurvey
#' @import dplyr
#' @export
#'
pull_format_nwfsc_biomass <- function(
    common_name,
    survey = "NWFSC.Combo") {

  catch <- nwfscSurvey::pull_catch(
    common_name = common_name,
    survey = survey,
    convert = FALSE,
    verbose = FALSE
  )

  # Define the strata for expansion
  strata <- get_nwfsc_strata(common_name = common_name)

  # Calculate the design-based index
  nwfsc_biomass <- nwfscSurvey::get_design_based(
    data = catch,
    strata = strata
  )[2]
  nwfsc_biomass <- as.data.frame(nwfsc_biomass)

  biomass <- nwfsc_biomass |>
    dplyr::mutate(
      science_center = "NWFSC",
      region = "U.S. West Coast",
      area = unique(catch[, "project"]),
      common_name = unique(catch[, "common_name"]),
      scientific_name = unique(catch[, "scientific_name"])
    ) |>
    dplyr::rename(
      year = biomass.year,
      est = biomass.est,
      lwr = biomass.lwr,
      upr = biomass.upr
    )

  columns_to_keep <-  c(
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
