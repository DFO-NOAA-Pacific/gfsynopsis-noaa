# Source the functions from the package
devtools::load_all(here::here())
# Load the required libraries
library(akfingapdata)
library(keyring)

source(here::here("data-raw", "get-species.R"))

#===============================================================================
# Pull the size composition data for the U.S. West Coast.
#===============================================================================

get_length_comps_nwfsc <- purrr::pmap(
  .l = list(
   common_name = spp_list,
   survey = "NWFSC.Combo",
   comp_type = "length_cm"
  ),
  .f = pull_format_nwfsc_size_comp
)

nwfsc_length_comps <- get_length_comps_nwfsc |> purrr::list_rbind()

#===============================================================================
# Pull the size composition data for Alaska
#===============================================================================

token <- akfingapdata::create_token(here::here("wetzel_akfin_api_string.txt"))
afsc_species_survey <- get_afsc_species_survey(spp_list = spp_list)

get_length_comps_afsc <- purrr::pmap(
  .l = list(
    survey_definition_id = afsc_species_survey$survey_definition_id,
    area_id = afsc_species_survey$area_id,
    taxa = afsc_species_survey$taxa,
    start_year = afsc_species_survey$start_year,
    end_year = afsc_species_survey$end_year,
    comp_type = "length_cm"
  ),
  .f = pull_format_gap_size_comp
)

afsc_length_comps <- get_length_comps_afsc |> purrr::list_rbind()

#===============================================================================
# Pull the age composition data for the U.S. West Coast.
#===============================================================================

get_age_comps_nwfsc <- purrr::pmap(
  .l = list(
    common_name = spp_list,
    survey = "NWFSC.Combo",
    comp_type = "age"
  ),
  .f = pull_format_nwfsc_size_comp
)

nwfsc_age_comps <- get_age_comps_nwfsc |> purrr::list_rbind()


#===============================================================================
# Pull the age composition data for Alaska
#===============================================================================

get_age_comps_afsc <- purrr::pmap(
  .l = list(
    survey_definition_id = afsc_species_survey$survey_definition_id,
    area_id = afsc_species_survey$area_id,
    taxa = afsc_species_survey$taxa,
    start_year = afsc_species_survey$start_year,
    end_year = afsc_species_survey$end_year,
    comp_type = "age"
  ),
  .f = pull_format_gap_size_comp
)

afsc_age_comps <- get_age_comps_afsc |> purrr::list_rbind()

#===============================================================================
# Bind the area-specific data frames together and save as data for the package.
#===============================================================================
age_comps <- rbind(nwfsc_age_comps, afsc_age_comps)
usethis::use_data(age_comps, overwrite = TRUE)
length_comps <- rbind(nwfsc_length_comps, afsc_length_comps)
usethis::use_data(length_comps, overwrite = TRUE)
