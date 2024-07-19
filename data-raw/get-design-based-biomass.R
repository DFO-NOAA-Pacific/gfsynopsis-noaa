# Source the functions from the package
devtools::load_all(here::here())
# Load the required libraries
library(akfingapdata)
library(tidyverse)
library(keyring)

source(here::here("data-raw", "get-species.R"))

#===============================================================================
# Pull and calculate the design-based biomass estimates for the U.S. West Coast.
#===============================================================================
get_ests_nwfsc <- purrr::pmap(
  .l = list(common_name = spp_list, survey = "NWFSC.Combo"),
  .f = pull_format_nwfsc_biomass
  )
nwfsc_biomass <- get_ests_nwfsc |> purrr::list_rbind()

#===============================================================================
# Pull the design-based biomass estimates for Alaska
#===============================================================================

token <- akfingapdata::create_token(here::here("wetzel_akfin_api_string.txt"))
afsc_species_survey <- get_afsc_species_survey(spp_list = spp_list)

get_ests_afsc <- purrr::pmap(
  .l = list(
    survey_definition_id = afsc_species_survey$survey_definition_id,
    area_id = afsc_species_survey$area_id,
    taxa = afsc_species_survey$taxa,
    start_year = afsc_species_survey$start_year,
    end_year = afsc_species_survey$end_year
  ),
  .f = pull_format_gap_biomass
)

afsc_biomass <- get_ests_afsc |> purrr::list_rbind()

# Bind the area-specific data frames together and save as data for the package.
biomass <- rbind(nwfsc_biomass, afsc_biomass)
usethis::use_data(biomass, overwrite = TRUE)
