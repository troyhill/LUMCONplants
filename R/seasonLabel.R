#' Labels seasons
#'
#' @param data input dataframe
#' @param monthYearColumn character element identifying month/year column. Column data should be in the format mmm-yy
#' @param siteColumn character element identifying site identifier column
#' @param seasons a list associating each month with a season
#' @param year vector of two-digit years
#'
#' @return adds columns to input dataframe
#'
#' @examples
#' seasonLabel
#'
#' @export
seasonLabel <- function(data, monthYearColumn = "moYr", siteColumn = "site", seasons = NA, year = c(13:18)) {
  # labels each row's season. 'monthYearColumn' should be of the form %b-%y

  if(is.na(seasons)) {
    seasons <- list(
      # spring: Mar Apr May
      sprg = c("Mar", "Apr", "May"),
      # summer: Jun Jul Aug
      sumr = c("Jun", "Jul", "Aug"),
      # fall: Sep Oct Nov
      fall = c("Sep", "Oct", "Nov"),
      # winter: Dec Jan Feb
      wint = c("Dec", "Jan", "Feb")
    )
  }

  data[, "season"] <- as.character(NA)

  for (h in 1:length(unique(data[, siteColumn]))) {
    targSite <- as.character(unique(data[, siteColumn])[h])
    for (i in 1:length(seasons)) {
      for (j in 1:length(year)) {
        # account for winter spanning two years
        if (i == length(seasons)) {
          targetDates <- paste0(seasons[[i]], "-", c(year[j], year[j] + 1, year[j] + 1))
        } else {
          targetDates <- paste0(seasons[[i]], "-", year[j])
        }
        data[, "season"][(data[, monthYearColumn] %in% targetDates) & (data[, siteColumn] %in% targSite)] <- paste(names(seasons)[i], year[j])
      }
    }
  }
  invisible(data)
}




