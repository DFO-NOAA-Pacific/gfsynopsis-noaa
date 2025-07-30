#' Define NWFSC strata to use by species
#'
#' @author Chantel Wetzel
#' @export
#'
nwfsc_strata_by_species <- function() {
  strata_to_use <- rbind(
    c("arrowtooth flounder", "strata 34.5-49"),
    c("Dover sole", "strata cw deep"),
    c("Pacific ocean perch", "strata 40.17-49"),
    c("sablefish", "strata cw deep"),
    c("English sole", "strata cw 350"),
    c("flathead sole", "strata cw 350"),
    c("giant grenadier", "strata cw deep 375-1280"),
    c("Pacific cod", "strata 40.17-49 250"),
    c("Pacific hake", "strata cw 549"),
    c("Pacific halibut", "strata cw 400"),
    c("Pacific herring", "strata 34.5-49 250"),
    c("Pacific sanddab", "strata cw 250"),
    c("Pacific spiny dogfish", "strata cw 450"), 
    c("rex sole", "strata cw 549"),
    c("southern rock sole", "strata cw 183"),
    c("sharpchin rockfish", "strata cw 549"),
    c("shortspine thornyhead", "strata cw deep"),
    c("splitnose rockfish", "strata cw 549"),
    c("spotted ratfish", "strata cw 549"),
    c("yellowtail rockfish", "strata 40.17-49 250")
  )
  strata_to_use <- as.data.frame(strata_to_use)
  colnames(strata_to_use) <- c("common_name", "strata")
  return(strata_to_use)
}
