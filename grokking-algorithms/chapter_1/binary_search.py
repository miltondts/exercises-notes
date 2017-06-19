#!/usr/bin/python

def binary_search(my_list, item):
    high = len(my_list) - 1
    low = 0

    while low <= high:
        mid = (high + low) / 2
        guess = my_list[mid]
        if guess == item:
            return mid
        elif guess > item:
            high = mid - 1
        else :
            low = mid + 1

    return None


my_list = [1, 3, 5, 7, 9]

print(binary_search(my_list, 3))
print(binary_search(my_list, 10))

