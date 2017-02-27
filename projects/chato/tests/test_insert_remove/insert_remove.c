#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <poll.h>

typedef struct PollFds {
	struct pollfd *pfds;
	int poll_size;
	int poll_used;
	int(**handlers)(struct PollFds*, struct pollfd*);
} PollFds;

int insert(PollFds *ptr, int fd, short events, int(*handler)(PollFds *ptr, struct pollfd*)) 
{
	if (ptr->poll_used >= ptr->poll_size) {
		return -1;
	}

	ptr->pfds[ptr->poll_used].fd = fd;
	ptr->pfds[ptr->poll_used].events = events;
	ptr->handlers[ptr->poll_used] = handler;
	ptr->poll_used++;

	return 0;
}

int rm (PollFds *ptr, struct pollfd *pfds)
{
	int i = 0;
	while (i < ptr->poll_used) {
		if (&(ptr->pfds[i]) == pfds)
			break;

		i++;
	}

	if (i == ptr->poll_used)
		return -1;

	for (int j = i + 1; j < ptr->poll_used; j++) {
		ptr->pfds[j - 1] = ptr->pfds[j];
		ptr->handlers[j - 1] = ptr->handlers[j];
	} 

	ptr->poll_used--;

	return 0;
}

PollFds* make_fds(unsigned int size) 
{
	PollFds *ptr = malloc(sizeof(PollFds));
	ptr->poll_size = size;
	ptr->poll_used = 0;
	ptr->pfds = malloc(size * sizeof(struct pollfd));
	ptr->handlers = malloc(size * sizeof(void*));
	
	return ptr;
}

 
int test_insert_empty(void) 
{
	PollFds *ptr = make_fds(10);
	int used_before = ptr->poll_used;
	assert(insert(ptr, 4, 2, (void *)0xdeadbeef) == 0);	
	int used_after = ptr->poll_used;
	assert(used_after == (used_before + 1));
	assert(ptr->pfds[used_before].fd == 4);
	assert(ptr->pfds[used_before].events	== 2);
	assert(ptr->handlers[used_before] == (void *)0xdeadbeef);

	return 0;
}

//int test_insert_middle(void)

//int test_insert_full(void)

//int test_rm_empty(void)

//int test_rm_middle(void)

//int test_rm_full(void)

int main(void)
{
	return  test_insert_empty();
}
