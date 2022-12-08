# ruca with just FIPS and Primary Code

rural_census_2020 <- function() {
    ruca_lit <- ruca[, c("FIPS", "primary_ruca_code_2010")]

    # merge RUCA with tract20_10
    tract20_10_R <- merge(tract20_10,
                          ruca_lit,
                          by.x = "GEOID_TRACT_10",
                          by.y = "FIPS")
    # remeber her PR is silently discarded

    # get rural area only when it come from rural
    tract20_10_R$AREA_rural <-
        ifelse(tract20_10_R$primary_ruca_code_2010 >= 4,
               tract20_10_R$AREALAND_PART,
               0)

    # sum rural area for each census tract in 2020
    census20 <-
        aggregate(tract20_10_R$AREA_rural,
                  list(tract20_10_R$GEOID_TRACT_20),
                  sum)
    # just a weird way to get the surface of land in 2020 while checking for error
    census20$area_surf <-
        aggregate(tract20_10_R$AREALAND_TRACT_20,
                  list(tract20_10_R$GEOID_TRACT_20),
                  unique)[, 2]

    names(census20) <- c("GEOID_20", "Rural_surf", "Tot_surf")

    # percentile of land that was part of a rural census track in 2010
    # inside each census in 2020

    census20$perc_r <-
        round((
            1 - (census20$Tot_surf - census20$Rural_surf) / census20$Tot_surf
        ), 2) * 100
    return(census20)
    # We can progress on [3-97]
    # or adapt when census20$Tot_surf = 0
}
