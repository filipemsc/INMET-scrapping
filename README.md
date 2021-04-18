# INMET-scrapping
Web scrapping of INMET (Instituto Nacional de Meteorologia) official data, containing information about climate conditions in Brazil by meteorological station. 

## Required Packages
stringi, lubridate, purrr, furrr, data.table, readr, dplyr, geobr, raster

## Syntax 

```R
get_stations_inmet(year, include_city = TRUE)
```

```R
get_stations_inmet(year, include_city = TRUE)
```

## Available variables

### get_stations_inmet

`estacao`: Name of the meteorological station 

`codigo`: Code of the meteorological station

`municipio`: City where station is located

`id_municipio`: IBGE code of the city 

`regiao`: Brazilian region where the station is located

`uf`: State of Brazil where the station is located 

`latitude`: Latitude of station

`lontitude `: Longitude of station

`altitude`: Altitude of station 

`data_fundacao`: Date which the station was founded


### get_base_inmet

`data`: Date

`hour`: Hour (UTC)

`precipitacao_total`: Total precipitation, hour (mm)

`pressao_atm_nivel`: Atmospheric pressure at station level, hour (mB)

`pressao_atm_max`: Maximum atmospheric pressure at station level, last hour (mB)

`pressao_atm_max`: Minimum atmospheric pressure at station level, last hour (mB)

`radiacao_global`: Global radiation (KJ/m²)

`temp_bulbo_hora`: Dry-bulb temperature, hour (ºC)

`temp_orvalho`: Dew point (ºC)

`temp_max`: Maximum temperature, last hour (ºC)

`temp_min`: Minimum temperature, last hour (ºC)

`temp_orv_max`: Maximum dew point, last hour (ºC)

`temp_orv_min`: Minimum dew point, last hour (ºC)

`umid_rel_max`: Maximum air relative humidity, last hour (%)

`umid_rel_min`: Minimum air relative humidity, last hour (%)

`umid_rel_hora`: Air relative humidity, hour (%)

`vento_direcao`: Wind direction (gr)

`vento_rajada_max`: Maximum wind gust, last hour (m/s)

`vento_velocidade`: Wind speed, hour (m/s) 
