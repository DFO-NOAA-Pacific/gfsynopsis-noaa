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
  if (strata == "strata cw 549") {
    strata_to_use <- nwfscSurvey::CreateStrataDF.fn(
      names = c("shallow_wa", "shallow_or", "shallow_nca", "shallow_sca", "shelf_wa", "shelf_or", "shelf_nca", "shelf_sca"),
      depths.shallow = c(55, 55, 55, 55, 183, 183, 183, 183),
      depths.deep = c(183, 183, 183, 183, 549, 549, 549, 549),
      lats.south = c(46.0, 42.0, 34.5, 32.0, 46.0, 42.0, 34.5, 32.0),
      lats.north = c(49.0, 46.0, 42.0, 34.5, 49.0, 46.0, 42.0, 34.5)
    )
  }
  if (strata == "strata cw 350") {
    strata_to_use <- nwfscSurvey::CreateStrataDF.fn(
      names = c("shallow_wa", "shallow_or", "shallow_nca", "shallow_sca", "shelf_wa", "shelf_or", "shelf_nca", "shelf_sca"),
      depths.shallow = c(55, 55, 55, 55, 183, 183, 183, 183),
      depths.deep = c(183, 183, 183, 183, 350, 350, 350, 350),
      lats.south = c(46.0, 42.0, 34.5, 32.0, 46.0, 42.0, 34.5, 32.0),
      lats.north = c(49.0, 46.0, 42.0, 34.5, 49.0, 46.0, 42.0, 34.5)
    )
  }
  if (strata == "strata cw 400") {
    strata_to_use <- nwfscSurvey::CreateStrataDF.fn(
      names = c("shallow_wa", "shallow_or", "shallow_nca", "shallow_sca", "shelf_wa", "shelf_or", "shelf_nca", "shelf_sca"),
      depths.shallow = c(55, 55, 55, 55, 183, 183, 183, 183),
      depths.deep = c(183, 183, 183, 183, 350, 400, 400, 400),
      lats.south = c(46.0, 42.0, 34.5, 32.0, 46.0, 42.0, 34.5, 32.0),
      lats.north = c(49.0, 46.0, 42.0, 34.5, 49.0, 46.0, 42.0, 34.5)
    )
  }
  if (strata == "strata cw 450") {
    strata_to_use <- nwfscSurvey::CreateStrataDF.fn(
      names = c("shallow_wa", "shallow_or", "shallow_nca", "shallow_sca", "shelf_wa", "shelf_or", "shelf_nca", "shelf_sca"),
      depths.shallow = c(55, 55, 55, 55, 183, 183, 183, 183),
      depths.deep = c(183, 183, 183, 183, 350, 450, 450, 450),
      lats.south = c(46.0, 42.0, 34.5, 32.0, 46.0, 42.0, 34.5, 32.0),
      lats.north = c(49.0, 46.0, 42.0, 34.5, 49.0, 46.0, 42.0, 34.5)
    )
  }
  if (strata == "strata cw deep") {
    strata_to_use <- nwfscSurvey::CreateStrataDF.fn(
      names = c(
        "shallow_wa", "shallow_or", "shallow_nca", "shallow_sca", "shelf_wa", "shelf_or", "shelf_nca", "shelf_sca",
        "slope_wa", "slope_or", "slope_nca", "slope_sca"
      ),
      depths.shallow = c(55, 55, 55, 55, 183, 183, 183, 183, 549, 549, 549, 549),
      depths.deep = c(183, 183, 183, 183, 549, 549, 549, 549, 1280, 1280, 1280, 1280),
      lats.south = c(46.0, 42.0, 34.5, 32.0, 46.0, 42.0, 34.5, 32.0, 46.0, 42.0, 34.5, 32.0),
      lats.north = c(49.0, 46.0, 42.0, 34.5, 49.0, 46.0, 42.0, 34.5, 49.0, 46.0, 42.0, 34.5)
    )
  }
  if (strata == "strata cw deep 375-1280") {
    strata_to_use <- nwfscSurvey::CreateStrataDF.fn(
      names = c(
        "shelf_wa", "shelf_or", "shelf_nca", "shelf_sca",
        "slope_wa", "slope_or", "slope_nca", "slope_sca"
      ),
      depths.shallow = c(400, 400, 400, 400, 549, 549, 549, 549),
      depths.deep = c(549, 549, 549, 549, 1280, 1280, 1280, 1280),
      lats.south = c(46.0, 42.0, 34.5, 32.0, 46.0, 42.0, 34.5, 32.0),
      lats.north = c(49.0, 46.0, 42.0, 34.5, 49.0, 46.0, 42.0, 34.5)
    )
  }
  if (strata == "strata cw 250") {
    strata_to_use <- nwfscSurvey::CreateStrataDF.fn(
      names = c("shallow_wa", "shallow_or", "shallow_nca", "shelf_wa", "shelf_or", "shelf_nca"),
      depths.shallow = c(55, 55, 55, 183, 183, 183),
      depths.deep = c(183, 183, 183, 250, 250, 250),
      lats.south = c(46.0, 42.0, 34.5, 46.0, 42.0, 34.5),
      lats.north = c(49.0, 46.0, 42.0, 49.0, 46.0, 42.0)
    )
  }
  if (strata == "strata cw 183") {
    strata_to_use <- nwfscSurvey::CreateStrataDF.fn(
      names = c("shallow_wa", "shallow_or", "shallow_nca"),
      depths.shallow = c(55, 55, 55),
      depths.deep = c(183, 183, 183),
      lats.south = c(46.0, 42.0, 34.5),
      lats.north = c(49.0, 46.0, 42.0)
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
  if (strata == "strata 40.17-49 250") {
    strata_to_use <- nwfscSurvey::CreateStrataDF.fn(
      names = c("shallow_wa", "shallow_or", "shallow_nca", "shelf_wa", "shelf_or", "shelf_nca"),
      depths.shallow = c(55, 55, 55, 183, 183, 183),
      depths.deep = c(183, 183, 183, 250, 250, 250),
      lats.south = c(46.0, 42.0, 40.166667, 46.0, 42.0, 40.166667),
      lats.north = c(49.0, 46.0, 42.0, 49.0, 46.0, 42.0)
    )
  }
  if (strata == "strata pcod") {
    strata_to_use <- nwfscSurvey::CreateStrataDF.fn(
      names = c("shallow_wa", "shallow_or_nca", "shelf_wa", "shelf_or_nca"),
      depths.shallow = c(55, 55, 183, 183),
      depths.deep = c(183, 183, 250, 250),
      lats.south = c(46.0, 40.166667, 46.0, 40.166667),
      lats.north = c(49.0, 46.0, 49.0, 46.0)
    )
  }
  if (strata == "strata 40.17-49 250") {
    strata_to_use <- nwfscSurvey::CreateStrataDF.fn(
      names = c("shallow_wa", "shallow_or", "shallow_nca", "shelf_wa", "shelf_or", "shelf_nca"),
      depths.shallow = c(55, 55, 55, 183, 183, 183),
      depths.deep = c(183, 183, 183, 250, 250, 250),
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
  if (strata == "strata 34.5-49 450") {
    strata_to_use <- nwfscSurvey::CreateStrataDF.fn(
      names = c("shallow_wa", "shallow_or", "shallow_nca", "shelf_wa", "shelf_or", "shelf_nca"),
      depths.shallow = c(55, 55, 55, 183, 183, 183),
      depths.deep = c(183, 183, 183, 450, 450, 450),
      lats.south = c(46.0, 42.0, 34.5, 46.0, 42.0, 34.5),
      lats.north = c(49.0, 46.0, 42.0, 49.0, 46.0, 42.0)
    )
  }
  if (strata == "strata 34.5-49 250") {
    strata_to_use <- nwfscSurvey::CreateStrataDF.fn(
      names = c("shallow_wa", "shallow_or", "shallow_nca", "shelf_wa", "shelf_or", "shelf_nca"),
      depths.shallow = c(55, 55, 55, 183, 183, 183),
      depths.deep = c(183, 183, 183, 250, 250, 250),
      lats.south = c(46.0, 42.0, 34.5, 46.0, 42.0, 34.5),
      lats.north = c(49.0, 46.0, 42.0, 49.0, 46.0, 42.0)
    )
  }
  if (strata == "strata 32.5-46 400") {
    strata_to_use <- nwfscSurvey::CreateStrataDF.fn(
      names = c("shallow_or", "shallow_nca", "shallow_sca", "shelf_or", "shelf_nca", "shelf_sca"),
      depths.shallow = c(55, 55, 55, 183, 183, 183),
      depths.deep = c(183, 183, 183, 400, 400, 400),
      lats.south = c(42.0, 34.5, 32.0, 42.0, 34.5, 32.0),
      lats.north = c(46.0, 42.0, 34.5, 46.0, 42.0, 34.5)
    )
  }

  return(strata_to_use)
}
