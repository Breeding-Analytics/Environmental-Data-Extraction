# Environmental Data Extraction
## Climate Databases
* __TerraClimate via QBMS R package:__ <br/>
[TerraClimate](https://www.climatologylab.org/terraclimate.html) is a climate and climatic water balance dataset of [14 variables](https://www.climatologylab.org/terraclimate-variables.html) for global terrestrial surfaces from 1958 to 2022 (updated annually) comparing to 7 climate variables for 1970-2000 in [WorldClim dataset](https://www.worldclim.org/data/worldclim21.html). All data have monthly temporal resolution and a ~4-km (1/24th degree) spatial resolution.<br/><br/>
You can retrieve TerraClimate data using the QBMS R package in two modes: [Online](https://icarda-git.github.io/QBMS/articles/terraclimate_example.html) using API calls (minimizing download size) or [Offline]() by downloading required NetCDF rasters first (minimizing query time). QBMS will also calculate 19 derivatives [bioclimatic variables](https://www.worldclim.org/data/bioclim.html) on-fly.

>__Reference:__ Abatzoglou, J., Dobrowski, S., Parks, S. et al. _TerraClimate, a high-resolution global dataset of monthly climate and climatic water balance from 1958–2015_. Sci Data 5, 170191 (2018). [https://doi.org/10.1038/sdata.2017.191](https://doi.org/10.1038/sdata.2017.191)

* __ECMWF Reanalysis v5 (ERA5):__ (to-do)<br/>
ERA5 is the fifth generation ECMWF atmospheric reanalysis of the global climate covering the period from January 1940 to the present. ERA5 is produced by the Copernicus Climate Change Service (C3S) at ECMWF.

## Soil Databases

## Tools
* __[EnvRtype: Envirotyping Tools in R](https://github.com/allogamous/EnvRtype):__ <br/>
A R Interplay between Quantitative Genetics and Ecophysiology for GxE Analysis.

> Reference: Germano Costa-Neto and others, _EnvRtype: a software to interplay enviromics and quantitative genomics in agriculture, G3 Genes|Genomes|Genetics_, Volume 11, Issue 4, April 2021, jkab040, [https://doi.org/10.1093/g3journal/jkab040](https://doi.org/10.1093/g3journal/jkab040)

* __Framework to Check & Validate Coordinates Data Type:__ (coming soon)
