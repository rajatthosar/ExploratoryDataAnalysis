# install.packages("devtools")
devtools::install_github("wmurphyrd/fiftystater")
#install.packages("RColorBrewer")

library(ggplot2)
library(fiftystater)
library(stringr)
library(RColorBrewer)

data("fifty_states")

FluData<-read.csv(file.choose(), header = TRUE, sep = ",")
SynthFluData <- FluData[which(FluData$WEEK==4),]
SynthFluData$ACTIVITY.LEVEL <- as.character(SynthFluData$ACTIVITY.LEVEL)
LevelLabels <- c("Level 1","Level 2","Level 3","Level 4","Level 5","Level 6","Level 7","Level 8","Level 9","Level 10")

for (obsIdx in 1:length(SynthFluData$ACTIVITY.LEVEL)) {
  tmpString<- as.character(SynthFluData$ACTIVITY.LEVEL[obsIdx])
  SynthFluData$ACTIVITY.LEVEL[obsIdx]<-substr(tmpString,7,str_length(tmpString))
}

SynthFluData$ACTIVITY.LEVEL <- as.numeric(SynthFluData$ACTIVITY.LEVEL)

p <- ggplot(SynthFluData, aes(map_id = tolower(SynthFluData$STATENAME))) + 
  # map points to the fifty_states shape data
  geom_map(aes(fill = as.factor(ACTIVITY.LEVEL)), map = fifty_states) + 
  expand_limits(x = fifty_states$long, y = fifty_states$lat) +
  coord_map() +
  scale_fill_brewer(palette = "RdYlGn",labels=LevelLabels, direction = -1) +
  borders(database = "state", regions = ".", fill = NA,
          colour = "black", xlim = NULL, ylim = NULL)+
  scale_x_continuous(breaks = NULL) + 
  scale_y_continuous(breaks = NULL) +
  labs(x = "", y = "",title="2018-19 Influenza Season Week 4 ending Jan 26, 2019") + 
  guides(fill=guide_legend(title="ILI Activity Level"))+
  theme(legend.position = "right",
        panel.background = element_rect(fill='skyblue', colour = 'skyblue'))
p
