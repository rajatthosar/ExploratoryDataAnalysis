#install.packages("plotly")
#install.packages("ggplot2")
require(ggplot2)
library(plotly)

# Read the WHO_NREVSS_Clinical_Labs.csv file and extract the data in a dataframe
# The first line is a descriptor of the csv file hence we skip it
FluData<-read.csv(file.choose(), header = TRUE, sep = ",", 
                  skip = 1)

# We have downloaded a single .csv file which is used to pull the data for both plots
# The WHO_NREVSS_Clinical_Labs.csv file contains data from 40th week of 2017 to 
# -04th week of 2019. This large range helps us access the data from the same file
# -rather than reading separate files for each date range.

# Filter out the data for given conditions:
# 1. The data should be between 40th week 2018 to 4th week 2019 (both inclusive)
# 2. The data should be between 4th week 2018 to 4th week 2019 (both inclusive)
SynthFluData <- FluData[which((FluData$YEAR == 2018 & FluData$WEEK>39) | (FluData$YEAR == 2019 & FluData$WEEK < 5)),]
SynthFluDataAnnual <- FluData[which((FluData$YEAR == 2018 & FluData$WEEK>3) | (FluData$YEAR == 2019 & FluData$WEEK < 5)),]

# Creating a label vector to name the X Axis.
# We have first converted the year and week to numeric type to keep the dates 
# -chronologically consistent.
# Later, the same vectors are converted to character types to avoid the plot from
# -autosorting the axis labels
XAxis <-(as.character(SynthFluData$YEAR*100+SynthFluData$WEEK))
XAxisAnnual <-(as.character(SynthFluDataAnnual$YEAR*100+SynthFluDataAnnual$WEEK))

# Pull the data to plot in the graph in a single dataframe
Data <- data.frame(XAxis, SynthFluData$TOTAL.A, SynthFluData$TOTAL.B, SynthFluData$PERCENT.POSITIVE, SynthFluData$PERCENT.A, SynthFluData$PERCENT.B)
DataAnnual <- data.frame(XAxisAnnual, SynthFluDataAnnual$TOTAL.A, SynthFluDataAnnual$TOTAL.B, SynthFluDataAnnual$PERCENT.POSITIVE, SynthFluDataAnnual$PERCENT.A, SynthFluDataAnnual$PERCENT.B)

# Creating 2 Y axes for the plots.
# The axis y1 is reference axis for: Total A, Total B
y1 <- list(
  #overlaying = "y",
  side = "left",
  title = "Number of Positive Specimens",
  rangemode = 'tozero'
)

# The axis y2 is reference axis for: Percent Positive, Percent Positive A, Percent Positive B
y2 <- list(
  overlaying = "y",
  side = "right",
  title = "Percent Positive",
  rangemode = 'tozero'
)

# Create the plots from passed data with Plotly library
p <- plot_ly(Data, x = ~XAxis, y=~SynthFluData$TOTAL.B, type='bar', name='B', marker=list(color='rgb(0,170,0)')) %>%
  add_trace(y=~SynthFluData$TOTAL.A, name='A', marker=list(color='rgb(240,240,0)')) %>%
  add_lines(y=~SynthFluData$PERCENT.POSITIVE, name='Percent Positive',yaxis='y2',color=I('black')) %>%
  add_lines(y=~SynthFluData$PERCENT.A, name='% Positive Flu A',yaxis='y2',color=I('orange')) %>%
  add_lines(y=~SynthFluData$PERCENT.B, name='% Positive Flu B',yaxis='y2',color=I('green')) %>%
  layout(title="Influenza Positive Tests Reported to CDC by U.S. Clinical Laboratories,<br>National Summary, 2018-2019 Season<br> from 201840 to 201904",margin =list(b=80,r=50),xaxis=list(title='Week',tickangle = -65), yaxis=y1, yaxis2=y2, barmode = 'stack', legend = list(x = 0.15, y = 0.9))

pAnnual <- plot_ly(DataAnnual, x = ~XAxisAnnual, y=~SynthFluDataAnnual$TOTAL.B, type='bar', name='B', marker=list(color='rgb(0,170,0)')) %>%
  add_trace(y=~SynthFluDataAnnual$TOTAL.A, name='A', marker=list(color='rgb(240,240,0)')) %>%
  add_lines(y=~SynthFluDataAnnual$PERCENT.POSITIVE, name='Percent Positive',yaxis='y2',color=I('black')) %>%
  add_lines(y=~SynthFluDataAnnual$PERCENT.A,name='% Positive Flu A',yaxis='y2',color=I('orange')) %>%
  add_lines(y=~SynthFluDataAnnual$PERCENT.B, name='% Positive Flu B',yaxis='y2',color=I('green')) %>%
  layout(title="Influenza Positive Tests Reported to CDC by U.S. Clinical Laboratories,<br>National Summary, 2018-2019 Season<br> from 201804 to 201904",margin =list(b=80,r=50),xaxis=list(title='Week',tickangle = -65), yaxis=y1, yaxis2=y2, barmode = 'stack', legend = list(x = 0.15, y = 0.9))


#Display both graphs
p
pAnnual
