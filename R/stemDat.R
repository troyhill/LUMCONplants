#' Stem-level dataset with plant heights and masses
#' @format A dataframe with the following columns:
#' \describe{
#' \item{yr}{year of sample collection}
#' \item{mo}{month of sample collection (3-character form)}
#' \item{mo2}{month of sample collection (numeric)}
#' \item{region}{region}
#' \item{site}{name of sampling marsh}
#' \item{lat}{latitude, decimal degrees}
#' \item{long}{longitude, decimal degrees}
#' \item{dist}{distance from marsh edge, meters}
#' \item{id}{unique identifier for individually-weighed stems}
#' \item{status}{live/dead status of plant}
#' \item{hgt}{height from plant base to longest outstretched point. Units = centimeters}
#' \item{mass_tot}{total mass of plant. Units = grams}
#' \item{mass_s}{stem mass. Units = grams}
#' \item{mass_l}{leaf mass. Units = grams}
#' \item{flwr}{dummy variable indicating flowering status (1 = inflorescence/infructescence present). Inconsistently censused.}
#' \item{flwr_len}{length of inflorescence/infructescence. Units = centimeters}
#' \item{flwr_mass}{mass of inflorescence/infructescence. Units = grams}
#' \item{moYr}{month-year of sampling (form = "\%b-\%Y")}
#' \item{time}{month-year of sampling as yearmon data type}
#' \item{season}{season-year of sampling}
#' \item{seas}{season of sampling}
#' \item{plantYr}{year of sampling (modifed so as not to split the winter between calendar years)}
#' \item{mass.est1}{plant mass estimated from allometry. Units = grams}
#' \item{mass.est2}{plant mass estimated from allometry. Units = grams}
#' \item{modeled}{dummy variable indicating whether final plant mass is directly measured (= 0) or estimated from allometry model (= 1)}
#' \item{mass}{best estimate of plant mass; directly measured, when available. Otherwise, estimated from allometry models. Units = grams}
#' }
#' @docType data
#' @keywords datasets
#' @name stemDat
NULL


# stemDat <- read.csv("C:/RDATA/LUMCON/allometry_preprocessing/stem_data/stemData_2013_2018.csv", stringsAsFactors = FALSE)
# devtools::use_data(stemDat)
# save(list = "stemDat", file = "data/stemDat.RData")
