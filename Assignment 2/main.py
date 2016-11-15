from GraphAlgo.GraphAlgo import *
from KSquareTree.KSquareTree import KSquareTree
from COO.COO import COO


graph = [[0, 1, 1, 1],
         [1, 0, 0, 1],
         [1, 0, 0, 0],
         [1, 1, 0, 0]]

k2tree = KSquareTree(2)
k2tree.create(graph)

coo = COO()
coo.create(graph)

print bfs(k2tree, 0, 3)
print bron_kerbosch(k2tree)
print mst(k2tree)
print shortest_path(k2tree, 0)
print betweeness_centrality(k2tree)
print global_cluster_coeff(k2tree)

print bfs(coo, 0, 3)
print bron_kerbosch(coo)
print mst(coo)
print shortest_path(coo, 0)
print betweeness_centrality(coo)
print global_cluster_coeff(coo)