library(dplyr)

get_data <- function(chr){
  
  if(grepl("-", chr)){
  x= strsplit(chr, split = "-")[[1]][1]
  }
  
  if(grepl("/", chr)){
    x= strsplit(chr, split = "/")[[1]][1]
  }
  
  if(nchar(x)==4){
    y = lubridate::ymd(chr)
  }
  if(nchar(x)==2){
    y = lubridate::dmy(chr)
  }
  
  return(y)
}


get_stations <- function(file){
  
  caract = data.table::fread(
    file = file,
    nrows = 8, 
    header = FALSE,
    col.names= c("caract","value"))
  
  regiao <- caract[1,2]
  uf <- caract[2,2]
  estacao <- caract[3,2]
  codigo <- caract[4,2]
  latitude <- caract[5,2]
  longitude <- caract[6,2]
  altitude <- caract[7,2]
  datafundacao <- as.character(caract[8,2])
  
  data.frame(
    estacao = as.character(estacao), 
    codigo = as.character(codigo), 
    regiao = as.character(regiao), 
    uf = as.character(uf), 
    latitude = readr::parse_number(gsub(",","\\.",latitude)), 
    longitude = readr::parse_number(gsub(",","\\.",longitude)),
    altitude = readr::parse_number(gsub(",","\\.", altitude)),
    data_fundacao = get_data(datafundacao))
}

get_stations_inmet <- function(year){
  url = paste0("https://portal.inmet.gov.br/uploads/dadoshistoricos/", year,".zip")
  temp = tempfile()
  download.file(url, temp)
  temp = unzip(temp)
  base = purrr::map_df(temp, get_stations)
  unlink(temp)
  unlink(year, recursive =T)
  
  name = paste0("Bases/Stations/station", year,".rds")
  saveRDS(base, name)
  
  return(base)
}

stations2000 = get_stations_inmet(2000)
stations2001 = get_stations_inmet(2001)
stations2002 = get_stations_inmet(2002)
stations2003 = get_stations_inmet(2003)
stations2004 = get_stations_inmet(2004)
stations2005 = get_stations_inmet(2005)
stations2006 = get_stations_inmet(2006)
stations2007 = get_stations_inmet(2007)
stations2008 = get_stations_inmet(2008)
stations2009 = get_stations_inmet(2009)
stations2010 = get_stations_inmet(2010)
stations2011 = get_stations_inmet(2011)
stations2012 = get_stations_inmet(2012)
stations2013 = get_stations_inmet(2013)
stations2014 = get_stations_inmet(2014)
stations2015 = get_stations_inmet(2015)
stations2016 = get_stations_inmet(2016)
stations2017 = get_stations_inmet(2017)
stations2018 = get_stations_inmet(2018)
stations2019 = get_stations_inmet(2019)
