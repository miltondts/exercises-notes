
def find_lowest_cost_node(costs, processed):
    lowest_cost = float('inf')
    lowest_cost_node = None
    for node in costs:
        cost = costs[node]
        if lowest_cost > cost and node not in processed:
            lowest_cost = cost;
            lowest_cost_node = node

    return lowest_cost_node

# Create the graph hash table
graph = {}
graph['start'] = {}
graph['start']['a'] = 10
graph['a'] = {}
graph['a']['b'] = 20
graph['b'] = {}
graph['b']['c'] = 1
graph['b']['fin'] = 30
graph['c'] = {}
graph['c']['a'] = 1
graph['fin'] = {}

# Create the costs hash table
infinity = float('inf')
costs = {}
costs['a'] = graph['start']['a']
costs['b'] = infinity
costs['c'] = infinity
costs['fin'] = infinity

# Create the parents' hash table
parents = {}
parents['a'] = 'start'
parents['b'] = None
parents['c'] = None
parents['fin'] = None

# Create an array to account for all the processed nodes => if we have negative weights the Dijkstra algorithm is no longer valid
processed = []

node = find_lowest_cost_node(costs, processed)
print('Graph: {}').format(graph)
print('Costs: {}').format(costs)
print('Parents: {}').format(parents)
print('Processed {}').format(processed)
while node is not None:
    cost = costs[node]
    neighbors = graph[node]
    for n in neighbors.keys():
        new_cost = cost + neighbors[n]
        if costs[n] > new_cost:
            costs[n] = new_cost
            parents[n] = node
    processed.append(node)
    print('Costs: {}').format(costs)
    print('Parents: {}').format(parents)
    print('Processed {}').format(processed)
    node = find_lowest_cost_node(costs, processed)


