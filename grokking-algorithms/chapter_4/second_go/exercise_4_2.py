def test_count(x):
    if len(x) == 0:
        return 0
    return 1 + test_count(x[1:])

test_list = [1, 2, 3, 5, 8, 13, 21, 34, 55]
print(test_count(test_list))
print(len(test_list))
