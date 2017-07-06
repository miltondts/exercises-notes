#!/usr/bin/python

def countdown(n):
    print(n)
    countdown(n - 1)

print("It's the final countdown!")
countdown(5)
