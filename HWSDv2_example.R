#' load the helper functions to access and query the HWSD v2 dataset
source('./HWSDv2.R')

#' initiate, download, and setup the HWSD v2 in a given local directory
hwsd2 <- ini_HWSD2(data_path = './data/')

#' create a simple data.frame for a list of locations and their coordinates
Location  <- c('Tel-Hadya', 'Terbol', 'Marchouch')
Latitude  <- c(36.016, 33.808, 33.616)
Longitude <- c(36.943, 35.991, -6.716)

sites <- data.frame(Location, Latitude, Longitude)

#' query soil attributes for given sites using the HWSD v2 connection object 
sites <- get_HWSD2(df = sites, con = hwsd2, x = 'Longitude', y = 'Latitude')

#' check the HWSD v2 raster 
print(hwsd2$raster)

#' display the metadata for the layers table
dbGetQuery(hwsd2$sqlite, 'select * from HWSD2_LAYERS_METADATA')

#' the lookup tables are shown for the coded fields
#' for example, the USDA Texture Class codes (the column TEXTURE_USDA value)
#' are linked to their names in table D_TEXTURE_USDA
dbGetQuery(hwsd2$sqlite, 'select * from D_TEXTURE_USDA')

#' disconnect (close) the SQLite connection
dbDisconnect(hwsd2$sqlite)
