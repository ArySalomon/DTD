install.packages("ggplot2")
install.packages("ggmap")
install.packages("maptools")
install.packages("maps")
install.packages("sp")
install.packages("RColorBrewer")
install.packages("leaflet")
install.packages("stplanr")

library(sf)
library(tidyr)
library(dplyr)
library(stplanr)
library(leaflet)
library(ggplot2)
library(ggmap)
library(maptools)
library(maps)
library(sp)
library(RColorBrewer)


library(readxl)
Agenda_Verano <- read_excel("Agenda Verano.xlsx")
View(Agenda_Verano)

# asignamos categorias

eventos <- c("Naturaleza y Ecoturismo", "Cultural e Histórico", "Gastronomía", "Deporte y Aventura")

Agenda_Verano$Grupo <- sample(eventos, nrow(Agenda_Verano), replace = TRUE)

rm(eventos)

# hora inicio
Agenda_Verano$hora_inicio <- format(Agenda_Verano$Fecha.inicio, "%H:%M:%S")

#fecha
Agenda_Verano$fecha <- as.Date(Agenda_Verano$Fecha.inicio)

# hora_inicio + 1h
Agenda_Verano$hora_fin <- format(as.POSIXct(Agenda_Verano$hora_inicio, format = "%H:%M:%S") + 3600, "%H:%M:%S")





leaflet() %>%
  addTiles() %>%
  addMarkers(data = Agenda_Verano, lng = ~Longitud, lat = ~Latitud, popup = "Location")


# filtro dia
agenda_dia <- Agenda_Verano %>% filter(fecha == as.Date(Agenda_Verano$fecha[80]))



## construir la url manualmente

agenda_dia <- Agenda_Verano %>% filter(fecha == as.Date(Agenda_Verano$fecha[80])) %>%
  mutate(latlong = paste0(Latitud, ",", Longitud))

waypoints <- paste0(paste(agenda_dia$latlong, collapse = "/")) # eventos

base_url <- "https://www.google.com/maps/dir/"



# centroid <- st_centroid(st_union(agenda_dia))
alojamiento <- paste0(st_coordinates(centroid)[ , "Y"], ",", st_coordinates(centroid)[ , "X"], collapse = ",") # puse la mediana de todos los eventos (por si no quiere poner alojamiento)


url <- paste0(base_url, paste0(alojamiento , "/"), waypoints, paste0("/@", alojamiento), ",13.8z?entry=ttu")




# Travel route optim ------------------------------------------------------


### Intento optimizar ruta de viaje (conclyó en el trazado de la ruta sin optimización)
agenda_dia <- Agenda_Verano %>% filter(fecha == as.Date(Agenda_Verano$fecha[80]))

# redefinimos a Posixct
agenda_dia$hora_inicio <- as.POSIXct(agenda_dia$Fecha.inicio)
agenda_dia$hora_fin <- as.POSIXct(agenda_dia$Fecha.inicio)


# shapefile
agenda_dia <- st_as_sf(agenda_dia, coords = c("Longitud", "Latitud"), crs = 4326)

centroid <- st_centroid(st_union(agenda_dia))
centroid_lon <- st_coordinates(centroid)[, "X"]
centroid_lat <- st_coordinates(centroid)[, "Y"]

agenda_dia$long <- st_coordinates(agenda_dia)[, "X"]
agenda_dia$lat <- st_coordinates(agenda_dia)[, "Y"]

leaflet(data = agenda_dia) %>%
  addProviderTiles("OpenStreetMap.Mapnik") %>%
  addPolylines(lng = c(agenda_dia$long, centroid_lon), 
               lat = c(agenda_dia$lat, centroid_lat),
               color = "red") %>% 
  addMarkers(data = agenda_dia, lng = ~long, lat = ~lat, popup = "Location") %>% 
  addMarkers(data = centroid)




















