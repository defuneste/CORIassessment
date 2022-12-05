## preparing data sets before saving in rda

### census 2010 ================================================================

census_2010 <- read.csv("data-raw/census_tract_populations_2010.csv"
                        , colClasses = c(
                            "GEOID" = "character",
                            "NAME" = "character",
                            "pop10" = "integer"
                        ))
# skimr::skim(census_2010)
# no missing value
# 73057  x 3
# checking if multiple ID length(unique(census_2010$GEOID))
# GEOID should be a sring -> specify colClasses

usethis::use_data(census_2010, overwrite = TRUE)

### census 2020 ================================================================

census_2020 <- read.csv("data-raw/census_tract_populations_2020.csv"
                        , colClasses = c(
                            "GEOID" = "character",
                            "NAME" = "character",
                            "pop20" = "integer"
                        ))
# no missing value
# 84414 x 3
# pop10 -> pop20

usethis::use_data(census_2020, overwrite = TRUE)
