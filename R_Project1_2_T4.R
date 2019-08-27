#install.packages("plotly")
#install.packages("ggplot2")
require(ggplot2)
library(plotly)
library(tidyr)
library(plyr)

# Read the Weekly.csv file and skip the 1st row which describes the table
FluPedData<-read.csv(file.choose(), header = TRUE, sep = ",", 
                  skip = 1)

# Set a vector of label values for X axis
XAxis <- as.character(FluPedData$WEEK.NUMBER)

# Here, we have extracted the unique values of seasons present in the data
# The primary reason to do this, is to find the sum of FluPedData$NO..OF.DEATHS
# -for every season. 
# This implementation is highly scalable and can sustain addition or removal of
# -seasons from the data to yield the correct output every time
UniqueSeasons <-as.character(unique(FluPedData$SEASON))

# This loop segregates all of the FluPedData$NO..OF.DEATHS by seasons and
# -calculates the sum for each season which is stored in an accumulator
for (seasonIdx in (1:length(UniqueSeasons))) {
  accumulator[seasonIdx] <- sum(FluPedData$NO..OF.DEATHS[which(as.character(FluPedData$SEASON)==UniqueSeasons[seasonIdx])])
}

# Using plotly, we stack up the Current Week and Previous Week death count
p <- plot_ly(FluPedData, x = ~XAxis, y=~FluPedData$CURRENT.WEEK.DEATHS, type='bar', name='Deaths reported Previous Week', marker=list(color='cyan')) %>%
  add_trace(y=~FluPedData$PREVIOUS.WEEK.DEATHS, name='Deaths Reported Current Week', marker=list(color='darkgreen')) %>%
  add_text(x = "2016-12",y=25,text=as.character(UniqueSeasons[1]),showlegend=FALSE,marker=list(color='white'), textfont=list(color='black', size=18))%>%
  add_text(x = "2017-06",y=25,text=as.character(UniqueSeasons[2]),showlegend=FALSE,marker=list(color='white'), textfont=list(color='black', size=18))%>%
  add_text(x = "2018-03",y=25,text=as.character(UniqueSeasons[3]),showlegend=FALSE,marker=list(color='white'), textfont=list(color='black', size=18))%>%
  add_text(x = "2019-07",y=25,text=as.character(UniqueSeasons[4]),showlegend=FALSE,marker=list(color='white'), textfont=list(color='black', size=18))%>%
  add_text(x = "2016-12",y=23,text="Number of deaths ",showlegend=FALSE,marker=list(color='white'), textfont=list(color='black', size=14))%>%
  add_text(x = "2017-06",y=23,text="Number of deaths ",showlegend=FALSE,marker=list(color='white'), textfont=list(color='black', size=14))%>%
  add_text(x = "2018-03",y=23,text="Number of deaths ",showlegend=FALSE,marker=list(color='white'), textfont=list(color='black', size=14))%>%
  add_text(x = "2019-07",y=23,text="Number of deaths ",showlegend=FALSE,marker=list(color='white'), textfont=list(color='black', size=14))%>%
  add_text(x = "2016-12",y=21,text=paste("reported = ",accumulator[1]),showlegend=FALSE,marker=list(color='white'), textfont=list(color='black', size=14))%>%
  add_text(x = "2017-06",y=21,text=paste("reported = ",accumulator[2]),showlegend=FALSE,marker=list(color='white'), textfont=list(color='black', size=14))%>%
  add_text(x = "2018-03",y=21,text=paste("reported = ",accumulator[3]),showlegend=FALSE,marker=list(color='white'), textfont=list(color='black', size=14))%>%
  add_text(x = "2019-07",y=21,text=paste("reported = ",accumulator[4]),showlegend=FALSE,marker=list(color='white'), textfont=list(color='black', size=14))%>%
  layout(title = "<b>Number of Influenza-Associated Pediatric Deaths <br>by Week of Death:</b> 2015-16 season to present",margin =list(r=50,t=100),xaxis=list(title='<b>Week of Death</b>',tickangle = -90), yaxis=list(title="<b>Number of deaths</b>",range=c(0,30)),barmode = 'stack', legend = list(xanchor="center", x = 0.5, y=-0.3, orientation = 'h',bordercolor = "black", borderwidth = 2))
p

