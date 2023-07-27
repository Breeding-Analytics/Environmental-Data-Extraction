#' Install the development version of QBMS directly from GitHub as this feature
#' still not available in the latest CRAN released version
remotes::install_github("icarda-git/QBMS")
library(QBMS)

#' Download TerraClimate netCDF data files to extract their data offline
#' ?ini_terraclimate
ini_terraclimate('2018-09-01', '2019-06-30', c('ppt', 'tmin', 'tmax'))

#' List the coordinates for 3 locations (x for longitudes and y for latitudes)
x <- c(-6.716, 35.917, 76.884)
y <- c(33.616, 33.833, 23.111)

#' Get TerraClimate data for a given coordinate(s)
#' ?get_terraclimate
data <- get_terraclimate(y, x, '2018-09-01', '2019-06-30', c('ppt', 'tmin', 'tmax'), offline = TRUE)

#' Show the 14 TerraClimate variables for the 1st location
data$climate[[1]]

#' Show the 19 derivatives bioclimatic variables for the 2nd location
data$biovars[[2]]

