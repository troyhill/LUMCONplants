#' plot-level data: soil and water nutrients and physical parameters
#' @format A dataframe
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
# nutDat <- read.delim("C:/RDATA/LUMCON/allometry_preprocessing/plot_data/data_soil_water_all_years_20190109.txt", skip = 2, stringsAsFactors = FALSE)
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
