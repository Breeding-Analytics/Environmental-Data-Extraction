# Environmental Data Extraction
## Climate Databases
* __TerraClimate via QBMS R package:__ <br/>
[TerraClimate](https://www.climatologylab.org/terraclimate.html) is a climate and climatic water balance dataset of [14 variables](https://www.climatologylab.org/terraclimate-variables.html) for global terrestrial surfaces from 1958 to 2022 (updated annually) comparing to 7 climate variables for 1970-2000 in [WorldClim dataset](https://www.worldclim.org/data/worldclim21.html). All data have monthly temporal resolution and a ~4-km (1/24th degree) spatial resolution.<br/><br/>
You can retrieve TerraClimate data using the QBMS R package in two modes: [Online](https://icarda-git.github.io/QBMS/articles/terraclimate_example.html) using API calls (minimizing download size) or [Offline](qbms_offline_terraclimate.R) by downloading required NetCDF rasters first (minimizing query time). QBMS will also calculate 19 derivatives [bioclimatic variables](https://www.worldclim.org/data/bioclim.html) on-fly.

>__Reference:__ Abatzoglou, J., Dobrowski, S., Parks, S. et al. _TerraClimate, a high-resolution global dataset of monthly climate and climatic water balance from 1958–2015_. Sci Data 5, 170191 (2018). [https://doi.org/10.1038/sdata.2017.191](https://doi.org/10.1038/sdata.2017.191)

* __ECMWF Reanalysis v5 (ERA5):__ (to-do)<br/>
ERA5 is the fifth generation ECMWF atmospheric reanalysis of the global climate covering the period from January 1940 to the present. ERA5 is produced by the Copernicus Climate Change Service (C3S) at ECMWF.

## Soil Databases
* __Harmonized World Soil Database version 2.0:__ <br/>
The [HWSD v2.0](https://gaez.fao.org/pages/hwsd) is a unique global soil inventory providing information on the morphological, chemical, and physical properties of soils at approximately 1 km resolution. Its main objective is to serve as a basis for prospective studies on agro-ecological zoning, food security, and climate change.<br/><br/>
In [this example](HWSDv2_example.R), you can use this [R script](HWSDv2.R) to get the required helper functions to set up and query soil attributes from the HWSD v2 dataset for a given list of sites/locations.

> __Reference:__ FAO & IIASA. 2023. _Harmonized World Soil Database version 2.0_. Rome and Laxenburg. [https://doi.org/10.4060/cc3823en](https://doi.org/10.4060/cc3823en). 

## Tools
* __[EnvRtype: Envirotyping Tools in R](https://github.com/allogamous/EnvRtype):__ <br/>
An R Interplay between Quantitative Genetics and Ecophysiology for GxE Analysis.

> __Reference:__ Germano Costa-Neto and others, _EnvRtype: a software to interplay enviromics and quantitative genomics in agriculture, G3 Genes|Genomes|Genetics_, Volume 11, Issue 4, April 2021, jkab040, [https://doi.org/10.1093/g3journal/jkab040](https://doi.org/10.1093/g3journal/jkab040)

* __Framework to Check & Validate Coordinates Data Type:__ (coming soon)
