from functools import reduce

def sum(array):
    if len(array) == 0:                     # Base case
        return 0
    else:                                   # Recursive case
        return array.pop() + sum(array)

# This is aggressive as hell because I'm emptying the list as I am adding the values
my_array = [1, 2, 3, 4]
print(sum(my_array))


# Or I could just do this:
my_array = [1, 2, 3, 4]
print(reduce(lambda x, y: x + y, my_array))
