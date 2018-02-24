#!/usr/sbin/python
#TODO:
# Add tests
# Test how long each algorithm takes

import itertools
import random

N = 10000
deck = ['a', 'b', 'c']

def get_occurences(ndecks, pattern):
	return len(list(filter(lambda x : x == pattern, ndecks)))
	
def nshuffle(n, shuffle, deck):
	decks = []
	for i in range(n):
		tmp = shuffle(deck[:])
		decks.append(tuple(tmp))

	return decks

def good_shuffle(deck):
 	N = len(deck)
	for i in range(N - 1):
		swap(deck, i, random.randrange(i, N))

	return deck

def bad_shuffle(deck):
	N = len(deck)
	swapped = [False] * N
	while not all(swapped):
		i, j = random.randrange(N), random.randrange(N)
		swapped[i] = swapped[j] = True
		swap(deck, i, j)

	return deck

def swap(deck, i, j):
	deck[i], deck[j] = deck[j], deck[i]

algorithms = {"BAD SHUFFLE": bad_shuffle, "GOOD SHUFFLE": good_shuffle}
perm = list(itertools.permutations(deck))
for n in algorithms:
	ndecks = nshuffle(N, algorithms[n], deck)
	print n
	for i in range(len(perm)):
		print (perm[i], get_occurences(ndecks,perm[i]) * 100 / N)
