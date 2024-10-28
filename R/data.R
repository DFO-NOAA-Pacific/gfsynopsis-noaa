#' Survey data from the Alaska and Northwest Fishery Science Centers
#'
#' @description
#' Various processed survey datasets.
#'
#' @format `biomass`: Design-based biomass estimates. A data frame.
#' \describe{
#'   \item{science_center}{Name of the U.S. Science Center.}
#'   \item{region}{U.S. region.}
#'   \item{area}{Survey name indicating the region of the data.}
#'   \item{common_name}{Species common name.}
#'   \item{scientific_name}{Species scientific name.}
#'   \item{year}{Year.}
#'   \item{est}{Mean biomass estimate.}
#'   \item{lwr}{Lower bound of the biomass estimated base on 95% confidence
#'   interval.}
#'   \item{uwr}{Upper bound of the biomass estimated base on 95% confidence
#'   interval.}
#' }
#' @rdname surveydata
"biomass"

#' @format `parameters`: Estimated growth parameters. A list of two data frames.
#' \describe{
#'   \item{region}{U.S. region.}
#'   \item{common_name}{Species common name.}
#'   \item{sex}{Sex (Female, Male, Unsexed).}
#'   \item{k}{Estimated von Bertanlaffy growth rate.}
#'   \item{Linf}{Estimated maximimum size in cm.}
#'   \item{L0}{Estimated minimum size at in cm.}
#'   \item{CV1}{Estimated coefficient of variation around L0.}
#'   \item{CV2}{Estimated coefficient of variation around Linf.}
#'   \item{median_intercept}{Median values for the length-mass intercept
#'   parameter (A).}
#'   \item{SD}{Estimated standard deviation for length-mass relationship.}
#'   \item{A}{Length-mass intercept A (A * length_cm ^ B).}
#'   \item{B}{Length-mass exponential parameter B (A * length_cm ^ B).}
#' }
#' @rdname surveydata
"parameters"

#' @format `specimens`: Biological data. A data frame.
#' \describe{
#'   \item{science_center}{Name of the U.S. Science Center.}
#'   \item{region}{U.S. region.}
#'   \item{survey_id}{Survey name indicating the region of the data.}
#'   \item{common_name}{Species common name.}
#'   \item{scientific_name}{Species scientific name.}
#'   \item{year}{Year.}
#'   \item{sex}{Sex (Female, Male, Unsexed).}
#'   \item{length_cm}{Length of fish in cm.}
#'   \item{age_years}{Age of fish in year.}
#'   \item{mass_kg}{Mass of fish in kg.}
#' }
#' @rdname surveydata
"specimens"

#' @format `length_comps`: Expanded length comps. A data frame.
#' \describe{
#'   \item{science_center}{Name of the U.S. Science Center.}
#'   \item{region}{U.S. region.}
#'   \item{area}{Survey name indicating the region of the data.}
#'   \item{common_name}{Species common name.}
#'   \item{scientific_name}{Species scientific name.}
#'   \item{year}{Year.}
#'   \item{sex}{Sex (Female, Male, Unsexed).}
#'   \item{length_cm}{Length of fish in cm.}
#'   \item{population_count}{Expanded observations by length.}
#'   \item{total}{Sum of the expanded length observations by year across all sexes.}
#'   \item{propotion}{Proportion of observations by length and sex that sums to
#'   100 for each year across all observed sexes.}
#' }
#' @rdname surveydata
"length_comps"

#' @format `age_comps`: Expanded age comps. A data frame.
#' \describe{
#'   \item{science_center}{Name of the U.S. Science Center.}
#'   \item{region}{U.S. region.}
#'   \item{area}{Survey name indicating the region of the data.}
#'   \item{common_name}{Species common name.}
#'   \item{scientific_name}{Species scientific name.}
#'   \item{year}{Year.}
#'   \item{sex}{Sex (Female, Male, Unsexed).}
#'   \item{age_years}{Age of the fish in years.}
#'   \item{population_count}{Expanded observations by age.}
#'   \item{total}{Sum of the expanded age observations by year across all sexes.}
#'   \item{propotion}{Proportion of observations by age and sex that sums to
#'   100 for each year across all observed sexes.}
#' }
#' @rdname surveydata
"age_comps"
