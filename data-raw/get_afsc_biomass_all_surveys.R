token <- akfingapdata::create_token(here::here("wetzel_akfin_api_string.txt"))
afsc_species_survey <- get_afsc_species_survey(spp_list = spp_list)

get_ests_afsc_goa <- purrr::pmap(
  .l = list(
    survey_definition_id = 47,
    area_id = 99903,
    taxa = afsc_species_survey$taxa,
    start_year = afsc_species_survey$start_year,
    end_year = afsc_species_survey$end_year
  ),
  .f = pull_format_gap_biomass
)
afsc_biomass_goa <- get_ests_afsc_goa|> purrr::list_rbind()

get_ests_afsc_ai <- purrr::pmap(
  .l = list(
    survey_definition_id = 52,
    area_id = 99904,
    taxa = afsc_species_survey$taxa,
    start_year = afsc_species_survey$start_year,
    end_year = afsc_species_survey$end_year
  ),
  .f = pull_format_gap_biomass
)
afsc_biomass_ai <- get_ests_afsc_ai |> purrr::list_rbind()  |>
  dplyr::mutate(region = "U.S. Aleutian Islands")

get_ests_afsc_ebs_slope <- purrr::pmap(
  .l = list(
    survey_definition_id = 78,
    area_id = 99905,
    taxa = afsc_species_survey$taxa,
    start_year = afsc_species_survey$start_year,
    end_year = afsc_species_survey$end_year
  ),
  .f = pull_format_gap_biomass
)
afsc_biomass_ebs_slope  <- get_ests_afsc_ebs_slope |> 
  purrr::list_rbind() |>
  dplyr::mutate(region = "U.S. Eastern Bering Sea Slope")

get_ests_afsc_ebs_nw <- purrr::pmap(
  .l = list(
    survey_definition_id = 98,
    area_id = 99900,
    taxa = afsc_species_survey$taxa,
    start_year = afsc_species_survey$start_year,
    end_year = afsc_species_survey$end_year
  ),
  .f = pull_format_gap_biomass
)
afsc_biomass_ebs_nw  <- get_ests_afsc_ebs_nw |> purrr::list_rbind()  |>
  dplyr::mutate(region = "U.S. Eastern Bering Sea Standard Plus NW Region")

get_ests_afsc_ebs_region <- purrr::pmap(
  .l = list(
    survey_definition_id = 98,
    area_id = 99901,
    taxa = afsc_species_survey$taxa,
    start_year = afsc_species_survey$start_year,
    end_year = afsc_species_survey$end_year
  ),
  .f = pull_format_gap_biomass
)
afsc_biomass_ebs_region  <- get_ests_afsc_ebs_region |> purrr::list_rbind()  |>
  dplyr::mutate(region = "U.S. Eastern Bering Sea Standard Region")

get_ests_afsc_nbs <- purrr::pmap(
  .l = list(
    survey_definition_id = 143,
    area_id = 99902,
    taxa = afsc_species_survey$taxa,
    start_year = afsc_species_survey$start_year,
    end_year = afsc_species_survey$end_year
  ),
  .f = pull_format_gap_biomass
)
afsc_biomass_nbs  <- get_ests_afsc_nbs |> purrr::list_rbind()  |>
  dplyr::mutate(region = "U.S. Northern Bering Sea")

afsc_biomass <- dplyr::bind_rows(
  afsc_biomass_goa,
  afsc_biomass_ai,
  afsc_biomass_ebs_slope,
  afsc_biomass_ebs_nw ,
  afsc_biomass_ebs_region,
  afsc_biomass_nbs
)
usethis::use_data(afsc_biomass, overwrite = TRUE)
