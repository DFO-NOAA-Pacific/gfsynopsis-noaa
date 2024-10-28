#' Plot design-based indices
#'
#' @param data Dataframe of design-based indices.
#' @param dir  Directory where output will be saved. The directory where the file should be saved.
#' If dir = NULL no output will be saved.
#' @param plot A vector of integers to specify which plots you would like. The
#'   default is to print or save both figures, i.e., `plot = 1:2`. Integers
#'   correspond to the following figures:
#'   1. Design based index by year and region.
#'   2. Standardized design based index by year and region.
#' @param height,width Numeric values for the figure width and height in
#'   inches. The defaults are 7 by 7 inches.
#'
#' @author Chantel Wetzel
#' @import ggplot2
#' @import dplyr
#' @import cli
#' @export
#'
plot_design_based <- function(
    data,
    dir = NULL,
    plot = 1,
    height = 7,
    width = 7) {
  if (length(plot) == 2) {
    cli::cli_inform("Two separate function calls are required to
                    return each plot type.")
  }

  sp <- unique(data[, "common_name"])
  igroup <- 1
  if (igroup %in% plot) {
    p1 <- ggplot2::ggplot(data = data) +
      ggplot2::geom_ribbon(ggplot2::aes(x = year, ymin = lwr, ymax = upr), fill = "lightgray") +
      ggplot2::geom_line(ggplot2::aes(x = year, y = est)) +
      ggplot2::geom_point(ggplot2::aes(x = year, y = est)) +
      ggplot2::ylab("Biomass (mt)") +
      ggplot2::xlab("Year") +
      ggplot2::theme_bw() +
      ggplot2::scale_y_continuous(
        labels = function(x) format(x, big.mark = ",", scientific = FALSE)
      ) +
      # ggplot2::ggtitle(sp) +
      ggplot2::facet_wrap("region", scales = "free_y")
  }

  data <- data |>
    dplyr::group_by(region) |>
    dplyr::mutate(
      est_stand = est / mean(est)
    )

  igroup <- 2
  if (igroup %in% plot) {
    p2 <- ggplot2::ggplot(data = data) +
      ggplot2::geom_line(ggplot2::aes(x = year, y = est_stand, color = region)) +
      ggplot2::geom_point(ggplot2::aes(x = year, y = est_stand, color = region)) +
      ggplot2::geom_hline(yintercept = 1, linetype = "dashed", color = "lightgrey") +
      ggplot2::ylab("Standardized Index") +
      ggplot2::xlab("Year") +
      ggplot2::theme_bw() +
      # ggplot2::ggtitle(sp) +
      ggplot2::scale_color_viridis_d()
    p2$labels$colour <- "Region"
  }

  if (!is.null(dir)) {
    if (1 %in% plot) {
      ggplot2::ggsave(
        plot = p1,
        filename = file.path(dir, paste0(sp, "-design-based-index.png")),
        height = height,
        width = width
      )
    }
    if (2 %in% plot) {
      ggplot2::ggsave(
        plot = p2,
        filename = file.path(dir, paste0(sp, "-design-based-index-standardized.png")),
        height = height,
        width = width
      )
    }
  }
  if (is.null(dir)) {
    if (1 %in% plot) {
      return(p1)
    }
    if (2 %in% plot) {
      return(p2)
    }
  }
}
