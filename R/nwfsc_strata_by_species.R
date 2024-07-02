#' Define NWFSC strata to use by species
#'
#' @author Chantel Wetzel
#' @export
#'
nwfsc_strata_by_species <- function(){

  strata_to_use <- rbind(
    c("arrowtooth flounder", "strata 34.5-49"),
    c("Dover sole", "strata cw deep"),
    c("Pacific ocean perch", "strata 40.17-49"),
    c("sablefish", "strata cw deep")
  )
  strata_to_use <- as.data.frame(strata_to_use)
  colnames(strata_to_use) <- c("common_name", "strata")
  return(strata_to_use)
}
