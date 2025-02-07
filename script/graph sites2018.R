library(ggplot2)
ADsites<- read.csv("data/tableau AD sites.csv")

#Scatter plot site internet AD 
# Customized scatter plot with additional aesthetics
ggplot(data = ADsites, aes(x = Mise.en.ligne, 
                         y = Pages.en.ligne,
                         colour = Images.en.ligne.pourcentage,
                         size = Images.en.ligne))  +
  
  geom_point() + 
  labs(x = "Creation du site internet", 
       y = "Nombre de pages en ligne", 
       title = "Le sites des archives departementales",
       subtitle = "comparaisons du nombres de pages, d'images (et leur proportions)",
       caption = "Data: data.culture.gouv.fr / enquete du SIAF de 2018 aupres des archives departementales")


library(plotly)
#Scatter plot sites internet AD avec Plotly interactif 
fig <-
  ggplot(data = ADsites, aes(x = Mise.en.ligne, y = Pages.en.ligne, colour = Images.en.ligne.pourcentage, size = Images.en.ligne)) +
  geom_point(alpha = 0.5) + 
  theme_bw()
labs(x = "Creation du site internet", 
     y = "Nombre de pages en ligne", 
     title = "Le sites des archives departementales",
     subtitle = "Scatter plot",
     caption = "Data: data.culture.gouv.fr / enquete du SIAF de 2018 aupres des archives departementales")
ggplotly(fig)







#essais interactif -> RATE
library(ggiraph) 
install.packages('ggiraph')
library(ggplot2) # install.packages('ggplot2')
library(dplyr) # install.packages('dplyr')
library(patchwork) # install.packages('patchwork')
library(tidyr) # install.packages('tidyr')
library(sf) # install.packages('sf')
set.seed(123)


library(ggiraph)
library(ggplot2)
library(dplyr)
library(patchwork)

data(mtcars)
mtcars$car <- rownames(mtcars)

data(ADsites)

# data_id in the aes mapping
p1 <- ggplot(ADsites, aes(Mise.en.ligne, Pages.en.ligne, tooltip = DEPARTEMENT, data_id = DEPARTEMENT)) +
  geom_point_interactive(size = 4)

# data_id in the aes mapping
p2 <- ggplot(ADsites, aes(x = reorder(DEPARTEMENT, Images.en.lignes.pourcentage), y = Images.en.lignes, tooltip = DEPARTEMENT, data_id = DEPARTEMENT)) +
  geom_col_interactive() +
  coord_flip()

combined_plot <- p1 + p2 + plot_layout(ncol = 2)

interactive_plot <- girafe(ggobj = combined_plot)
htmltools::save_html(interactive_plot, "HtmlWidget/multiple-ggiraph-1.html")

