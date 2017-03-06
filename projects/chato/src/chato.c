#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <assert.h>
#include <errno.h>
#include <poll.h>
#include <signal.h>
#include <string.h>
#include <unistd.h>

#define     MAX_CONNECTIONS     8       /* Maximum number of connections */
#define     MAX_STRLEN          255     /* Maximum string length */
#define     TIMEOUT             10000   /* Connection timeout in miliseconds*/

typedef struct Users{
    char *alias;
    uint32_t ip;
    uint16_t port;
} User;

typedef struct PollFds {
    struct pollfd *pfds;    /*array of pollfd*/
    int poll_size;          /*maximum number of file descriptors*/
    int poll_used;          /*number of used file descriptors*/
    int(**handlers)(struct PollFds*, struct pollfd*);   /*poll handler*/

} PollFds;

PollFds* make_fds(unsigned int size) {
	PollFds *ptr = malloc(sizeof(PollFds));
	ptr->poll_size = size;
	ptr->poll_used = 0;
	ptr->pfds = malloc(size * sizeof(struct pollfd));
	ptr->handlers = malloc(size * sizeof(void*));
	printf("size of handle_stdin = %ld\n", sizeof(void*));

	return ptr;
}

int insert(PollFds *ptr, int fd, short events, int(*handler)(PollFds *ptr, struct pollfd*)) {
	if (ptr->poll_used >= ptr->poll_size) {
		return -1;
	}

	ptr->pfds[ptr->poll_used].fd = fd;
	ptr->pfds[ptr->poll_used].events = events;
	ptr->handlers[ptr->poll_used] = handler;
	ptr->poll_used++;
	printf("Inserted. \n");

	return 0;
}

int rm(PollFds *ptr, struct pollfd *pfds) 
{
	int i = 0;
	while(i < ptr->poll_used) {
		if (&(ptr->pfds[i]) == pfds)
			break;

		i++;
	}

	if (i == ptr->poll_used) {
		return -1;
	}

	for (int j = i + 1; j < ptr->poll_used; j++) {
		ptr->pfds[j - 1] = ptr->pfds[j];
		ptr->handlers[j - 1] = ptr->handlers[j];
	}

	ptr->poll_used--;

	return 0;
}

int handle_client(PollFds *ptr, struct pollfd *pfds)
{
	errno = 0;
    pfds->revents = 0;
    char buf[MAX_STRLEN];
    int ret = read(pfds->fd, buf, sizeof(buf));
    if (ret <= 0) {
    	printf("Client disconnected.\n");
		rm(ptr, pfds);
        return ret;
    }

    buf[ret] = '\0';
    printf("Client said: %s", buf);
    
    return ret; 
}

int handle_stdin(PollFds *ptr, struct pollfd *pfds)
{
	errno = 0;
    pfds->revents = 0;
    char msg[MAX_STRLEN];
    int ret = 0;
    
    ret = read(pfds->fd, msg, sizeof(msg));
    if (ret < 0) {
		return ret;
    }
    
    msg[ret] = '\0';
    if (msg[0] == '/') {
		//TODO: Add remove command in order to remove clients
		if (strncmp("connect ", &msg[1], 8) != 0) {
			printf("Failed to convert string to network address.\n");
			return 0;
		}; 

		int ip_length = 0;
		int ip_index = 9;
		while (msg[ip_length + ip_index] != ' ') {
			ip_length ++;
		}

		char ip[ip_length + 1];
		memcpy(ip, &msg[ip_index], ip_length + 1);
		ip[ip_length] = '\0';

		struct sockaddr_in sa;
		memset((char *) &sa, '\0', sizeof(sa));
		sa.sin_family = AF_INET;
        if (inet_pton(AF_INET, ip, &(sa.sin_addr)) != 1) {
			printf("Failed to convert string to network address.\n");
			return -1;
		}

		int port_index = ip_index + ip_length + 1;
		char *endptr;
		int port = strtoul(&(msg[port_index]), &endptr, 10);
		if(errno != 0 || (&(msg[ret - 1]) != endptr)) {
			printf("Failed to convert the port number. errno = %s\n", strerror(errno));
			printf("Port = %d\n", sa.sin_port);
			return -1;
    	}

		sa.sin_port = htons(port);
		int sockfd = socket(AF_INET, SOCK_STREAM, 0);
		if(sockfd < 0) {
			printf("Failed to open socket.\n");
			return -1;
		}

		if (connect(sockfd, (struct sockaddr *) &sa, sizeof(sa)) < 0){
			printf("Could not connect to %s:%d\n", ip, sa.sin_port);
			return 0;
		}

    	insert(ptr, sockfd, POLLIN, handle_client);
		printf("Connected to %s:%d\n", ip, port);

	} else {
		printf("%s", msg);
		//TODO: handle messages greater than the buffer length
		//TODO: send messages to clients
	}

	return 0;
}


int make_server(uint32_t ip, uint16_t port)
{
	int sfd = socket(AF_INET, SOCK_STREAM, 0);
	if (sfd < 0)
		return sfd;

	struct sockaddr_in addr;
	memset(&addr, '\0', sizeof(addr));
	addr.sin_family = AF_INET;
	addr.sin_addr.s_addr = INADDR_ANY;
	addr.sin_port = htons(port);
	if (bind(sfd, (struct sockaddr*) &addr, sizeof(addr)) < 0)
		return -1;


	if (listen(sfd, 0) < 0)
		return -1;

	return sfd;
}

User* create_user(int argc, char *argv[])
{
	if(argc < 3) {
		fprintf(stdout, "Usage: chato ALIAS IP PORT\n");
		return NULL;
	}

	User* user;
	user = (User*) malloc(sizeof(User));
	user->alias = (char*) malloc(strlen(argv[1]) + 1);
	printf("strlen = %ld\n", strlen(argv[1]));
	strncpy(user->alias, argv[1], strlen(argv[1]));
	user->alias[strlen(argv[1])] = '\0';
	if(inet_pton(AF_INET, argv[2], &user->ip) <= 0) {
		free(user->alias);
		free(user);
		return NULL;
	}

	errno = 0;
	char *endptr;
    user->port = strtoul(argv[3], &endptr, 10);
    if(errno != 0 || (argv[3] == endptr)) {
        free(user->alias);
        free(user);
        return NULL;
    }

    return user;
}


int handle_new_connection(PollFds *ptr, struct pollfd *pfds)
{
    pfds->revents = 0;
    struct sockaddr cli_addr;
    socklen_t cli_len;

    cli_len = sizeof(cli_addr);
    int cli_sfd = accept(pfds->fd, &cli_addr, &cli_len);
    if (cli_sfd < 0) {
        fprintf(stderr, "Failed to accept. errno: %s\n", strerror(errno));
        return 0; //TODO: Redefine what to do in case of error
    }

    insert(ptr, cli_sfd, POLLIN, handle_client);
    fprintf(stdout, "cli_sfd= %d\n", cli_sfd);
    return 0;
}

int handle_events(PollFds *ptr)
{
    int ret = poll(ptr->pfds, ptr->poll_used, TIMEOUT);

    assert(ret >= 0);
    if (ret != 0) {
        for (int i = 0; i < ptr->poll_used; i++) {
            if (ptr->pfds[i].revents & ptr->pfds[i].events) {
                if (ptr->handlers[i](ptr, &(ptr->pfds[i])) < 0) {
                    exit(EXIT_FAILURE);
                }

            }
        }
    }

    return ret;
}

int main(int argc, char *argv[])
{
    User* user;

    user = create_user(argc, argv);
    assert(user != NULL);

    char str[INET_ADDRSTRLEN];
    if (inet_ntop(AF_INET, &user->ip, str, INET_ADDRSTRLEN) == NULL){
        exit(EXIT_FAILURE);
    }

    printf("Alias: %s\nIP: %s\nport: %u\n", user->alias, str, user->port);
    int server_sfd = make_server(user->ip, user->port);
    assert(server_sfd > 0);

    PollFds *ptr = make_fds(MAX_CONNECTIONS);
    insert(ptr, STDIN_FILENO, POLLIN, handle_stdin);
    insert(ptr, server_sfd, POLLIN, handle_new_connection);
    while(handle_events(ptr) >= 0);
    free(user);

    return 0;
}

