#include <stdint.h>
#include <stdio.h>

int binary_search(unsigned int *list, unsigned int num_elements,
		unsigned int item)
{
	unsigned int low = 0, high = num_elements - 1;
	unsigned int mid, guess;

	while(low <= high) {
		mid = (low + high) / 2;
		guess = list[mid];
		if (guess == item)
			return mid;
		else if (item < guess)
			high = mid - 1;
		else
			low = mid + 1;
	}

	return -1;
}

int main(int argc, char *argv[])
{
	unsigned int my_list[] = {1, 3, 5, 7, 9};
	unsigned int guess;

	guess = binary_search(my_list, sizeof(my_list) / sizeof(my_list[0]), 3);
	printf("Element: %d\n", guess);
	guess = binary_search(my_list, sizeof(my_list) / sizeof(my_list[0]), 10);
	printf("Element: %d\n", guess);

	return 0;
}
