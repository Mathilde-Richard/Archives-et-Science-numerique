# Charger les bibliothèques nécessaires
library(leaflet)
library(sf)
library(dplyr)
library(readr)  # Pour lire les fichiers CSV

# Charger les données géographiques des départements et des régions
departements <- st_read("data/shp/departements/departements.shp")

# Lire les données de population depuis le fichier CSV
entreeAD <- read_csv("data/MapAD.csv")

# Vérifier la structure des données CSV
head(entreeAD)

# Fusionner les données de population avec les géométries des région
mapstatAD <- departements %>%
  left_join(entreeAD, by = c("NAME_2" = "departement"))

# Créer la carte leaflet
mymap <- leaflet() %>%
  addProviderTiles("CartoDB.Positron") %>%  # Choisir un fond de carte
  # Ajouter les régions avec un fond coloré basé sur la population
  addPolygons(data = departements,
              color = "lightblue",
              weight = 2,
              fillOpacity = 0.7,
              label = ~paste("département :", NAME_2),
              group = "départements") %>%  # L'ajouter à un groupe 
  # Ajouter des cercles représentant les entrées pour chaque région
  addCircleMarkers(data = entreeAD,
                   ~lng, ~lat,  # Utiliser les colonnes latitude et longitude
                   radius = ~sqrt(Frequentation) * 0.05 ,  # Taille des points proportionnelle aux entrées
                   color = "blue",
                   fill = TRUE,
                   fillColor = "blue",
                   fillOpacity = 1,
                   popup = ~paste("<strong> AD: </strong>",numero,
                                  "<br><strong> Frequentation en 2018:</strong>", Frequentation),
                   label = ~paste("Entrées:", Frequentation), # Ajouter l'étiquette avec les entrées
                   group = "Frequentation des AD") %>%  # L'ajouter à un groupe "Entrées"
  
  ## Ajouter une légende
  addLegend("bottomright",
            colors = c("transparent"),
            labels = c("Data: data.culture.gouv.fr / enquete du SIAF de 2018 auprès des archives departementales"),
            title = "Frequentation des Archives departementales en 2018") %>%
  
  ## Ajouter une mini carte
  addMiniMap("bottomleft") %>%
  
  # Ajouter le contrôle des couches pour afficher ou masquer les groupes
  addLayersControl(
    overlayGroups = c("départements", "Frequentation des AD"),  # Définir les groupes à contrôler
    options = layersControlOptions(collapsed = FALSE)  # Ne pas réduire le contrôle
  )

# Afficher la carte
mymap
