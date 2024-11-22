# gfsynopsis-noaa
Repo for extending the gfsynopsis report idea from DFO to Bering Sea / Gulf of Alaska / West Coast of USA

## Installation

You can install {gfsynopsis-noaa} from [GitHub](https://github.com/) with

``` r
# install.packages("pak")
pak::pkg_install("DFO-NOAA-Pacfin/gfsynopsis-noaa")
```

## Workflow

### File structure


```bash
├───.github
│   └───workflows
├───data
├───data-raw
├───doc
│   └───dashboard
├───man
├───R

```

Where

- data is processed data included in the package via .R scripts in the data-raw 
folder;
- data-raw is for .R scripts used to transform the raw data from each Science 
Center into a unified data frame that is saved in data;
- doc
  - dashboard contains files for the website;
- man stores .Rd files; and
- R stores .R scripts that are loaded when building the package, this
  means functions only

## Disclaimer

This repository is a scientific product and is not official
communication of the National Oceanic and Atmospheric Administration or
the United States Department of Commerce. All NOAA GitHub project code
is provided on an ‘as is’ basis, and the user assumes responsibility for
its use. Any claims against the Department of Commerce or Department of
Commerce bureaus stemming from the use of this GitHub project will be
governed by all applicable Federal laws. Any reference to specific
commercial products, processes, or services by service mark, trademark,
manufacturer, or otherwise does not constitute or imply their
endorsement, recommendation, or favoring by the Department of Commerce.
The Department of Commerce seal and logo, or the seal and logo of a DOC
bureau, shall not be used in any manner to imply endorsement of any
commercial product or activity by DOC or the United States Government.
