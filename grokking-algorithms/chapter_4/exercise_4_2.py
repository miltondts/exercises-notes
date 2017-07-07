# Divide and conquer:
# The base case is the same as previously (when the array is empty or has only
# one item)
# Then we just need to move closer to our base case and reduce the size of the
# array on each iteration
def count(array):
    if len(array) == 0:
        return 0
    else:
        new_array = array[1:]
        return 1 + count(new_array)

print(count([1 , 2, 33, 42, 127]))
print(count([]))
print(count([33, 42, 127]))
