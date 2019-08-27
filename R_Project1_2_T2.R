#install.packages("plotly")
#install.packages("ggplot2")
require(ggplot2)
library(plotly)

FluData<-read.csv(file.choose(), header = TRUE, sep = ",", 
                  skip = 1)

SynthFluData <- FluData[which((FluData$YEAR == 2018 & FluData$WEEK>3) | (FluData$YEAR == 2019 & FluData$WEEK < 5)),]
XAxis <-(as.character(SynthFluData$YEAR*100+SynthFluData$WEEK))
Data <- data.frame(XAxis, SynthFluData$A..Subtyping.not.Performed., S0ynthFluData$A..2009.H1N1., SynthFluData$A..H3., SynthFluData$H3N2v, SynthFluData$B, SynthFluData$BVic, SynthFluData$BYam)

p <- plot_ly(Data, x = ~XAxis, y=~SynthFluData$BYam, type='bar', name='B (Yamagata lineage)', color=I('dark green')) %>%
  add_trace(y=~SynthFluData$BVic, name='B (Victoria lineage)', color=I('light green')) %>%
  add_trace(y=~SynthFluData$B, name='B (lineage not performed)',color=I('green')) %>%
  add_trace(y=~SynthFluData$H3N2v, name='H3N2v',color=I('purple')) %>%
  add_trace(y=~SynthFluData$A..H3., name='A (H3N2)',color=I('red')) %>%
  add_trace(y=~SynthFluData$A..2009.H1N1., name='A (H1N1)pdm09',color=I('gold')) %>%
  add_trace(y=~SynthFluData$A..Subtyping.not.Performed., name='A (subtyping not performed)',color=I('yellow')) %>%
  layout(margin =list(b=80),xaxis=list(title='Week',tickangle = -65),yaxis=list(title='Number of positive specimens'),barmode = 'stack')
p
