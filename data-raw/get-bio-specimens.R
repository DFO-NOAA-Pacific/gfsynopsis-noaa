# Source the functions from the package
devtools::load_all(here::here())
# Load the required libraries
library(akfingapdata)
library(keyring)

source(here::here("data-raw", "get-species.R"))

# ===============================================================================
# Pull biological specimens for the U.S. West Coast.
# ===============================================================================
get_specimens_nwfsc <- purrr::pmap(
  .l = list(common_name = spp_list, survey = "NWFSC.Combo"),
  .f = pull_format_nwfsc_specimens
)
nwfsc_specimens <- get_specimens_nwfsc |> purrr::list_rbind()

# ===============================================================================
# Pull biological specimens for Alaska
# ===============================================================================

token <- akfingapdata::create_token(here::here("wetzel_akfin_api_string.txt"))
afsc_species_survey <- get_afsc_species_survey(spp_list = spp_list)

get_specimens_afsc <- purrr::pmap(
  .l = list(
    survey_definition_id = afsc_species_survey$survey_definition_id,
    area_id = afsc_species_survey$area_id,
    taxa = afsc_species_survey$taxa,
    start_year = afsc_species_survey$start_year,
    end_year = afsc_species_survey$end_year
  ),
  .f = pull_format_gap_specimens
)

afsc_specimens <- get_specimens_afsc |> purrr::list_rbind()

# Bind the area-specific data frames together and save as data for the package.
specimens <- rbind(nwfsc_specimens, afsc_specimens)
specimens <- as.data.frame(specimens)
usethis::use_data(specimens, overwrite = TRUE)

# ===========================================================
# Calculate sample number by year
# ===========================================================

samples <- specimens |>
  dplyr::group_by(region, common_name, year) |>
  dplyr::summarize(
    length = sum(!is.na(length_cm)),
    age = sum(!is.na(age)),
    mass = sum(!is.na(mass_kg))
  ) |>
  data.frame()
usethis::use_data(samples, overwrite = TRUE)

# ===========================================================
# Estimate biological parameters by species and region
# ===========================================================
parameters <- list()

mass_length <- specimens |>
  dplyr::filter(
    sex != "Unsexed",
    !is.na(mass_kg),
    mass_kg > 0,
    !is.na(length_cm),
    length_cm > 0
  ) |>
  dplyr::group_by(region, common_name) |>
  dplyr::group_modify(~ .x |>
    dplyr::reframe(
      vals = nwfscSurvey::estimate_weight_length(
        data = .x,
        col_length = "length_cm",
        col_weight = "mass_kg"
      )
    )) |>
  dplyr::ungroup() |>
  tidyr::unnest(cols = c(vals)) |>
  dplyr::mutate(
    group = factor(dplyr::case_match(group, "male" ~ "Male", "female" ~ "Female", "all" ~ "All"))
  ) |>
  dplyr::rename(
    sex = group
  )

parameters$mass_length <- mass_length

init_growth <- specimens |>
  dplyr::filter(!is.na(age), !is.na(length_cm)) |>
  dplyr::mutate(
    sex = dplyr::case_match(sex, "Male" ~ "M", "Female" ~ "F", "Unsexed" ~ "U")
  ) |>
  dplyr::rename(
    Age = age,
    Length_cm = length_cm,
    Sex = sex
  ) |>
  dplyr::group_by(region, common_name) |>
  dplyr::group_modify(~ .x |>
    dplyr::reframe(
      vals = nwfscSurvey::est_growth(
        dat = .x,
        return_df = FALSE
      )[c("female_growth", "male_growth")]
    ))

# growth_f <- specimens |>
#  dplyr::filter(
#    !is.na(age),
#    !is.na(length_cm),
#    sex == "Female") |>
#  dplyr::group_by(region, common_name) |>
#  dplyr::group_modify(~ .x |>
#    dplyr::reframe(
#      vals = list(coef(nls(
#       formula =length_cm ~ Linf * (1 - exp(-k * (age - t0))),
#       data = .x,
#       start = list(Linf = 45, k = 0.15, t0 = -2)
#    ))))
#  )
growth <- NULL
for (s in 1:length(spp_list)) {
  g <- matrix(
    data = unlist(init_growth[init_growth$common_name == spp_list[[s]], ]$vals),
    nrow = 4,
    ncol = 5,
    byrow = TRUE
  )
  a <- init_growth[init_growth$common_name == spp_list[[s]], c("region", "common_name")]
  s <- matrix(rep(c("Female", "Male"), 2), 4, 1)
  growth <- rbind(growth, cbind(a, s, g))
}
growth <- as.data.frame(growth)
colnames(growth) <- c("region", "common_name", "sex", "k", "Linf", "L0", "CV1", "CV2")
parameters$growth <- growth

usethis::use_data(parameters, overwrite = TRUE)
