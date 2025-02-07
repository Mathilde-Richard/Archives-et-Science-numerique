library(visNetwork)
library(tidyverse)

nodes <- read.csv("data/NoeudR.csv")
edges <- read.csv("data/edges.csv")

###

visNetwork(nodes, edges, height = "500px", width = "100%") %>%
  visNodes(
    label = ~label,  # Utilisation de la colonne 'label' pour les nœuds
    font = list(size = 30)  # Agrandir la taille des labels des nœuds
  ) %>%
  visEdges(
    label = ~label,  # Utilisation de la colonne 'label' pour les arêtes
    font = list(size = 16, color = "gray"),  # Personnaliser la taille et la couleur des labels des arêtes
  ) %>%
  visGroups(groupname = "Pret.de.2021", color = "lightblue") %>%
  visGroups(groupname = "Pret.de.2022", color = "yellow") %>%
  visGroups(groupname = "Pret.de.2023", color = "red") %>%
  visGroups(groupname = "Pret.de.2020", color = "lightgreen") %>%
  visGroups(groupname = "Emprunteur", color = "hotpink") %>%
  visLegend(width = 0.1, position = "right", main = "group")%>%
  visLegend(
    position= "right",  # Position de la légende
    main = "Date des Prêts",  # Titre de la légende,
    width = 0.2 )


# 3. Select by a column (e.g., "group")
visNetwork(nodes, edges, height = "500px", width = "100%") %>%
  visOptions(selectedBy = "group") %>%
  visLayout(randomSeed = 123)

# Use igraph layout with a circular arrangement
visNetwork(nodes, edges, height = "500px") %>%
  visIgraphLayout(layout = "layout_in_circle") %>%
  visNodes(size = 10) %>%
  visOptions(selectedBy = "group") %>%
  visOptions(highlightNearest = list(enabled = T, hover = T), 
             nodesIdSelection = T)
