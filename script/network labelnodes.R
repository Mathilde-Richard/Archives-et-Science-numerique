library(visNetwork)
library(tidyverse)

# Lecture des fichiers CSV
edgessimple <- read.csv("data/edgessimple.csv")
nodessimple <- read.csv("data/Noeudsimple.csv")

# 3. Select by a column (e.g., "group")
visNetwork(nodessimple, edgessimple, height = "500px", width = "100%") %>%
  visNodes(
    label = ~label,  # Utilisation de la colonne 'label'
    font = list(size = 40)  # Augmenter la taille des labels à 20 (ajuste selon ton besoin)
  ) %>%
  visOptions(selectedBy = "group") %>%
  visLayout(randomSeed = 123) %>%
  visGroups(groupname = "Pret.de.2021", color = "lightblue") %>%
  visGroups(groupname = "Pret.de.2022", color = "yellow") %>%
  visGroups(groupname = "Pret.de.2023", color = "red") %>%
  visGroups(groupname = "Pret.de.2020", color = "lightgreen") %>%
  visGroups(groupname = "Emprunteur", color = "hotpink") %>%
  visLegend(width = 0.1, position = "right", main = "group")



