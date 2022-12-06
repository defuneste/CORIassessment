## merge census 2010 and Ruca
census_2010_plus <- merge(census_2010, ruca,
                         by.x = "GEOID",
                         by.y = "FIPS")

# skimr::skim(census_2010_plus)
