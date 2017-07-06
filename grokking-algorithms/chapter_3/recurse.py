#!/usr/bin/python

def countdown(n):
    print(n)
    if n <= 0:                      # Base case
        return
    else:
        countdown(n - 1)            # Recursive case

print("It's the final countdown!")
countdown(5)
