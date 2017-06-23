import matplotlib.pyplot as plt


x = [10, 100, 1000, 10000]
y = [143, 405, 3682, 38295]

plt.title("Orders of growth when  reading lists")
plt.xlabel("Size of the list (# of elements)")
plt.ylabel("Time (ns)")
plt.plot(x, y)
plt.show()
