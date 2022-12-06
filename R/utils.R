#' Extract the State
#'
#' Extract the third element, here the state, of a string using "," as separator
#'
#' @param x A string from census_2010$NAME
#'
#' @return A string: a State name
#' @export
#'
#' @examples
#' x <- census_2010$NAME[1]
#' gimme_the_state(x)

gimme_the_state <- function(x){
    trimws(
        unlist(strsplit(x[1], ",")
        )[3])
}
