//TODO: Rearrange code to return the duration of each operation
//TODO: Output duration to a CSV file as <operation>, <number_of_elements>, <duration>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#define NELEM(a)	sizeof(a) / sizeof(a[0])

#define free_s(p)							\
	do {									\
		if ((p) != NULL) {					\
			free(p);						\
			p = NULL;						\
		}									\
	} while(0)

void print_array(int *array, int num_elements)
{
	for (int i = 0; i < num_elements; i++) {
		printf("[%d] = %d\n", i, array[i]);
	}
}

void print_duration(struct timespec start, struct timespec end)
{
	int duration = 0;

	duration = 1000000000 * (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec);
	if (duration < 0) {
		printf("Failed to calculate the time\n");
		return;
	}

	printf("Time spent: %d ns\n", duration);
}

/**
 *	@brief	Generate an integer array with n random elements
 *
 *	@param[in]	n		Number of elements in the array
 *	@param[in]	max		Maximum for each element
 *
 *	@returns	pointer to the array
 */
int *generate_random_array(int n, int max)
{
	int *ptr;

	ptr = calloc(n, sizeof(int));
	if (!ptr) {
		perror("Failed to allocate memory");
		return NULL;
	}

	srand(time(NULL)); // randomize the seed
	for(int i = 0; i < n; i++) {
		ptr[i] = rand() % max;
	}

	return ptr;
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

			printf("Binary search: ");
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

/*
 *	@brief	Sort an array of n elements
 *
 *	@param[in]	array	Pointer to the array
 *	@param[in]	n	Number of elements in the array
 */
void bubble_sort(int **array, int n)
{
	int tmp;

	for (int i = 0; i < n - 1; i++) {
		for (int j = i; j < n; j++) {
			if ((*array)[i] > (*array)[j]) {
				tmp = (*array)[i];
				(*array)[i] = (*array)[j];
				(*array)[j] = tmp;
			}
		}
	}
}

void timed_read(int *array, int element)
{
	struct timespec start, end;
	int i;

	clock_gettime(CLOCK_MONOTONIC, &start);
	i = array[element];
	clock_gettime(CLOCK_MONOTONIC, &end);

	printf("Read:");
	print_duration(start, end);
}

int *insert_first_position(int *array, int n, int element)
{
	struct timespec start, end;
	int *new_array;

	clock_gettime(CLOCK_MONOTONIC, &start);
	new_array = calloc(n + 1, sizeof(int));
	new_array[0] = element;
	memcpy(&(new_array[1]), array, n * sizeof(int));
	free_s(array);
	clock_gettime(CLOCK_MONOTONIC, &end);
	printf("Insert to the first position:");
	print_duration(start, end);

	return new_array;
}

int *delete_first_position(int *array, int n)
{
	struct timespec start, end;
	int *new_array;

	clock_gettime(CLOCK_MONOTONIC, &start);
	new_array = calloc(n - 1, sizeof(int));
	memcpy(new_array, &(array[1]), (n - 1) * sizeof(int));
	free_s(array);
	clock_gettime(CLOCK_MONOTONIC, &end);
	printf("Delete from the first position:");
	print_duration(start, end);

	return new_array;
}

int main(int argc, char *argv[])
{
	struct node *list;
	int *array;
	int n, max, last;

	max = 42;

	for(n = 10; n < 100000; n = n * 10) {
		array = generate_random_array(n, max);
		last = array[n - 1];
		bubble_sort(&array, n);
		printf("n = %d\n", n);
		binary_search(array, n, last);
		timed_read(array, n - 1);
		array = insert_first_position(array, n, rand() % 20);
		array = delete_first_position(array, n);
		free_s(array);
	}

	return 0;
}
