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

gimme_the_state <- function(x) {
    trimws(unlist(strsplit(x[1], ","))[3])
}

#' Calculate surface difference between 2020 tract and 2010
#'
#' Use tab20_tract20-tract10 to calculate difference in  total land area between 2020 and 2010 and return a vector
#'
#' @param x is a tab20_tract20_tract10
#' @param perc if not specified will be TRUE to generate percentage if FALSE will generate raw units
#' @export
#'

land_change <- function(x, perc = TRUE) {
    if (perc == TRUE) {
        land_diff_perc = (((x$AREALAND_TRACT_20 + x$AREAWATER_TRACT_20) -
                               (x$AREALAND_TRACT_10 + x$AREAWATER_TRACT_10)
        ) /
            (x$AREALAND_TRACT_20 + x$AREAWATER_TRACT_20)) * 100
        return(land_diff_perc)
    } else{
        land_diff = (((x$AREALAND_TRACT_20 + x$AREAWATER_TRACT_20) -
                          (x$AREALAND_TRACT_10 + x$AREAWATER_TRACT_10)
        ) /
            (x$AREALAND_TRACT_20 + x$AREAWATER_TRACT_20))
        return(land_diff)
    }

}
