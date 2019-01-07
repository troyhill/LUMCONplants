#' Generates allometry models for input data
#'
#' @param dataset input dataframe
#' @param massCol name of column with mass data
#' @param heightCol name of column with height data
#' @param typeCol name of column with live/dead status
#' @param cutOff minimum number of stems to be used for allometry model. Smaller numbers increase odds of convergence problems.
#' @param startVals starting value used for allometry model coefficients and exponents
#' @param timeName optional label for time period
#' @param dataName optional label for data/site
#' @param returnPlot if TRUE, a plot of allometry data is returned. Two panels, with live stems are on the left, dead are on right
#' @param savePlot if TRUE, plot is saved to working directory
#' @param plotTitle optional title for plot
#'
#' @return value
#'
#' @examples
#' getParams
#' @importFrom stats nls
#' @importFrom stats median
#' @importFrom graphics lines
#' @importFrom graphics points
#' @importFrom graphics text
#' @importFrom graphics plot
#' @importFrom grDevices dev.off
#' @importFrom grDevices png
#' @importFrom graphics par
#' @export
getParams <- function (dataset, massCol = "mass_tot", heightCol = "hgt", typeCol = "status",
                       cutOff = 5, startVals = 0.2,
                       timeName = NA, dataName = NA,
                       returnPlot = FALSE, savePlot = FALSE, plotTitle = NA) {
  # returnPlot: live stems are on the left, dead are on right
  # typeCol: column indicating live/dead status
  # a stream-lined workhorse of getAllometryParams. Generates live/dead allometry parameters for whatever dataset it's fed.
  # really, this is just a wrapper for nls().
  # getParams(cwc[(cwc$season %in% "sprg 13") & (cwc$marsh %in% "LUM"), ])
  # getParams(cwc[(cwc$season %in% "sprg 13") & (cwc$marsh %in% "LUM"), ], returnPlot = TRUE)
  # getParams(cwc[(cwc$season %in% "sprg 13") & (cwc$marsh %in% "LUM"), ], returnPlot = TRUE, plotTitle = "sprg 13")

  returnVals <- data.frame(time.period = timeName,
                           data.name = dataName,
                           coef.live = as.numeric(NA), exp.live = as.numeric(NA),
                           MSE.live = as.numeric(NA), r.live = as.numeric(NA),
                           coef.dead = as.numeric(NA), exp.dead = as.numeric(NA),
                           MSE.dead = as.numeric(NA), r.dead = as.numeric(NA)
  )

  x          <- dataset[, heightCol][tolower(dataset[, typeCol]) %in% "live"]
  y          <- dataset[, massCol][tolower(dataset[, typeCol]) %in% "live"]
  x.dead     <- dataset[, heightCol][tolower(dataset[, typeCol]) %in% "dead"]
  y.dead     <- dataset[, massCol][tolower(dataset[, typeCol]) %in% "dead"]

  # get live biomass parameters
  if (length(x) < cutOff) {
    returnVals$coef.live <- as.numeric(NA)
    returnVals$exp.live  <- as.numeric(NA)
    returnVals$MSE.live  <- as.numeric(NA)
    returnVals$r.live    <- as.numeric(NA)
  } else {
    coefs      <- stats::coef(model <- stats::nls(y ~ I(a * x^b), start = list(a = startVals, b = startVals)))
    predicted                <- coefs[1] * x^coefs[2]
    squared_error            <- (predicted - y)^2
    returnVals$coef.live  <- coefs[1]
    returnVals$exp.live   <- coefs[2]
    returnVals$MSE.live   <- mean(squared_error, na.rm = T)
    returnVals$r.live     <- 1 - (stats::deviance(model)  / sum((y[!is.na(y)] - mean(y, na.rm = T))^2))
  }

  # get dead biomass parameters
  if (length(x.dead) < cutOff) {
    returnVals$coef.dead <- as.numeric(NA)
    returnVals$exp.dead  <- as.numeric(NA)
    returnVals$MSE.dead  <- as.numeric(NA)
    returnVals$r.dead    <- as.numeric(NA)
  } else {
    coefs      <- stats::coef(model <- stats::nls(y.dead ~ I(a * x.dead^b), start = list(a = startVals, b = startVals)))
    predicted                <- coefs[1] * x.dead^coefs[2]
    squared_error            <- (predicted - y.dead)^2
    returnVals$coef.dead  <- coefs[1]
    returnVals$exp.dead   <- coefs[2]
    returnVals$MSE.dead   <- mean(squared_error, na.rm = T)
    returnVals$r.dead     <- 1 - (stats::deviance(model)  / sum((y.dead[!is.na(y.dead)] - mean(y.dead, na.rm = T))^2))
  }

  if (returnPlot == TRUE) {
    if (savePlot == TRUE) {
      fileName = paste0("Allom-", Sys.time(), ".png")
      grDevices::png(filename = fileName, width = 15, height = 8, units = "cm", res = 300)
    }
    living <- c("Live", "coef.live", "exp.live", "live")
    dying <- c("Dead", "coef.dead", "exp.dead", "dead")

    graphics::par(mar = c(4, 4, 0.3, 0.5), fig = c(0, 0.48, 0, 1))
    biomassType <- "live"
    if (!is.na(plotTitle)) {
      title_of_plot <- paste0(plotTitle, ": live stems")
    } else {
      title_of_plot <- ""
    }
    graphics::plot(dataset[, massCol] ~ dataset[, heightCol],
         ylab = "mass (g)", xlab = "height (cm)",
         type = "n", las = 1, xlim = c(0, max(dataset[, heightCol], na.rm = T)),
         ylim = c(0, max(dataset[, massCol], na.rm = T)))

    graphics::points(x = dataset[, heightCol][tolower(dataset[, typeCol]) %in% biomassType],
           y = dataset[, massCol][tolower(dataset[, typeCol]) %in% biomassType],
           pch = 19, cex = 0.8, las = 1)
    # predicted values
    min.x <- min(dataset[, heightCol][tolower(dataset[, typeCol]) %in% biomassType], na.rm = T)
    max.x <- max(dataset[, heightCol][tolower(dataset[, typeCol]) %in% biomassType], na.rm = T)
    xVals <- c((min.x * 100):(max.x * 100)) / 100
    modeled <- returnVals[1, paste0("coef.", biomassType)] * xVals ^ (returnVals[1, paste0("exp.", biomassType)])
    graphics::lines(x = xVals, y = modeled, lty = 2, col = "red")
    graphics::text(x = stats::median(dataset[, heightCol], na.rm = T), y = 0.7 * max(dataset[, massCol], na.rm = T),
         cex = 0.85, title_of_plot)

    biomassType <- "dead"
    if (!is.na(plotTitle)) {
      title_of_plot <- paste0(plotTitle, ": dead stems")
    } else {
      title_of_plot <- ""
    }
    graphics::par(mar = c(4, 4, 0.3, 0.5), fig = c(0.5, 1, 0, 1), new = T)
    graphics::plot(dataset[, massCol] ~ dataset[, heightCol],
         ylab = "mass (g)", xlab = "height (cm)",
         type = "n", las = 1, xlim = c(0, max(dataset[, heightCol], na.rm = T)),
         ylim = c(0, max(dataset[, massCol], na.rm = T)))

    graphics::points(x = dataset[, heightCol][tolower(dataset[, typeCol]) %in% biomassType],
           y = dataset[, massCol][tolower(dataset[, typeCol]) %in% biomassType],
           pch = 19, cex = 0.8, las = 1)
    # predicted values
    if (sum(!is.na(dataset[, heightCol][tolower(dataset[, typeCol]) %in% biomassType])) > cutOff) {
      min.x <- min(dataset[, heightCol][tolower(dataset[, typeCol]) %in% biomassType], na.rm = T)
      max.x <- max(dataset[, heightCol][tolower(dataset[, typeCol]) %in% biomassType], na.rm = T)
      xVals <- c((min.x * 100):(max.x * 100)) / 100
      modeled <- returnVals[1, paste0("coef.", biomassType)] * xVals ^ (returnVals[1, paste0("exp.", biomassType)])
      graphics::lines(x = xVals, y = modeled, lty = i, col = "red")
    }
    graphics::text(x = stats::median(dataset[, heightCol], na.rm = T), y = 0.7 * max(dataset[, massCol], na.rm = T),
         cex = 0.85, title_of_plot)
    if (savePlot == TRUE) {
      grDevices::dev.off()
    }
  }


  returnVals
}




