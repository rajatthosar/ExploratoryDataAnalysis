library("ggmap")
library("maptools")
library("maps")
register_google(key = Sys.getenv("GMapAPI")) 
visited <- c("SFO", "Chennai", "London", "Melbourne", "Lima,Peru", "Johannesbury, SA")
ll.visited <- geocode(visited)
visit.x <- ll.visited$lon
visit.y <- ll.visited$lat
map("world", fill=TRUE, col="white", bg="lightblue", ylim=c(-60, 90), mar=c(0,0,0,0))
points(visit.x,visit.y, col="red", pch=36)


data()