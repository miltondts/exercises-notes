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
    int(**handlers)(struct pollfd*);   /*poll handler*/

} PollFds;

int handle_stdin(struct pollfd *pfds)
{
    pfds->revents = 0;
    char msg[255];
    int ret = 0;
    
    ret = read(pfds->fd, msg, sizeof(msg));
	if (ret < 0) {
		return ret;
	} else if (msg[0] == '/') {
		if (strncmp("connect ", msg[1], 8) != 0) {
			return -1;
		}; 

		int ip_length = 0;
		int ip_index = 9;
		while (msg[ip_length + ip_index] != ' ') {
			ip_length ++;
		}

		char ip[ip_length + 1];
		memcpy(ip, &msg[ip_index], ip_length + 1 );
		ip[ip_length + 1] = '\0';

		printf("IP= %s\n", ip);

		unsigned char dst[sizeof(struct in4_addr)];
        if (inet_pton(AF_INET, ip, &dst) != 1) {
			return -1;
		};

	} else {
		printf("%s", msg);
		//TODO: handle messages greater than the buffer length
 	}

}

PollFds* make_fds(unsigned int size) {
    PollFds *ptr = malloc(sizeof(PollFds));
    ptr->poll_size = size;
    ptr->poll_used = 0;
    ptr->pfds = malloc(size * sizeof(struct pollfd));
    ptr->handlers = malloc(size * sizeof(handle_stdin));

    return ptr;
}

int insert(PollFds *ptr, int fd, short events, int(*handler)(struct pollfd*)) {
    if (ptr->poll_used >= ptr->poll_size) {
        return -1;
    }

    ptr->pfds[ptr->poll_used].fd = fd;
    ptr->pfds[ptr->poll_used].events = events;
    ptr->handlers[ptr->poll_used] = handler;
    ptr->poll_used++;

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
    user->alias = (char*) malloc(strlen(argv[1]));
    strcpy(user->alias, argv[1]);
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


int handle_client(stuct pollfd *pfds)
{
    pfds.revents = 0;
    char buf[255];
    return read(pfds.fd, buf, sizeof(buf));
}

int handle_server(stuct pollfd *pfds)
{
    ptr->pfds[0].revents = 0;
    struct sockaddr cli_addr;
    socklen_t cli_len;

    int cli_sfd = accept(ptr->pfds[0].fd, &cli_addr, &cli_len);
    if (cli_sfd < 0)
        fprintf(stderr, "Failed to accept. errno: %s\n", strerror(errno));

    insert(ptr, cli_sfd, POLLIN, handle_client);
    fprintf(stdout, "cli_sfd= %d\n", cli_sfd);
}

int handle_events(PollFds *ptr)
{
    int ret = poll(ptr->pfds, ptr->poll_used, TIMEOUT);

    assert(ret >= 0);
    if (ret != 0) {
        for (int i = 0; i <= ptr->poll_used; i++) {
            if (ptr->pfds[i].revents & ptr->pfds[i].events) {
                if (ptr->handlers[i](&(ptr->pfds[i])) < 0) {
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
//    insert(ptr, server_sfd, POLLIN, handle_server);
    while(handle_events(ptr) >= 0);
    free(user);

    return 0;
}

