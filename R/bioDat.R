#' plot-level data: above and belowground biomass
#' @format A dataframe
#' @docType data
#' @keywords datasets
#' @name bioDat
NULL

### Code used to produce dataset:
# source("C:/RDATA/LUMCON/allometry_preprocessing/script_stemProc_20190105.R") # produces stemDat
# 
# 
# ### litter data: 2013-2018
# ### sept 2016 litter data may be missing. Not clear whether bag scrap data was not recorded in 2015/2016, or if less bag scraps were found.
# lit1315 <- read.delim("C:/RDATA/SPAL_allometry/data_LUM123/data_litter_151020.txt", stringsAsFactors = FALSE)
# lit <- read.delim("C:/RDATA/LUMCON/allometry_preprocessing/plot_data/data_litter_20190107.txt", skip = 4, stringsAsFactors = FALSE)
# 
# lit <- lit[, 1:9]
# 
# lit1315 <- lit1315[grepl(x = lit1315$Plot, pattern = "m"), c(1,2,4,7)]
# lit1315$X1 <-lit1315$X2 <-  lit1315$X3 <- lit1315$X4 <- lit1315$X5 <- NA 
# names(lit1315) <- names(lit)
# 
# litDat <- rbind(lit, lit1315)
# litDat$site   <- gsub(x = trimws(litDat$site), pattern = " ", replacement = "")
# litDat$plot   <- gsub(x = trimws(litDat$plot), pattern = " |[1-9]", replacement = "")
# for (i in 1:nrow(litDat)) {
#   if (!is.na(as.numeric(substr(litDat$moYr[i], 1, 1)))) {
#     litDat$moYr[i] <- paste0(substr(litDat$moYr[i], 4, 6), "-", substr(litDat$moYr[i], 1, 2))
#   }
# }
# litDat$mo <- substr(litDat$moYr, 1, 3)
# litDat$yr <- as.numeric(substr(litDat$moYr, 5, 6)) + 2000
# 
# litDat <- ddply(litDat, .(yr, mo, site, plot), summarise,
#                 litter = sum(litter, na.rm = TRUE) / plotSize,
#                 liveScraps = sum(liveBiomass, na.rm = TRUE) / plotSize,
#                 deadScraps = sum(deadBiomass, na.rm = TRUE) / plotSize)
# 
# # names(lit)[1:7]    <- c("monthYear", "site", "plot", "quadrat", "plants_tin", "tin", "litterMass")
# # lit$moYr      <- as.character(lit$monthYear)
# # lit$monthYear <- as.yearmon(lit$moYr, "%b-%y")
# # lit$site      <- gsub(" ", "", as.character(lit$site))
# # lit$plot      <- as.character(lit$plot)
# # lit$quadrat   <- substr(gsub(" ", "", as.character(lit$quadrat)), 1, 1)
# # lit <- lit[!lit$site %in% "", ]
# # lit <- lit[!lit$quadrat %in% "", ]
# 
# 
# ### Belowground biomass
# ### should there be August 2016 bg data? some notebook said switch to metal corer was in August 2016...
# bg <- read.delim("C:/RDATA/SPAL_allometry/data_LUM123/data_belowground_170310.txt", skip = 1, stringsAsFactors = FALSE)   # 2013:2015
# bg2 <- read.delim("C:/RDATA/LUMCON/allometry_preprocessing/plot_data/data_bg1718_20190107.txt", stringsAsFactors = FALSE) # 2017:2018
# 
# bg15 <- bg[, c(1, 2, 3, 5, 8, 11, 14)]
# bg18 <- bg2[!(bg2$moYr %in% ""), -c(1, 4, 10)]
# tail(bg18)
# names(bg18) <- names(bg15) <- c("moYr", "site", "plot", "depth", "live.bg", "dead.bg", "tot.bg")
# bg <- rbind(bg15, bg18)
# 
# bg$site   <- gsub(x = trimws(bg$site), pattern = " ", replacement = "")
# bg$depth  <- gsub(x = trimws(bg$depth), pattern = " ", replacement = "")
# bg$midpoint <- as.numeric(substr(bg$depth, nchar(bg$depth) - 3, nchar(bg$depth) - 2)) - 5
# 
# bg$plot   <- gsub(x = trimws(bg$plot), pattern = " ", replacement = "")
# bg$plot[!(bg$plot %in% c("A", "B", "C"))] <- "A"
# bg$monthYear <- as.yearmon(bg$moYr, "%b-%y")
# bg$mo        <- substr(as.character(bg$moYr), 1, 3)
# bg$yr        <- as.numeric(substr(as.character(bg$moYr), 5, 8)) + 2000
# bg$coreArea  <- coreTube
# bg$coreArea[bg$monthYear > "July 2016"] <- coreTube_metal
# # # remove suspicious LUM2 samples from Jan 2014
# # bg[(bg$site %in% "LUM2") & (bg$monthYear == "Jan 2014"), ]
# 
# ####
# bg.int <- bg
# bg.int[, 5:7] <- bg[, 5:7] / bg$coreArea * 10^4 # g per m2
# names(bg.int)[5:7] <- paste0(names(bg.int[, 5:7]), ".gm2")
# ###
# 
# head(bg.int)
# # bg$dist <- "20m"
# # bg$dist[bg$site %in% "LUM3"] <- "10m"
# bg.merge <- ddply(bg.int, .(yr, mo, site, plot), summarise, 
#                   live.bg.gm2 = sum(live.bg.gm2, na.rm = TRUE),
#                   dead.bg.gm2 = sum(dead.bg.gm2, na.rm = TRUE), 
#                   tot.bg.gm2  = sum(tot.bg.gm2, na.rm = TRUE)
# )
# # convert zeroes to NAs where appropriate
# bg.merge$live.bg.gm2[bg.merge$live.bg.gm2 == 0] <- NA
# bg.merge$dead.bg.gm2[bg.merge$dead.bg.gm2 == 0] <- NA
# bg.merge$tot.bg.gm2[bg.merge$tot.bg.gm2 == 0]   <- NA
# head(bg.merge)
# 
# ### now merge above and belowground data
# abovegd.live <- ddply(stemDat[stemDat$status %in% "LIVE", ], .(yr, mo, mo2, region, site, plot), summarise,
#                       mass         =  sum(mass, na.rm = TRUE) / plotSize,
#                       stems        =  length(hgt) / plotSize,
#                       lngth.median =  median(hgt, na.rm = T),
#                       lngth.range  =  diff(range(hgt, na.rm = T)))
# 
# abovegd.dead <- ddply(stemDat[stemDat$status %in% "DEAD", ], .(yr, mo, mo2, region, site, plot), summarise,
#                       mass.dead         =  sum(mass, na.rm = TRUE) / plotSize,
#                       stems.dead        =  length(hgt) / plotSize,
#                       lngth.median.dead =  median(hgt, na.rm = T),
#                       lngth.range.dead  =  diff(range(hgt, na.rm = T)))
# 
# biomass <- join_all(list(abovegd.live, abovegd.dead, bg.merge, litDat))
# head(biomass)
# 
# ### add in bag scraps to aboveground live and dead
# biomass$mass <- rowSums(biomass[, c("mass", "liveScraps")], na.rm = TRUE)
# biomass$mass.dead <- rowSums(biomass[, c("mass.dead", "deadScraps")], na.rm = TRUE)
# 
# ### change NAs to zeros in mass and stem density columns
# biomass$mass[is.na(biomass$mass)]             <- 0
# biomass$mass.dead[is.na(biomass$mass.dead)]   <- 0
# biomass$stems[is.na(biomass$stems)]           <- 0
# biomass$stems.dead[is.na(biomass$stems.dead)] <- 0
# 
# 
# ### apply lat, long, and distance from creek
# for(i in 1:length(unique(biomass$site))) {
#   biomass$lat[biomass$site %in% unique(biomass$site)[i]]  <- unique(stemDat$lat[stemDat$site %in% unique(biomass$site)[i]])[1]
#   biomass$long[biomass$site %in% unique(biomass$site)[i]] <- unique(stemDat$long[stemDat$site %in% unique(biomass$site)[i]])[1]
#   biomass$dist[biomass$site %in% unique(biomass$site)[i]] <- unique(stemDat$dist[stemDat$site %in% unique(biomass$site)[i]])[1]
# }
# 
# biomass <- biomass[order(biomass[, "yr"], biomass[, "mo2"], biomass[, "region"], biomass[, "site"], biomass[, "plot"]), ]
# rownames(biomass) <- 1:nrow(biomass)
# bioDat <- subset(biomass, select=c(1:5, 21:23, 8:9, 7, 12:13, 11, 18, 15, 16, 17))
# names(bioDat)
# 
# # usethis::use_data(bioDat, overwrite = TRUE)
