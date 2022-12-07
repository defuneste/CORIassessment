## preparing data sets before saving in rda

### census 2010 ================================================================

census_2010 <- read.csv(
    "data-raw/census_tract_populations_2010.csv"
    ,
    colClasses = c(
        "GEOID" = "character",
        "NAME" = "character",
        "pop10" = "integer"
    )
)
# skimr::skim(census_2010)
# no missing value
# 73057  x 3
# checking if multiple ID length(unique(census_2010$GEOID))
# GEOID should be a sring -> specify colClasses
# NAME could be split -> Census Tract XXX / XXXX County / states

usethis::use_data(census_2010, overwrite = TRUE)

### census 2020 ================================================================

census_2020 <- read.csv(
    "data-raw/census_tract_populations_2020.csv"
    ,
    colClasses = c(
        "GEOID" = "character",
        "NAME" = "character",
        "pop20" = "integer"
    )
)
# no missing value
# 84414 x 3
# pop10 -> pop20

usethis::use_data(census_2020, overwrite = TRUE)


### RUCA tract definition file =================================================
# https://www.ers.usda.gov/data-products/rural-urban-commuting-area-codes/documentation/
# 74002 x 9
# pop missing some value ->  0 pop census tract, should be 0
# primary_ruca_code_2010 and secondary_ruca_code_2010 could be string
# it makes filtering a bit easier but at heart it is categorical data
# also contains Puerto Rico (PR) not present in 2010
# TODO get read of PR in the data if not in 2020

ruca <-
    readxl::read_excel("data-raw/ruca2010revised.xlsx", skip = 1) |>
    janitor::clean_names()

ruca_clear <- ruca[, c(
    "select_state",
    "select_county",
    "state_county_tract_fips_code_lookup_by_address_at_http_www_ffiec_gov_geocode",
    "primary_ruca_code_2010",
    "secondary_ruca_code_2010_see_errata"
)]

colnames(ruca_clear)[colnames(ruca_clear) == "state_county_tract_fips_code_lookup_by_address_at_http_www_ffiec_gov_geocode"] <-
    "FIPS"

ruca <- as.data.frame(ruca_clear)

usethis::use_data(ruca, overwrite = TRUE)


### 2020 census tract to 2010 census tract relationship file ===================
# some cleaning here need to be done
# removing unique value -> metadata if needed for MTFCC_TRACT_XX and FUNCSTAT_TRACT_XX
# id = character
# No need also for unique ID of each census: OID_TRACT_XX
# unsure I need arealand for each census or if I only need the aeraland/water_part

tract20_10 <-
    read.csv(
        "data-raw/tab20_tract20_tract10_natl.txt",
        sep = "|",
        colClasses = c(
            "NULL",
            "character",
            "NULL",
            "numeric",
            "numeric",
            "NULL",
            "NULL",
            #
            "NULL",
            "character",
            "NULL",
            "numeric",
            "numeric",
            "NULL",
            "NULL",
            # ?
            "numeric",
            "numeric"
        )
    )

usethis::use_data(tract20_10, overwrite = TRUE)
