get_clima_info <- function(file, include_city = TRUE){
  
  clima <- data.table::fread(
    file = file,
    sep = ";",
    skip = 7, 
    dec = ",",
    #nrow = 50 - only for testing purposes
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
  
  if(include_city == TRUE){
  data <- data.frame(latitude = readr::parse_number(gsub(",","\\.",caract[5,2])),
                     longitude = readr::parse_number(gsub(",","\\.",caract[6,2])))
  city <- get_city(data)
  clima$municipio <- city$municipio
  clima$id_municipio <- city$id_municipio
  }
  
  return(clima)
}

get_base_inmet <- function(year, include_city = TRUE){
  url = paste0("https://portal.inmet.gov.br/uploads/dadoshistoricos/", year,".zip")
  temp = tempfile()
  download.file(url, temp)
  temp = unzip(temp)
  base = furrr::future_map_dfr(temp, get_clima_info, include_city= include_city)
  unlink(temp)
  unlink(year, recursive =T)

  #name = paste0("Bases/clima/clima", year,".rds")
  #saveRDS(base, name)
          
return(base)
}