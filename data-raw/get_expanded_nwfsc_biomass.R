spp_list <- list(
  "arrowtooth flounder",
  "canary rockfish",
  "chilipepper",
  "darkblotched rockfish",
  "Dover sole",
  "English sole",
  "flathead sole",
  "giant grenadier",
  "lingcod",
  "longspine thornyhead",
  "Pacific cod",
  "Pacific hake", 
  "Pacific halibut",
  "Pacific herring",
  "Pacific ocean perch",
  "Pacific sanddab",
  "Pacific spiny dogfish", 
  "petrale sole",
  "rex sole",
  "southern rock sole", 
  "sablefish",
  "sharpchin rockfish",
  "shortbelly rockfish",
  "shortspine thornyhead",
  "splitnose rockfish",
  "spotted ratfish",
  "stripetail rockfish",
  "yellowtail rockfish"
)

get_ests_nwfsc <- purrr::pmap(
  .l = list(common_name = spp_list, survey = "NWFSC.Combo"),
  .f = pull_format_nwfsc_biomass
)
nwfsc_biomass <- get_ests_nwfsc |> purrr::list_rbind()

usethis::use_data(nwfsc_biomass, overwrite = TRUE)
