from collections import deque

graph = {}
graph['you'] = ['alice', 'bob', 'claire']
graph['bob'] = ['anuj', 'peggy']
graph['alice'] = ['peggy']
graph['claire'] = ['thom', 'jonny']
graph['anuj'] = []
graph['peggy'] = []
graph['thom'] = []
graph['jonny'] = []

def is_mango_seller(name):
    return name[-1] == 'm'

def breadth_first(search_queue):
    while search_queue:
        person = search_queue.popleft()
        if is_mango_seller(person):
            print('{} is a mango seller').format(person)
        else:
            search_queue += graph[person]
    return False

search_queue = deque()
search_queue += graph['you']
breadth_first(search_queue)

