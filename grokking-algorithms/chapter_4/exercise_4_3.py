# base case: if you have only one element, it is the maximum element of the list
def array_max(array):
    if len(array) == 1:
        return array[0]
    else:
        if array[0] > array[1]:
            array.pop(1)
        else:
            array.pop(0)
        return array_max(array)


print(array_max([1]))
print(array_max([1, 2]))
print(array_max([2, 1]))
print(array_max([1, 2, 3]))
print(array_max([2, 3, 1]))
print(array_max([42, 1, 2, 3, 33]))
print(array_max([2, 3, 33, 42, 1]))
print(array_max([2, 3, 33, 42, 1, 77]))
