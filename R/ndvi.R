#' plot-level data: normalized difference vegetation index
#' @format A dataframe the following variables:
#' \describe{
#' \item{yr}{}
#' \item{site}{}
#' \item{mo}{}
#' \item{avg.ndvi}{}
#' \item{sd.ndvi}{}
#' }
#' @docType data
#' @keywords datasets
#' @name ndvi
NULL

### Code used to produce dataset:
# ndvi <- read_csv("ndvi_lum.csv")
# usethis::use_data(ndvi, overwrite = TRUE)
# write.csv(ndvi, file = "inst/extdata/ndvi.csv", row.names = FALSE)
