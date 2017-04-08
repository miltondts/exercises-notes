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
#define 	MINIMUM_NFD			2		/* Minimum number of file descriptors */
#define     TIMEOUT             10000   /* Connection timeout in miliseconds*/

typedef struct Users{
    char *alias;
    uint64_t ip;
    uint16_t port;
} User;

typedef struct PollFds {
    struct pollfd *pfds;    /*array of pollfd*/
	User **users; 			/* user information */
    int poll_size;          /*maximum number of file descriptors*/
    int poll_used;          /*number of used file descriptors*/
    int(**handlers)(struct PollFds*, int);   /*poll handler*/
    int(**error_handler)(int ret);   /*error handler*/

} PollFds;

PollFds* make_fds(unsigned int size) {
	PollFds *ptr = malloc(sizeof(PollFds));
	ptr->users = malloc(size * sizeof(User*));
	ptr->poll_size = size;
	ptr->poll_used = 0;
	ptr->pfds = malloc(size * sizeof(struct pollfd));
	ptr->handlers = malloc(size * sizeof(void*));
	ptr->error_handler = malloc(size * sizeof(void*));

	return ptr;
}

int default_error_handler(int ret) 
{
	return -1;
}

int insert(PollFds *ptr, int fd, short events, int(*handler)(PollFds *ptr,
			int i), int(*error_handler)(int ret), User *user) {
	if (ptr->poll_used >= ptr->poll_size) {
		return -1;
	}

	ptr->pfds[ptr->poll_used].fd = fd;
	ptr->pfds[ptr->poll_used].events = events;
	ptr->users[ptr->poll_used] = user;
	ptr->handlers[ptr->poll_used] = handler;
	ptr->error_handler[ptr->poll_used] = error_handler;
	ptr->poll_used++;

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

int handle_client(PollFds *ptr, int i)
{
	struct pollfd *pfds = &(ptr->pfds[i]);

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
	
	if (strncmp(buf, "/alias ", strlen("/alias ")) == 0) {
		ptr->users[i]->alias = (char*) malloc(sizeof(char) * ret);
		if (strcpy(ptr->users[i]->alias, buf + strlen("/alias ")) == NULL)
			return -1;

		return 0;
	};

    printf("%s said: %s", ptr->users[i]->alias, buf);
    
    return ret; 
}

int handle_stdin(PollFds *ptr, int i)
{
	struct pollfd *pfds = &(ptr->pfds[i]);
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
		if (strncmp("connect ", &msg[1], 8) == 0) {
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
				printf("Failed to convert the port number. errno = %s\n", 
						strerror(errno));
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

			char dest[MAX_STRLEN];
			dest[0] = '\0';
			strcat(dest, "/alias ");
			strcat(dest, ptr->users[i]->alias);
			if (write(sockfd, dest, strlen(dest)) < 0) 
				return -1;

			User *new_user = (User *) malloc(sizeof(User));
			new_user->ip = sa.sin_addr.s_addr;
			new_user->port = sa.sin_port;
			insert(ptr, sockfd, POLLIN, handle_client, default_error_handler, new_user);
			printf("Connected to %s:%d\n", ip, port);
		} else if (strncmp("remove ", &msg[1], 7) == 0) {
			if (ptr->poll_used <= MINIMUM_NFD) {
				printf("There are no client to remove.\n");
				return 0;
			} 

			//TODO: Need to remove the clients by name
		} else {
			printf("Failed to recognize command: %s", msg);
			return 0;
		}; 


	} else {
		//TODO: handle messages greater than the buffer length
		if (ptr->poll_used > MINIMUM_NFD) {
			for (int i = MINIMUM_NFD; i < ptr->poll_used; i++) {
				int n = write(ptr->pfds[i].fd, msg, ret);
				if (n < 0)
					return -1;

			}
		} else {
			printf("%s", msg);
		}
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
	user->alias = (char*) malloc((strlen(argv[1]) + 1)*sizeof(char));
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

int handle_new_connection_error(int ret)
{
	if (errno) {
		switch (errno) {
			case ENETDOWN:
				fprintf(stderr, "Error: Network is down.\n");
				return 0;
			case EINVAL:
				fprintf(stderr, "Error:  Socket is not listening for connections, or addrlen is invalid.\n");
				return 0;
			case EPERM:
				fprintf(stderr, "Error: Firewall rules forbid connection.\n");
				return 0;
			default: 
				return 0;
		}
	}

	return 0;
}

int handle_new_connection(PollFds *ptr, int i)
{
	struct pollfd *pfds = &(ptr->pfds[i]);
    pfds->revents = 0;
    struct sockaddr cli_addr;
    socklen_t cli_len;

    cli_len = sizeof(cli_addr);
    int cli_sfd = accept(pfds->fd, &cli_addr, &cli_len);
    if (cli_sfd < 0) {
        fprintf(stderr, "Failed to accept. errno: %s\n", strerror(errno));
        return -1; 
    }

	struct sockaddr_in *cli_addr_in = (struct sockaddr_in*) &cli_addr;

	User *user = (User *) malloc(sizeof(User));
	user->port = cli_addr_in->sin_port;
	user->ip = cli_addr_in->sin_addr.s_addr;
    insert(ptr, cli_sfd, POLLIN, handle_client, default_error_handler, user);
	char dest[MAX_STRLEN];
	dest[0] = '\0';
	strcat(dest, "/alias ");
	strcat(dest, ptr->users[i]->alias);
	if (write(cli_sfd, dest, strlen(dest)) < 0) 
		return -1;

    return 0;
}

int handle_events(PollFds *ptr)
{
    int ret = poll(ptr->pfds, ptr->poll_used, TIMEOUT);
    assert(ret >= 0);
    if (ret != 0) {
		int handler_ret;

        for (int i = 0; i < ptr->poll_used; i++) {
            if (ptr->pfds[i].revents & ptr->pfds[i].events) {
                if ((handler_ret = ptr->handlers[i](ptr, i)) < 0) {
					if (ptr->error_handler[i](ret) < -1)
						exit(EXIT_FAILURE);
                }

            }
        }
    }

    return ret;
}

int main(int argc, char *argv[])
{

    User *user = create_user(argc, argv);
    assert(user != NULL);

    char str[INET_ADDRSTRLEN];
    if (inet_ntop(AF_INET, &user->ip, str, INET_ADDRSTRLEN) == NULL){
        exit(EXIT_FAILURE);
    }

    printf("Alias: %s\nIP: %s\nport: %u\n", user->alias, str, user->port);
    int server_sfd = make_server(user->ip, user->port);
    assert(server_sfd > 0);

    PollFds *ptr = make_fds(MAX_CONNECTIONS);
    insert(ptr, STDIN_FILENO, POLLIN, handle_stdin, default_error_handler, user);
    insert(ptr, server_sfd, POLLIN, handle_new_connection, handle_new_connection_error, user);
    while(handle_events(ptr) >= 0);
    free(user);

    return 0;
}

