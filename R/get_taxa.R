#' Pull taxa information for AFSC data
#'
#' @param spp_list A list of species common_names.
#'
#' @author Chantel Wetzel
#' @import akfingapdata
#' @import dplyr
#' @export
#'
get_taxa <- function(spp_list) {
  akfingapdata::get_gap_taxonomic_classification() |>
    dplyr::filter(tolower(common_name) %in% tolower(spp_list))
}
