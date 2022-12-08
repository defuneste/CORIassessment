# less clear cases
census20 <- rural_census_2020()

# remove case were we do not have land surf
# TODO check cases with islands/lot of water
census20 <- census20[!is.na(census20$perc_r),]

census20$filter <-
    ifelse(census20$perc_r < 3 |
               census20$perc_r > 96, "ok", "check")

to_check <- census20[census20$filter == "check",]

hist(to_check$perc_r)


# get shp of cases to check
library(sf)
library(mapview)
library(tigris)

tract20.shp <- tigris::tracts(cb = TRUE)
names(tract20.shp)

tract_to_check <-
    tract20.shp[tract20.shp$GEOID %in% to_check$GEOID_20,]

tract_to_check <- merge(tract_to_check, to_check,
                        by.x = "GEOID",
                        by.y = "GEOID_20")

# quick check
tract_to_check_4326 <- st_transform(tract_to_check, 4326)
mapview(tract_to_check_4326, zcol = "perc_r")

rm(tract20.shp)

# get shape for 2010
# get the ANSI states codes
# code_states <- read.csv("https://www2.census.gov/geo/docs/reference/state.txt", sep = "|")

list_of_states_needed <- unique(substr(tract_to_check$GEOID, 1, 2))

tract10.shp <- NULL
for(i in 1:length(list_of_states_needed)) {
    tract10.shp <-
        rbind(tract10.shp,
              tigris::tracts(
                  state = list_of_states_needed[i],
                  year = 2010,
                  cb = TRUE
              ))
}

# get only the one that intersect what we want to check
census_10_to_check  <-  tract10.shp[tract_to_check ,]


size_of_geo_id <-  nchar(census_10_to_check$GEO_ID[1])

census_10_to_check$GEOID <-
    substr(census_10_to_check$GEO_ID, 10, size_of_geo_id)

census_10_to_check <- merge(census_10_to_check, ruca,
                            by.x = "GEOID",
                            by.y = "FIPS")
# here take time to check order 1 -> 10 -> 2
census_10_to_check$primary_ruca_code_2010 <- as.factor(census_10_to_check$primary_ruca_code_2010)

census_10_to_check_4326 <- st_transform(census_10_to_check, 4326)

mapview(census_10_to_check_4326, zcol = "primary_ruca_code_2010") + mapview(tract_to_check_4326, zcol = "perc_r")

