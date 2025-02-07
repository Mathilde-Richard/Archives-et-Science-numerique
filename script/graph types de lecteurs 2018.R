
# Load ggplot2
library(ggplot2)
library(dplyr)

# Create Data
data <-read.csv("data/tableau ADlecteurstotal.csv")

# Basic piechart
ggplot(data, aes(x="", y=value, fill=types.de.lecteurs)) +
  geom_bar(stat="identity", width=1) +
  coord_polar("y", start=0)+
theme_void() +
  labs(title="types de lecteurs inscrit dans les archives departementales",
      subtitle = "total des lecteurs inscrit = 94 853",
      caption = "Data: data.culture.gouv.fr / enquete de 2018 aupres des archives departementales")


#Camembert avec les value dans les quartiers + la legendes

data <- data %>% 
  arrange(desc(types.de.lecteurs)) %>%
  mutate(prop = value / sum(data$value) *100) %>%
  mutate(ypos = cumsum(prop)- 0.5*prop )

# Basic piechart
ggplot(data, aes(x="", y=prop, fill=types.de.lecteurs)) +
  geom_bar(stat="identity", width=1) +
  coord_polar("y", start=0) +
  theme_void()+
  labs(title="types de lecteurs inscrit dans les archives departementales",
  subtitle = "total des lecteurs inscrit = 94 853",
  caption = "Data: data.culture.gouv.fr / enquete de 2018 aupres des archives departementales")+
  
  geom_text(aes(y = ypos, label = value), color = "white", size=3) 
