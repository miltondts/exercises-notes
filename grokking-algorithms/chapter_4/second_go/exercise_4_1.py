# Base case: no item

def test_sum(x):
    if len(x) == 0:
        return 0
    return x[0] + test_sum(x[1:])

def test_sum_v2(x):
    if len(x) == 1:
        return x[0]
    return x[0] + test_sum(x[1:])

test_list = [1, 2, 3, 5]
print(sum(test_list))
print(test_sum(test_list))
print(test_sum_v2(test_list))
