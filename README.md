# Senior Data Engineer Assessment

At CORI, we believe that everyone everywhere deserves the opportunity to participate in and benefit from our growing tech economy. We also understand that data based on different rural definitions can lead us to tell different stories about the state of rural America. Therefore, our organizational goal of "_advancing economic prosperity in rural America through the creation of inclusive tech economy ecosystems that support scalable entrepreneurship and tech job creation_" requires that our data team and products are informed by context-sensitive, flexible and nuanced approaches to defining rural. In a [recent publication](https://ruralinnovation.us/blog/defining-rural-america/), we delve into a number of rural definitions. While putting together the background resources for this article, we identified the USDA's [Rural-Urban Commuting Area](https://www.ers.usda.gov/data-products/rural-urban-commuting-area-codes/documentation/) (RUCA) codes as an important Census tract definition that we want to incorporate in our work moving forward.

In the US, many elected state and federal officials represent districts that are intended to reflect equalized populations. And, every ten years the US Census Bureau surveys the general population to assess general population trends and update underlying geographies to better reflect the latest population trends. As a team, we’re committed to incorporating the best available data in our products and we currently find ourselves in a transitory phase when it comes to our underlying geographic data definitions.

For this assessment, we ask you to  translate our rural definition (RUCA) from the 2010 census tract definitions to the latest 2020 census definitions.

Assessment assets:
- TIGER/Line Census Tract geographies
  * [2010 TIGER/Line]( https://www.census.gov/programs-surveys/geography/technical-documentation/complete-technical-documentation/tiger-geo-line.2010.html#list-tab-3L9EYC1Q7KUN9000GD)
  * [2020 TIGER/Line]( https://www.census.gov/programs-surveys/geography/technical-documentation/complete-technical-documentation/tiger-geo-line.2020.html#list-tab-XSRBTN3QU2SOU0H39X). 
  * [tigris](https://github.com/walkerke/tigris). R package we use to pull tabular and spatial TIGER/line files from the US Census Bureau for common census geographies.  
  * [2010-2020 relationship files]( https://www.census.gov/geographies/reference-files/time-series/geo/relationship-files.html)
  * [Census Tract Relationship Files]( https://www2.census.gov/geo/docs/maps-data/data/rel2020/tract/tab20_tract20_tract10_natl.txt): The 2020 census tract relationship files provide simple relationships between 2020 census tract entities and 2010 census tract entities. [File explanation]( https://www.census.gov/geographies/reference-files/time-series/geo/relationship-files.html)
  * [RUCA tract definition file]( https://www.ers.usda.gov/webdocs/DataFiles/53241/ruca2010revised.xlsx?v=6309.2): CORI defines rural tracts where ‘Primary RUCA Code 2010’ >= 4
- Supplemental resource:
    - [Understanding Geographic Identifiers](https://www.census.gov/programs-surveys/geography/guidance/geo-identifiers.html)


Assessment guidance:
1) Use the RUCA Code 2010 to generate CORI’s rural definition.
2) Join CORI’s rural definition  to the 2010 TIGER/Line Census tracts
3) Use relationship file to associate 2010 TIGER/Line tract list with 2020 TIGER/Line tract list and crosswalk CORI’s rural definition.
4) Note -  there are multiple ways to associate a 2020 tract with a rural definition, please develop and a methodological recommendation on how we can associate 2020 TIGERLine tracts CORI’s rural definition
5) Produce dataset with 2 columns: tract GEOID’s (census tract unique identifier) and CORI rural indicator

Note:
- The US geographic definitions are quirky, if you find anomalies in the data, please take note, but do not let this stop your progress.
- This exercise does not necessarily require analysis or processing of the geometry included in these data sets.
- State  FIPs should be  < 60: This reflects the 50 states


## Data files

In the `data` folder, there are three files:

1) `tab20_tract20_tract10_natl.txt`

This file is the 2020 census tract to 2010 census tract relationship file. You can find an [explanation of the relationship file here](https://www2.census.gov/geo/pdfs/maps-data/data/rel2020/tract/explanation_tab20_tract20_tract10.pdf).

2) `census_tract_populations_2010.csv`  

This file provides population counts for 2010 census tracts.

3) `census_tract_populations_2020.csv`

This file provides population counts for 2020 census tracts.


## Instructions  

To begin, clone this repository.

Using the provided files, we would like you to analyze the tract relationship changes between 2010 and 2020 and provide a brief report summarizing what you found.

This exercise is designed to be open-ended and there is no right answer.
