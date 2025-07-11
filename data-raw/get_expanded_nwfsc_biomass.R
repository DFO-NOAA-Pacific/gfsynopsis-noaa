spp_list <- list(
  "arrowtooth flounder",
  "Dover sole",
  "English sole",
  "flathead sole",
  "giant grenadier",
  "Pacific cod",
  "Pacific hake", 
  "Pacific halibut",
  "Pacific herring",
  "Pacific ocean perch",
  "Pacific sanddab",
  "Pacific spiny dogfish", 
  "rex sole",
  "southern rock sole", 
  "sablefish",
  "sharpchin rockfish",
  "shortspine thornyhead",
  "splitnose rockfish",
  "spotted ratfish",
  "yellowtail rockfish"
)

get_ests_nwfsc <- purrr::pmap(
  .l = list(common_name = spp_list, survey = "NWFSC.Combo"),
  .f = pull_format_nwfsc_biomass
)
nwfsc_biomass <- get_ests_nwfsc |> purrr::list_rbind()

usethis::use_data(nwfsc_biomass, overwrite = TRUE)
