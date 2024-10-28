#' Pull expanded length composition data for the U.S. West Coast
#'
#' @param common_name The common name used in the NWFSC data warehouse.
#' @param survey The survey name used in the NWFSC data warehouse.
#' @param comp_type Text string indicating whether to process length or age
#' composition data. Default "length_cm".
#'
#' @returns Matrix of length composition estimate for a species.
#' @author Chantel Wetzel
#'
#' @import nwfscSurvey
#' @import tidyr
#' @import dplyr
#' @export
#'
pull_format_nwfsc_size_comp <- function(
    common_name,
    survey = "NWFSC.Combo",
    comp_type = "length_cm") {

  catch <- nwfscSurvey::pull_catch(
    common_name = common_name,
    survey = survey,
    convert = FALSE,
    verbose = FALSE
  )

  bio <- nwfscSurvey::pull_bio(
    common_name = common_name,
    survey = survey,
    convert = FALSE,
    verbose = FALSE
  )

  # Define the strata for expansion
  strata <- get_nwfsc_strata(common_name = common_name)

  # Determine the bin size:
  ind <- !is.na(bio[, comp_type])
  min_len <- floor(min(bio[ind, comp_type]))
  max_len <- floor(max(bio[ind, comp_type]))
  comp_bins <- seq(min_len , max_len, 1)

  # Calculate the expanded length comps
  init_sizecomps <- nwfscSurvey::get_expanded_comps(
      bio_data = bio,
      catch_data = catch,
      comp_bins = comp_bins,
      strata = strata,
      comp_column_name = comp_type,
      output = "full_expansion_unformatted",
      verbose = FALSE
    ) |>
    tidyr::pivot_longer(
      cols = dplyr::starts_with("total"),
      names_to = c("sex"),
      values_to = "population_count"
    ) |>
    dplyr::mutate(
      sex = dplyr::case_match(sex, "total_male" ~ "Male", "total_female" ~ "Female", "total_unsexed" ~ "Unsexed")
    ) |>
    dplyr::group_by(year) |>
    dplyr::mutate(
      total = sum(population_count),
      proportion = 100 * population_count / unique(total)
    ) |>
    dplyr::rename(
      length_cm = bin
    )

  if (comp_type == "age") {
    init_sizecomps <- init_sizecomps |>
      dplyr::rename(
        age_years = length_cm
      )
  }

  nwfsc_sizecomp <- init_sizecomps |>
    dplyr::mutate(
      science_center = "NWFSC",
      region = "U.S. West Coast",
      area = unique(catch[, "project"]),
      common_name = unique(catch[, "common_name"]),
      scientific_name = unique(catch[, "scientific_name"])
    )
  columns_to_keep <-  c(
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
      false = "age_years"),
    "population_count",
    "total",
    "proportion"
  )

  return(nwfsc_sizecomp[, columns_to_keep])
}
