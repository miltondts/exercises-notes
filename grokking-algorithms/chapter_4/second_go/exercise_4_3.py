# Base case: 2 elements
def test_max(array):
    if (len(array) == 2):
        return array[0] if array[0] > array[1] else array[1]
    subarray = test_max(array[1:])
    return array[0] if array[0] > subarray else subarray


test_list = [2, 5, 13, 21, 8, 3, 1]
print(max(test_list))
print(test_max(test_list))
