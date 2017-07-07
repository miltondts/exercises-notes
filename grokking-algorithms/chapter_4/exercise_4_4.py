#Base case: you only have one item and so it is the same as the guess
def binary_search(my_list, item):
    low = 0
    high = len(my_list) - 1
    if len(my_list) == 1:
        return item
    else:
        mid = (low + high) / 2
        guess = my_list[mid]
        if guess < item:
            low = mid + 1
        else:
            high = mid - 1

        return binary_search(my_list[low:high], item)



print(binary_search([33], 33))
print(binary_search([1, 2, 33, 42, 75], 42))
print(binary_search([1, 2, 33, 42, 75], 33))
print(binary_search([1, 2, 33, 42, 75], 1))
