import networkx as nx
import random


sizes = [1500, 2000, 2500, 3000, 3500, 4000, 4500, 5000, 5500, 6000, 6500, 7000, 7500, 8000, 9500, 10000]

probabillity_of_edge = 0.002
directed = True

for nr_of_nodes in sizes:
    graph = nx.erdos_renyi_graph(n=nr_of_nodes, p=probabillity_of_edge, directed=directed)

    for (u, v) in graph.edges():
        graph[u][v]['weight'] = random.randint(1, 100)

    nx.write_edgelist(graph, "test_graph_size_{0}.edgelist".format(nr_of_nodes), data=['weight'])