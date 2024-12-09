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

meanJoulesUsed_bellman_ford <- aggregate(data_frame_bellman_ford$JoulesUsed, list(data_frame_bellman_ford$DatasetSize), FUN=mean)
meanJoulesUsed_dijkstra <- aggregate(data_frame_dijkstra$JoulesUsed, list(data_frame_dijkstra$DatasetSize), FUN=mean)

meanJoulesUsed_bellman_ford$Algorithm <- "Bellman-Ford"
meanJoulesUsed_dijkstra$Algorithm <- "Dijkstra"

combined_data <- rbind(
  meanJoulesUsed_bellman_ford %>% rename(Nodes = Group.1, Joules = x),
  meanJoulesUsed_dijkstra %>% rename(Nodes = Group.1, Joules = x)
)


ggplot(combined_data, aes(x = Nodes, y = Joules, color = Algorithm)) +
  geom_line() +
  xlab("Nr. of nodes") +
  ylab("Joules used") + 
  ggtitle("Joules used by algorithms on different nr. of nodes") +
  scale_color_manual(values = c("Bellman-Ford" = "blue", "Dijkstra" = "red")) +
  scale_x_continuous(limits = c(1500, 10000), breaks = c(1500, 2000, 2500, 3000, 3500, 4000, 4500, 5000, 5500, 6000, 6500, 7000, 7500, 8000, 8500, 9000, 9500, 10000))