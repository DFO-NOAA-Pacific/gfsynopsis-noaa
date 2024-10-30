#' Plot length-weight and length-at-age
#'
#' @param data Dataframe of specimens data filtered down to an unique species.
#' @param parameters List of biological parameter estimates.
#' @param dir  Directory where output will be saved. The directory where the file should be saved.
#' If dir = NULL no output will be saved.
#' @param plot A vector of integers to specify which plots you would like. The
#'   default is to print or save both figures, i.e., `plot = 1:2`. Integers
#'   correspond to the following figures:
#'   1. Length-weight.
#'   2. Length-at-age.
#' @param height,width Numeric values for the figure width and height in
#'   inches. The defaults are 7 by 7 inches.
#'
#' @author Chantel Wetzel
#' @import ggplot2
#' @import dplyr
#' @import cli
#' @export
#'
plot_biology <- function(
    data,
    parameters,
    dir = NULL,
    plot = 1:2,
    height = 7,
    width = 7) {
  if (length(plot) == 2) {
    cli::cli_inform("Two separate function calls are required to
                    return each plot type.")
  }

  colors <- c("#414487FF", "#22A884FF")
  sp <- unique(data[, "common_name"])

  igroup <- 1
  if (igroup %in% plot) {
    para <- parameters[["mass_length"]]
    para <- para[para$common_name == sp, ]

    data_to_plot <- data |>
      dplyr::filter(
        sex != "Unsexed",
        !is.na(mass_kg),
        mass_kg > 0,
        !is.na(length_cm),
        length_cm > 0
      )

    xlims <- c(0, ceiling(max(data_to_plot[, "length_cm"])))
    ylims <- c(0, max(data_to_plot[, "mass_kg"]))
    para$lmin <- 0
    para$lmax <- xlims[2]

    lines_to_plot <- para |>
      dplyr::filter(sex != "All") |>
      dplyr::group_by(region, sex) |>
      dplyr::reframe(
        length_cm = seq(lmin, lmax, 1),
        mass_kg = A * length_cm^B,
        a = A,
        b = B
      )
    label <- lines_to_plot |>
      dplyr::filter(sex != "All") |>
      dplyr::mutate(
        max_y = quantile(mass_kg, 0.95),
        multiplier = ifelse(sex == "Female", 1, 0.9)
      ) |>
      dplyr::group_by(region, sex) |>
      dplyr::summarize(
        label = paste0("a = ", format(unique(a), digits = 3, scientific = TRUE), "; ", paste0("b = ", round(unique(b), 2))),
        x = quantile(length_cm, 0.30),
        y = unique(max_y) * unique(multiplier)
      )

    p1 <- ggplot2::ggplot(data_to_plot) +
      ggplot2::geom_point(aes(x = length_cm, y = mass_kg, color = sex), alpha = 0.15, size = 1) +
      ggplot2::ylab("Mass (kg)") +
      ggplot2::xlab("Length (cm)") +
      ggplot2::geom_line(
        data = lines_to_plot,
        ggplot2::aes(x = length_cm, y = mass_kg, color = sex), linewidth = 1.5
      ) +
      ggplot2::geom_text(data = label, ggplot2::aes(x = x, y = y, label = label, color = sex)) +
      ggplot2::xlim(xlims[1], xlims[2]) +
      ggplot2::ylim(ylims[1], ylims[2]) +
      ggplot2::theme_bw() +
      #ggplot2::ggtitle(sp) +
      ggplot2::scale_color_manual(name = "Sex", values = colors) +
      ggplot2::scale_fill_manual(name = "Sex", values = colors) +
      ggplot2::guides(color = guide_legend(override.aes = list(alpha = 1))) +
      ggplot2::facet_grid(region ~ .)

    if (!is.null(dir)) {
      ggplot2::ggsave(
        plot = p1,
        filename = file.path(dir, paste0(sp, "-mass-length.png")),
        height = height,
        width = width
      )
    } else {
      return(p1)
    }
  }

  igroup <- 2
  if (igroup %in% plot) {
    para <- parameters[["growth"]]
    para <- para[para$common_name == sp, ]

    data_to_plot <- data |>
      dplyr::filter(
        sex != "Unsexed",
        !is.na(age),
        age > 0,
        !is.na(length_cm),
        length_cm > 0
      )

    xlims <- c(0, ceiling(max(data_to_plot[, "age"])))
    ylims <- c(0, max(data_to_plot[, "length_cm"]))
    para$amin <- 0
    para$amax <- xlims[2]

    lines_to_plot <- para |>
      dplyr::group_by(region, sex) |>
      dplyr::reframe(
        k = k,
        Linf = Linf,
        L0 = L0,
        age = seq(amin, amax, 1),
        length_cm = Linf + (L0 - Linf) * exp(-k * age)
      )
    label <- lines_to_plot |>
      dplyr::mutate(
        max_x = quantile(age, 0.60),
        multiplier = ifelse(sex == "Female", 0.2, 0.1)
      ) |>
      dplyr::group_by(region, sex) |>
      dplyr::summarize(
        label = paste0(
          "k = ", round(unique(k), 2), "; ",
          paste0("Lmin = ", round(unique(L0), 1)), "; ",
          paste0("Linf = ", round(unique(Linf), 1))
        ),
        x = unique(max_x),
        y = unique(max(length_cm)) * unique(multiplier)
      )

    p2 <- ggplot2::ggplot(data_to_plot) +
      ggplot2::geom_point(aes(x = age, y = length_cm, color = sex), alpha = 0.15, size = 1) +
      ggplot2::xlab("Age (yrs)") +
      ggplot2::ylab("Length (cm)") +
      ggplot2::geom_line(
        data = lines_to_plot,
        ggplot2::aes(x = age, y = length_cm, color = sex), linewidth = 1.5
      ) +
      ggplot2::geom_text(data = label, ggplot2::aes(x = x, y = y, label = label, color = sex)) +
      ggplot2::xlim(xlims[1], xlims[2]) +
      ggplot2::ylim(ylims[1], ylims[2]) +
      ggplot2::theme_bw() +
      #ggplot2::ggtitle(sp) +
      ggplot2::scale_color_manual(name = "Sex", values = colors) +
      ggplot2::scale_fill_manual(name = "Sex", values = colors) +
      ggplot2::guides(color = guide_legend(override.aes = list(alpha = 1))) +
      ggplot2::facet_grid(region ~ .)

    if (!is.null(dir)) {
      ggplot2::ggsave(
        plot = p2,
        filename = file.path(dir, paste0(sp, "-length-age.png")),
        height = height,
        width = width
      )
    } else {
      return(p2)
    }
  }
}
