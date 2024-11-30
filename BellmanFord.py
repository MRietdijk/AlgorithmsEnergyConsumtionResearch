import sys
import networkx as nx

imported = nx.read_edgelist("graphs/test_graph_size_{0}.edgelist".format(sys.argv[1]), nodetype=int, data=[('weight', float)])

nx.bellman_ford_path(imported, 0, int(sys.argv[1]) - 1)