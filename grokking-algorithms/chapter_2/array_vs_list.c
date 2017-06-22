#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define NELEM(a)	sizeof(a) / sizeof(a[0])
#define S_TO_NS(s)	(1000000000 * s)

void print_array(int *array, int num_elements)
{
	printf("Here's an array:\n");
	for (int i = 0; i < num_elements; i++) {
		printf("[%d] = %d\n", i, array[i]);
	}
}

void print_duration(struct timespec start, struct timespec end)
{
	int duration = 0;

	duration = S_TO_NS(end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec);
	if (duration < 0) {
		printf("Failed to calculate the time");
		return;
	}

	printf("Time spent: %d ns\n", duration);
}

void generate_random_array(void)
{
	srand(time(NULL)); // randomize the seed
	for(int i = 0; i < 10; i++) {
		printf("[%d] = %d\n", i, rand() % 20);
	}
}

int binary_search(int *array, int num_elements, int item)
{
	int low = 0, high = num_elements - 1, mid = 0, ret = -1;
	struct timespec start, end;

	ret = clock_gettime(CLOCK_MONOTONIC, &start);
	if (ret < 0)
		return ret;

	while (low <= high) {
		mid = (high + low) / 2;
		if (array[mid] == item) {
			ret = clock_gettime(CLOCK_MONOTONIC, &end);
			if (ret < 0)
				break;

			print_duration(start, end);
			return mid;
		}

		if (array[mid] < item)
			low = mid + 1;
		else
			high = mid - 1;
	}

	return ret;
}

int main(int argc, char *argv[])
{
	// Array
	int sorted_array1[] = {1, 2, 3, 5, 8, 12, 20};

	print_array(sorted_array1, NELEM(sorted_array1));
	// TODO: Generate a random array
	// TODO: Save the last number generated
	// TODO: Sort the random array
	// TODO: Print the time spent searching for the last generated number
	// TODO: Do the same with a linked list

	return 0;
}
