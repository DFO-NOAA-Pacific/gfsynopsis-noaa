#' Define NWFSC strata to use by species
#'
#' @param common_name The species common name as used in the NWFSC data warehouse
#'
#' @author Chantel Wetzel
#' @import nwfscSurvey
#' @export
#'
get_nwfsc_strata <- function(
    common_name) {
  all_strata <- nwfsc_strata_by_species()
  strata <- all_strata[which(all_strata$common_name == common_name), "strata"]

  if (strata == "strata cw general") {
    strata_to_use <- nwfscSurvey::CreateStrataDF.fn(
      names = c("shallow_wa", "shallow_or", "shallow_nca", "shallow_sca", "deep_wa", "deep_or", "deep_nca", "deep_sca"),
      depths.shallow = c(55, 55, 55, 55, 183, 183, 183, 183),
      depths.deep = c(183, 183, 183, 183, 549, 549, 549, 549),
      lats.south = c(46.0, 42.0, 34.5, 32.0, 46.0, 42.0, 34.5, 32.0),
      lats.north = c(49.0, 46.0, 42.0, 34.5, 49.0, 46.0, 42.0, 34.5)
    )
  }
  if (strata == "strata cw deep") {
    strata_to_use <- nwfscSurvey::CreateStrataDF.fn(
      names = c("shallow_wa", "shallow_or", "shallow_nca", "shallow_sca", "shelf_wa", "shelf_or", "shelf_nca", "shelf_sca", "slope_wa", "slope_or", "slope_nca", "slope_sca"),
      depths.shallow = c(55, 55, 55, 55, 183, 183, 183, 183, 549, 549, 549, 549),
      depths.deep = c(183, 183, 183, 183, 549, 549, 549, 549, 1280, 1280, 1280, 1280),
      lats.south = c(46.0, 42.0, 34.5, 32.0, 46.0, 42.0, 34.5, 32.0, 46.0, 42.0, 34.5, 32.0),
      lats.north = c(49.0, 46.0, 42.0, 34.5, 49.0, 46.0, 42.0, 34.5, 49.0, 46.0, 42.0, 34.5)
    )
  }
  if (strata == "strata 40.17-49") {
    strata_to_use <- nwfscSurvey::CreateStrataDF.fn(
      names = c("shallow_wa", "shallow_or", "shallow_nca", "shelf_wa", "shelf_or", "shelf_nca"),
      depths.shallow = c(55, 55, 55, 183, 183, 183),
      depths.deep = c(183, 183, 183, 549, 549, 549),
      lats.south = c(46.0, 42.0, 40.166667, 46.0, 42.0, 40.166667),
      lats.north = c(49.0, 46.0, 42.0, 49.0, 46.0, 42.0)
    )
  }
  if (strata == "strata 34.5-49") {
    strata_to_use <- nwfscSurvey::CreateStrataDF.fn(
      names = c("shallow_wa", "shallow_or", "shallow_nca", "shelf_wa", "shelf_or", "shelf_nca"),
      depths.shallow = c(55, 55, 55, 183, 183, 183),
      depths.deep = c(183, 183, 183, 549, 549, 549),
      lats.south = c(46.0, 42.0, 34.5, 46.0, 42.0, 34.5),
      lats.north = c(49.0, 46.0, 42.0, 49.0, 46.0, 42.0)
    )
  }

  return(strata_to_use)
}
