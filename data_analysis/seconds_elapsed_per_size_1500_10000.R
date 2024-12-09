library(tidyverse)
setwd('~/Documents/School/jaar_4/premaster/Q2/Onderzoeks_methoden/graph/results/')

bellman_ford_files <-
  list.files(path = "./bellman_ford", pattern = "*.csv")
dijkstra_files <- list.files(path = "./dijkstra", pattern = "*.csv")
# floyd_warshall_files <- list.files(path = "floyd_warshall", pattern = "*.csv")

setwd('~/Documents/School/jaar_4/premaster/Q2/Onderzoeks_methoden/graph/results/bellman_ford')  
data_frame_bellman_ford <- do.call(rbind, lapply(bellman_ford_files, read.csv))
setwd('~/Documents/School/jaar_4/premaster/Q2/Onderzoeks_methoden/graph/results/dijkstra')
data_frame_dijkstra <- do.call(rbind, lapply(dijkstra_files, read.csv))
setwd('~/Documents/School/jaar_4/premaster/Q2/Onderzoeks_methoden/graph/results/floyd_warshall')
# data_frame_floyd_warshall <- do.call(rbind, lapply(floyd_warshall_files, read.csv))

meanJoulesUsed_bellman_ford <- aggregate(data_frame_bellman_ford$SecondsElapsed, list(data_frame_bellman_ford$DatasetSize), FUN=mean)
meanJoulesUsed_dijkstra <- aggregate(data_frame_dijkstra$SecondsElapsed, list(data_frame_dijkstra$DatasetSize), FUN=mean)
# meanJoulesUsed_floyd_warshall <- aggregate(data_frame_floyd_warshall$SecondsElapsed, list(data_frame_floyd_warshall$DatasetSize), FUN=mean)


meanJoulesUsed_bellman_ford$Algorithm <- "Bellman-Ford"
meanJoulesUsed_dijkstra$Algorithm <- "Dijkstra"
# meanJoulesUsed_floyd_warshall$Algorithm <- "Floyd-Warshall"

combined_data <- rbind(
  meanJoulesUsed_bellman_ford %>% rename(Nodes = Group.1, Joules = x),
  meanJoulesUsed_dijkstra %>% rename(Nodes = Group.1, Joules = x)
  # meanJoulesUsed_floyd_warshall %>% rename(Nodes = Group.1, Joules = x)
)


ggplot(combined_data, aes(x = Nodes, y = Joules, color = Algorithm)) +
  geom_line() +
  xlab("Nr. of nodes") +
  ylab("Seconds elapsed") + 
  ggtitle("Seconds elapsed while running algorithms on different nr. of nodes") +
  scale_color_manual(values = c("Bellman-Ford" = "blue", "Dijkstra" = "red")) +
  scale_x_continuous(limits = c(0, 1000), breaks = c(10, 50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 1000))