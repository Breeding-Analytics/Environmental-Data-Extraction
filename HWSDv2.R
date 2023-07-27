#' Set of helper functions to query and retrieve soil attributes from HWSD v2
#' 
#' Harmonized World Soils Database version 2.0 (HWSD v2.0)
#' https://gaez.fao.org/pages/hwsd
#' 
#' For more details, you can get the HWSD v2.0 technical report and instructions
#' https://doi.org/10.4060/cc3823en

#' install and load the required R packages
if (!require(sf)) install.packages('sf'); library(sf)
if (!require(terra)) install.packages('terra'); library(terra)
if (!require(RSQLite)) install.packages('RSQLite'); library(RSQLite)

#' set file download timeout to 300 seconds (5 minutes)
options(timeout = 300)

#' initiate function that download and setup required data files in a given path
ini_HWSD2 <- function(data_path = './data/'){
  con <- list()
  
  hwsd2_raster <- paste0(data_path, 'hwsd2.bil')
  hwsd2_sqlite <- paste0(data_path, 'HWSD2.sqlite')
  
  #' create the destination directory if it is not exists yet
  if (!dir.exists(data_path)) {
    dir.create(data_path)
  }
  
  if (!file.exists(hwsd2_raster)) {
    #' import the HWSD v2 raster soil unit map (download then unzip, 4 files, 1.74 GB)
    #' https://s3.eu-west-1.amazonaws.com/data.gaezdev.aws.fao.org/HWSD/HWSD2_RASTER.zip

    hwsd2_raster_url <- 'https://s3.eu-west-1.amazonaws.com/data.gaezdev.aws.fao.org/HWSD/HWSD2_RASTER.zip'
    hwsd2_raster_zip <- paste0(data_path, 'HWSD2_RASTER.zip')
    
    #' download the raster file
    utils::download.file(hwsd2_raster_url, hwsd2_raster_zip)
    
    #' unzip the raster file in the given directory
    utils::unzip(hwsd2_raster_zip, exdir = data_path)
  }
  
  if (!file.exists(hwsd2_sqlite)) {
    #' load the SQLite version of the soil attribute database
    #' https://www.isric.org/sites/default/files/HWSD2.sqlite
    
    hwsd2_sqlite_url <- 'https://www.isric.org/sites/default/files/HWSD2.sqlite'
    
    #' download the SQLite version of the HWSD v2 database
    utils::download.file(hwsd2_sqlite_url, hwsd2_sqlite, method = 'libcurl', mode = 'wb')
  }
  
  con$raster <- terra::rast(hwsd2_raster)
  con$sqlite <- DBI::dbConnect(DBI::dbDriver('SQLite'), dbname = hwsd2_sqlite)
  
  return(con)
}

#' The HWSD2_SMU table contains general information for each of the soil units 
#' occurring in any given SMU code (dominant soil unit and up to 11 associated soils).
#' 
#' The SEQUENCE column refers to the sequence in which soil units within the SMU 
#' are presented (in order of percentage share). The dominant soil has sequence 1. 
#' The sequence can range between 1 and 12.
#' 
#' The SHARE column refers to the share of the soil unit within the mapping unit in 
#' percentage. Shares of soil units within a mapping unit always sum up to 100 percent.
#' 
#' The HWSD2_LAYERS table provides soil attributes per depth layer for each of the 
#' seven depth layers (D1 to D7) separately (represented in the LAYER column in the 
#' HWSD2_LAYERS table). The depth of the top and bottom of each layer is defined in
#' the TOPDEP and BOTDEP columns, respectively. 

get_HWSD2 <- function(df, con, x = 'longitude', y = 'latitude', sequence = 1, layer = 'D1') {
  total_loc <- nrow(df)
  
  df$seq_id <- 1:total_loc
  df$smu_id <- NULL
  
  #' setup the progress bar
  pb <- utils::txtProgressBar(min = 0, max = total_loc, initial = 0, style = 3) 
  
  for(i in 1:total_loc) {
    longitude <- df[i, x]
    latitude  <- df[i, y]
    
    #' crop the raster for the given coordinates using the raster resolution unit as the bounding box dimensions
    hwsd_loc <- terra::crop(con$raster, ext(c(longitude, longitude + res(con$raster)[1], latitude, latitude + res(con$raster)[2]))) 
    
    #' extract the raster pixel code (Soil Mapping Unit ID)
    df[i, 'smu_id'] <- hwsd_loc[1]
    
    #' update progress bar every 5%
    if(i %% ceiling(total_loc/20) == 0) utils::setTxtProgressBar(pb,i)
  }
  
  #' set the progress bar at 100% and close it
  utils::setTxtProgressBar(pb, i)
  close(pb)
  
  #' get a list of unique smu ids 
  ids <- paste(unique(na.omit(df$smu_id)), collapse = ',')

  #' build up SQL statement conditions
  SEQ <- ifelse(sequence %in% 1:12, paste('SEQUENCE = ', sequence), 'SEQUENCE > 0')
  LYR <- ifelse(layer %in% paste0('D', 1:7), paste0('LAYER = "', layer, '"'), 'LAYER like "%"')
  
  #' retrieve soil data for the selected soil component and depth layer
  hwds2_layers <- DBI::dbGetQuery(con$sqlite, paste('select * from HWSD2_LAYERS where', SEQ, 'and', LYR, 'and HWSD2_SMU_ID in (', ids, ')'))
  
  #' associate soil attribution columns to the original sites data frame
  df <- merge(df, hwds2_layers, by.x = 'smu_id', by.y = 'HWSD2_SMU_ID', sort = FALSE)
  
  #' sort records by soil component share and then layer depth
  df <- df[with(df, order(seq_id, SEQUENCE, LAYER)), ]
  
  return(df)
}
