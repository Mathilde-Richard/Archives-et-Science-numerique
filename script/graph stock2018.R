
# install.packages("ggplot2")

library(ggplot2)

ADstock <- read.csv("data/tableau AD stock.csv")

# 1. Charger le package nécessaire pour lire les fichiers CSV (si tu ne l'as pas déjà)
# install.packages("readr") # Si ce n'est pas déjà installé
library(readr)


#lecture du csv
ADstock <- read_csv("data/tableau AD stock.csv")



# Remplacer les virgules par des points dans la colonne de valeurs
ADstock$`Nouvelles archives 2018` <- gsub(",", ".", ADstock$`Nouvelles archives 2018`)

# Convertir la colonne en numérique (au cas où elle serait encore sous forme de texte)
ADstock$`Nouvelles archives 2018` <- as.numeric(ADstock$`Nouvelles archives 2018`)

# Vérifier la conversion
head(ADstock$`Nouvelles archives 2018`)




# Création du barplot
barplot(ADstock$`Nouvelles archives 2018`, 
        names.arg = ADstock$DEPARTEMENT,  # Utilisation de la colonne des départements pour l'axe des x
        col = ifelse(ADstock$`Nouvelles archives 2018` < 0, "red", "blue"), # Couleurs selon la valeur (rouge pour négatif, bleu pour positif)
        main = "Acroissement des fonds d'archives en 2018", 
        xlab = "par départements", 
        ylab = "En métrage linéaire",
        border = "black")  # Bordures pour les barres




#GRAPH interactif 
# Charger plotly
library(plotly)

# Créer un barplot avec plotly
p <- plot_ly(
  x = ADstock$DEPARTEMENT, 
  y = ADstock$`Nouvelles archives 2018`, 
  type = "bar",
  marker = list(color = ifelse(ADstock$`Nouvelles archives 2018` < 0, "red", "darkblue")),
  text = ADstock$`Nouvelles archives 2018`,  # Afficher les valeurs lors du survol
  hoverinfo = "text"  # Afficher le texte lorsque tu survoles une barre
)

# Ajouter un titre et des labels
p <- p %>% layout(
  title = "Acroissement des fonds d'archives en 2018",
  xaxis = list(title = "Par départements"),
  yaxis = list(title = "En métrage linéaire")
)


# Afficher le graphique interactif
p




