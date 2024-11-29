import sys
import networkx as nx

imported = nx.read_edgelist("graphs/test_graph_size_{0}.edgelist".format(sys.argv[1]), nodetype=int, data=[('weight', float)])

# for (u, v, wt) in imported.edges(data=True):
#     print(f"({u}, {v}, weight={wt['weight']})")
print("running size: {0}".format(sys.argv[1]))
result = nx.dijkstra_path(imported, 0, int(sys.argv[1]) - 1)
# print(result)