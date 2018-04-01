# -*- coding: utf-8 -*-
"""
pydot example 1
@author: Federico Cáceres
@url: http://pythonhaven.wordpress.com/2009/12/09/generating_graphs_with_pydot
"""
import pydot # import pydot or you're not going to get anywhere my friend :D

# first you create a new graph, you do that with pydot.Dot()
graph = pydot.Dot(graph_type='graph')

# the idea here is not to cover how to represent the hierarchical data
# but rather how to graph it, so I'm not going to work on some fancy
# recursive function to traverse a multidimensional array...
# I'm going to hardcode stuff... sorry if that offends you

# let's add the relationship between the king and vassals
edge = pydot.Edge("king", "lord")
# and we obviosuly need to add the edge to our graph
graph.add_edge(edge)

# now let us add some vassals
# we create new edges, now between our previous lords and the new vassals
# let us create two vassals for each lord
edge = pydot.Edge("lord", "vassal")
graph.add_edge(edge)

edge = pydot.Edge("lord", "vassal2")
graph.add_edge(edge)
# ok, we are set, let's save our graph into a file
graph.write_png('example1_graph.png')

# and we are done!
