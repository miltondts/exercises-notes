#!/usr/sbin/python
#TODO:
# Add tests

import itertools
import random
import time

N = 10000
deck = list('abc') 

def get_occurences(ndecks, pattern):
	return len(list(filter(lambda x : x == pattern, ndecks)))
	
def nshuffle(n, shuffle, deck):
	t = time.time()
	decks = list()
	for i in range(n):
		decks.append(tuple(shuffle(deck)))

	elapsed = time.time() - t
	return decks, elapsed

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

def shuffle2(deck):
	N = len(deck)
	swapped = [False] * N
	while not all(swapped):
		i, j = random.randrange(N), random.randrange(N)
		swapped[i] = True
		swap(deck, i, j)

	return deck

def shuffle3(deck):
 	N = len(deck)
	for i in range(N):
		swap(deck, i, random.randrange(N))

	return deck

def swap(deck, i, j):
	deck[i], deck[j] = deck[j], deck[i]

algorithms = {
	"BAD SHUFFLE": bad_shuffle, 
	"GOOD SHUFFLE": good_shuffle,
	"SHUFFLE 2": shuffle2,
	"SHUFFLE 3": shuffle3,
	}
perm = list(itertools.permutations(deck))
for n in algorithms:
	ndecks, t = nshuffle(N, algorithms[n], deck)
	print '{}: {} seconds'.format(n, t)
	for i in range(len(perm)):
		print (perm[i], get_occurences(ndecks, perm[i]) * 100 / N)
