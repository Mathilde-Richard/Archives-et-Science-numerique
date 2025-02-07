library(leaflet)
library(sf)
library(leaflet.extras)
library(dplyr)

# Charger les fichiers
cartenodes <- read.csv("data/NoeudRType2.csv")
carteedges <- read.csv("data/edges.csv")

# Joindre les coordonnées des nœuds (from et to) aux données de carteedges
carteedges_with_coords <- carteedges %>%
  left_join(cartenodes, by = c("from" = "id")) %>%
  rename(from_lat = lat, from_lng = lng) %>%
  left_join(cartenodes, by = c("to" = "id")) %>%
  rename(to_lat = lat, to_lng = lng)


library(leaflet)
library(leaflet.extras)

leaflet() %>%
  addProviderTiles(providers$OpenStreetMap) %>%
  setView(lng = 2.3522, lat = 48.8566, zoom = 2) %>%
  addAwesomeMarkers(
    data = cartenodes,
    lng = ~lng,
    lat = ~lat,
    popup = ~paste( label,"<br><strong> : </strong> ", group, "d'archives"),
    icon = ~awesomeIcons(
      icon = 'fa-circle',  # Icône de base (par exemple, un cercle)
      markerColor = ifelse(group == "Preteur", "green", "blue"),  # Bleue pour Preteur, Rouge pour Emprunteur
      iconColor = 'white'  # Couleur de l'icône
    )
  ) %>%
  addPolylines(
    data = carteedges_with_coords,
    lng = ~c(from_lng, to_lng),
    lat = ~c(from_lat, to_lat),
    weight = 3,
    opacity = 0.7,
    color = "purple",
    popup = ~paste("<br><strong> prêt de </strong>", label.y, "<br><strong> à </strong> ", label, "<br><strong> fonds d'archives: </strong> ", label.x, "<br><strong> Preté depuis </strong> ", group.x)
  ) %>%
  addLayersControl(
    overlayGroups = c("Network"),
    options = layersControlOptions(collapsed = FALSE)
  ) %>%
  addLegend("bottomright", 
            colors = c("transparent"), 
            labels = c("Data: data.culture.gouv.fr"),
            title = "Representation des prets d'archives francaises en 2024:") %>%
  addMiniMap(position = "bottomleft")
