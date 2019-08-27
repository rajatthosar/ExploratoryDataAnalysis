# install.packages("devtools")
#devtools::install_github("wmurphyrd/fiftystater")
#install.packages("RColorBrewer")

library(ggplot2)
library(fiftystater)
library(stringr)
library(RColorBrewer)

data("fifty_states")

SynthSprFluData<-read.csv(file.choose(), header = TRUE, sep = ",")
SynthSprFluData<-SynthSprFluData[-c(9,52,53,54),]

p <- ggplot(SynthSprFluData, aes(map_id = tolower(SynthSprFluData$STATENAME))) + 
  # map points to the fifty_states shape data
  geom_map(aes(fill = ACTIVITYESTIMATE, map = fifty_states) + 
  expand_limits(x = fifty_states$long, y = fifty_states$lat) +
  coord_map() +
  scale_fill_brewer(palette = "RdYlGn",labels=LevelLabels, direction = -1) +
  borders(database = "state", regions = ".", fill = NA,
          colour = "black", xlim = NULL, ylim = NULL)+
   scale_x_continuous(breaks = NULL) + 
   scale_y_continuous(breaks = NULL)
   # labs(x = "", y = "",title="2018-19 Influenza asdfsadf Week 4 ending Jan 27, 2019") +
   # guides(fill=guide_legend(title="ILI Activity Level")) +
   # theme(legend.position = "right",
   #       panel.background = element_rect(fill='skyblue', colour = 'skyblue'))
p
