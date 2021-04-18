source("R/get_data.R")
source("R/change_names.R")

get_clima_info <- function(file){
  
  clima <- data.table::fread(
    file = file,
    sep = ";",
    skip = 7, 
    dec = ",",
    nrow = 50 # only for testing purposes - must delete later
    )
  
  caract <- data.table::fread(
    file = file,
    nrows = 8, 
    header = FALSE,
    col.names= c("caract","value"))
  
  clima = clima[,-"V20"]
  
  names(clima) <- change_names(clima)
  
  clima$regiao <- caract[1,2]
  clima$uf <- caract[2,2]
  clima$estacao <- caract[3,2]
  clima$codigo <- caract[4,2]
  clima$latitude <- readr::parse_number(gsub(",","\\.",caract[5,2]))
  clima$longitude <- readr::parse_number(gsub(",","\\.",caract[6,2]))
  clima$altitude <- readr::parse_number(gsub(",","\\.",caract[7,2]))
  clima$data_fundacao <- get_data(as.character(caract[8,2]))
  
  clima[clima == -9999] <- NA
  clima <- dplyr::mutate(clima, data = get_data(as.character(data)))
  clima[,3:19] <- clima[,3:19] %>% lapply(as.numeric)
  clima$hora <- as.numeric(substr(clima$hora, 1,2))
  
  return(clima)
}

get_base_inmet <- function(year){
  url = paste0("https://portal.inmet.gov.br/uploads/dadoshistoricos/", year,".zip")
  temp = tempfile()
  download.file(url, temp)
  temp = unzip(temp)
  base = purrr::map_df(temp, get_clima_info)
  unlink(temp)
  unlink(year, recursive =T)

  #name = paste0("Bases/clima/clima", year,".rds")
  #saveRDS(base, name)
          
return(base)
}

memory.limit(24576)

clima2000 = get_base_inmet(2000)
clima2001 = get_base_inmet(2001)
clima2002 = get_base_inmet(2002)
clima2003 = get_base_inmet(2003)
clima2004 = get_base_inmet(2004)
clima2005 = get_base_inmet(2005)
clima2006 = get_base_inmet(2006)
clima2007 = get_base_inmet(2007)
clima2008 = get_base_inmet(2008)
clima2009 = get_base_inmet(2009)
clima2010 = get_base_inmet(2010)
clima2011 = get_base_inmet(2011)
clima2012 = get_base_inmet(2012)
clima2013 = get_base_inmet(2013)
clima2014 = get_base_inmet(2014)
clima2015 = get_base_inmet(2015)
clima2016 = get_base_inmet(2016)
clima2017 = get_base_inmet(2017)
clima2018 = get_base_inmet(2018)
clima2019 = get_base_inmet(2019)
clima2020 = get_base_inmet(2020)


