## merge census 2010 and Ruca
census_2010_plus <- merge(census_2010, ruca,
                          by.x = "GEOID",
                          by.y = "FIPS")

# skimr::skim(census_2010_plus)

# Rural or not rural
census_2010_plus$rural <-
    ifelse(census_2010_plus$primary_ruca_code_2010 >= 4, "R", "Not R")

census_2010_rural <- census_2010_plus[, c("GEOID", "rural")]

## extract census that do not change or not so much
same_id <- tract20_10$GEOID_TRACT_20 == tract20_10$GEOID_TRACT_10
same_census <- tract20_10[same_id,]


same_census$land_diff_perc <- land_change(same_census)
same_census$land_diff_raw <- land_change(same_census, perc = FALSE)

to_keep <-
    abs(same_census$land_diff_perc) <= 1 &
    abs(same_census$land_diff_raw) <= 10000

same_census_close <- same_census[to_keep,]

#
same_census_close_rural <-
    merge(same_census_close,
          census_2010_rural,
          by.x = "GEOID_TRACT_10",
          by.y = "GEOID",
          all.x = TRUE)

# NA check if PR
barplot(table(same_census_close_rural$rural, useNA = "always"))
