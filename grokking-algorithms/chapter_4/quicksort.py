def quicksort(array):
    if len(array) < 2:
        return array

    pivot = array[0]
    under = filter(lambda x: x < pivot, array)
    over = filter(lambda x: x > pivot, array)
    return quicksort(under) + [pivot] + quicksort(over)


array = [2, 5, 13, 21, 8, 3, 1]
print (quicksort(array))

