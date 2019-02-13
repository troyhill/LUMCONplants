#' plot-level data: soil and water nutrients and physical parameters
#' @format A dataframe the following variables:
#' \describe{
#' \item{year}{year of sample collection}
#' \item{month.name}{month of sample collection (3-character form)}
#' \item{month.number}{month of sample collection (numeric)}
#' \item{region}{region}
#' \item{site}{name of sampling marsh}
#' \item{lat}{latitude, decimal degrees}
#' \item{long}{longitude, decimal degrees}
#' \item{dist}{distance from marsh edge, meters}
#' \item{plot}{plot name (A, B, C)}
#' \item{temp.soil}{soil temperature in degrees C}
#' \item{ph.soil}{soil pH in pH units}
#' \item{bulk.density.g.cm3.soil}{soil bulk density in grams per cubic centimeter}
#' \item{grav.water.content.soil}{soil water content. Units = grams/gram dry mass}
#' \item{om.soil}{organic matter content of soil collected in top 5 cm, measured by loss on ignition. Units = grams/gram}
#' \item{c.soil}{organic carbon content of soil collected in top 5 cm and fumigated with HCl. Units = grams/gram}
#' \item{tn.soil}{total nitrogen content of soil collected in top 5 cm and fumigated with HCl. Units = grams/gram}
#' \item{tp.ppm.soil}{total phosphorous content of soil collected in top 5 cm and fumigated with HCl. Units = milligrams/gram}
#' \item{extractable.no3.mmol.gdw.soil}{extractable NO3+NO2 in soil. Units = millimol N per gram dry mass}
#' \item{extractable.nh4.mmol.gdw.soil}{extractable NH4 in soil. Units = millimol N per gram dry mass}
#' \item{extractable.po4.mmol.gdw.soil}{extractable PO4 in soil. Units = millimol P per gram dry mass}
#' \item{porewater.salinity.soil}{porewater salinity. Units = psu}
#' \item{redox.soil}{soil redox. Units = milliVolts}
#' \item{water.temp.bay}{temperature of bay water adjacent to site. Units = degrees C}
#' \item{salinity.psu.bay}{salinity of bay water adjacent to site. Units = psu}
#' \item{sp.cond.bay}{specific conductivity of  bay water adjacent to site. Units = mS/cm}
#' \item{dissolved.no3.no2.bay}{dissolved NO3+NO2 in bay water adjacent to site. Units = millimoles N/L}
#' \item{dissolved.nh4.bay}{dissolved NH4 in bay water adjacent to site. Units = millimoles N/L}
#' \item{dissolved.po4.bay}{dissolved PO4 in bay water adjacent to site. Units = millimoles P/L}
#' \item{dissolved.sio2.bay}{dissolved SiO2 in bay water adjacent to site. Units = millimoles Si/L}
#' \item{water.depth.cm.}{depth of overlying water at marsh sampling location. Units = centimeters}
#' \item{water.temp}{temperature of overlying water at marsh sampling location. Units = degrees Celsius}
#' \item{salinity.psu.}{salinity of overlying water at marsh sampling location. Units = psu}
#' \item{sp.cond}{specific conductivity of overlying water at marsh sampling location. Units = mS/cm}
#' \item{dissolved.no3.no2}{dissolved NO3+NO2 in overlying water at marsh sampling location. Units = millimoles N/L}
#' \item{dissolved.nh4}{dissolved NH4 in overlying water at marsh sampling location. Units = millimoles N/L}
#' \item{dissolved.po4}{dissolved PO4 in overlying water at marsh sampling location. Units = millimoles P/L}
#' \item{dissolved.sio2}{dissolved SiO2 in overlying water at marsh sampling location. Units = millimoles Si/L}
#' }
#' @docType data
#' @keywords datasets
#' @name nutDat
NULL

### Code used to produce dataset:
# # merge with soil and water quality params to create dataset 12 -----------
# regionLabel <- function(data, siteCol = "site") {
#   # function takes a dataset and the name of the column with site names (e.g., "LUM1"), and 
#   # adds a column with marsh names ("LUM", "TB-A", "TB-B")
#   data$region <- as.character(NA)
#   for (i in 1:nrow(data)) {
#     if (data[i, siteCol] %in% paste0("LUM", 1:3)) {
#       data$region[i] <- "LUMCON"
#     } else if (data[i, siteCol] %in% c("TB1", "TB2")) {
#       data$region[i] <- "Bay LaFleur"
#     } else if (data[i, siteCol] %in% c("TB3", "TB4")) {
#       data$region[i] <- "Lake Barre"
#     }
#   }
#   data
# }
# 
# ### This data is in C:\Users\tdh\Documents\LUMCON\Allometry\GRIIDC\dataset12_all_years_20190110.xlsx
# ### It will continue to be updated
# 
# nutDat <- read.delim("C:/RDATA/LUMCON/allometry_preprocessing/plot_data/data_soil_water_all_years_20190213.txt", skip = 2, stringsAsFactors = FALSE)
# names(nutDat) <- tolower(names(nutDat))
# nutDat$site   <- gsub(x = trimws(nutDat$site), pattern = " ", replacement = "")
# nutDat$plot   <- gsub(x = trimws(nutDat$plot), pattern = " |[1-9]", replacement = "")
# 
# ### add lat/long/dist
# for(i in 1:length(unique(nutDat$site))) { 
#   nutDat$lat[nutDat$site %in% unique(nutDat$site)[i]]  <- unique(stemDat$lat[stemDat$site %in% unique(nutDat$site)[i]])[1]
#   nutDat$long[nutDat$site %in% unique(nutDat$site)[i]] <- unique(stemDat$long[stemDat$site %in% unique(nutDat$site)[i]])[1]
#   nutDat$dist[nutDat$site %in% unique(nutDat$site)[i]] <- unique(stemDat$dist[stemDat$site %in% unique(nutDat$site)[i]])[1]
# }
# 
# ### add region names
# nutDat <- regionName(nutDat)
# firstCols <- c("year", "month.name", "month.number", "region", "site", "lat", "long", "dist",  "plot")
# nutDat <- subset(nutDat, select = c(firstCols,
#                                     names(nutDat)[!names(nutDat) %in% firstCols]) )
# 
# # usethis::use_data(nutDat, overwrite = TRUE)
# # write.csv(nutDat, file = "C:/RDATA/LUMCON/allometry_preprocessing/plot_data/plotDataProcessed.csv", row.names = FALSE)
