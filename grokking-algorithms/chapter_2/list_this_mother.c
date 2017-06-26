#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define NELEM(a)	sizeof(a) / sizeof(a[0])

#define free_s(p)							\
	do {									\
		if ((p) != NULL) {					\
			free(p);						\
			p = NULL;						\
		}									\
	} while(0)

struct node {
	int element;
	struct node *next;
};

void print_list(struct node my_list)
{
	for (struct node *list = &my_list; list->next != NULL; list = list->next) {
		printf("%d\n", list->element);
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

struct node *simple_search(struct node my_list, int n)
{
	struct timespec start, end;

	clock_gettime(CLOCK_MONOTONIC, &start);
	for(struct node *list = &my_list; list->next != NULL; list = list->next) {
		if (list->element == n) {
			clock_gettime(CLOCK_MONOTONIC, &end);
			print_duration(start, end);
			return list;
		}
	}

	return NULL;
}

struct node *generate_random_list(int n, int max)
{
	struct node *ptr = NULL;

	srand(time(NULL));
	for (int i = 0; i < n; i++) {
		struct node *p;

		p = malloc(sizeof(struct node));
		if (!p) {
			perror("Failed to allocate memory");
			return NULL;
		}

		p->element = rand() % max;
		p->next = ptr;
		ptr = p;
	}

	return ptr;
}

void timed_read(struct node list, int iterations)
{
	struct node *p;
	struct timespec start, end;

	clock_gettime(CLOCK_MONOTONIC, &start);
	p = list.next;
	for(int i = 0; i < iterations; i++) {
		p = p->next;
	}

	clock_gettime(CLOCK_MONOTONIC, &end);
	printf("Read:");
	print_duration(start, end);
}

void free_list(struct node *my_list)
{
	struct node *list = my_list, *tmp = NULL;

	while (list->next != NULL) {
		tmp = list;
		list = list->next;
		free_s(tmp);
	}

	free_s(list);
}

struct node *insert_first_position(struct node *my_list, int element)
{
	struct node *list = NULL;
	struct timespec start, end;

	clock_gettime(CLOCK_MONOTONIC, &start);
	list = malloc(sizeof(struct node));
	list->element = element;
	list->next = my_list;
	clock_gettime(CLOCK_MONOTONIC, &end);
	printf("Insert to the first position:");
	print_duration(start, end);

	return list;
}

struct node *delete_first_position(struct node *my_list)
{
	struct timespec start, end;
	struct node *tmp = NULL;

	clock_gettime(CLOCK_MONOTONIC, &start);
	tmp = my_list->next;
	free_s(my_list);
	clock_gettime(CLOCK_MONOTONIC, &end);
	printf("Delete from the first position:");
	print_duration(start, end);

	return tmp;
}

int main(int argc, char *argv[])
{
	struct node *list;
	int *array;
	int n, max, last;

	n = 10;
	max = 42;
	for (n = 10; n < 100000; n = n * 10) {
		list = generate_random_list(n, max);
		if (!list) {
			perror("No list");
			exit(EXIT_FAILURE);
		}

		printf("n = %d\n", n);
		timed_read(*list, n - 1);
		list = insert_first_position(list, rand() % 20);
		list = delete_first_position(list);
		free_list(list);
	}

	return 0;
}

