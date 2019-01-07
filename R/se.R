#' Calculates standard error
#'
#' @param x numeric or integer
#'
#' @return value
#'
#' @examples
#' se
#' @importFrom stats sd
#' @export
se <- function(x){
  stats::sd(x, na.rm = TRUE) / sqrt(sum(x, na.rm = TRUE) / mean(x, na.rm = TRUE))
}


