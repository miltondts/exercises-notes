#include <arpa/inet.h>
#include <errno.h>
#include <poll.h>
#include <signal.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>

#define     MAX_CONNECTIONS     8       /* Maximum number of connections */
#define     MAX_STRLEN          255     /* Maximum string length */
#define     TIMEOUT             10000   /* Connection timeout in miliseconds*/

typedef struct Users{
    char *alias;
    uint32_t ip;
    uint16_t port;
} User;


typedef struct CliFds {
    struct pollfd *pfds;    /*array of pollfd*/
    int poll_size;          /*maximum number of file descriptors*/
    int poll_used;          /*number of used file descriptors*/
} CliFds;

CliFds* make_fds(unsigned int size) {
    CliFds *ptr = malloc(sizeof(CliFds));
    ptr->poll_size = size;
    ptr->poll_used = 0;
    ptr->pfds = malloc(size * sizeof(struct pollfd));

    return ptr;
}

int insert(CliFds *ptr, int fd, short events) {
    if (ptr->poll_used >= ptr->poll_size) {
        return -1;
    }

    ptr->pfds[ptr->poll_used].fd = fd;
    ptr->pfds[ptr->poll_used].events = events;
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

int main(int argc, char *argv[])
{
    if(argc < 3) {
        fprintf(stdout, "Usage: chato ALIAS IP PORT\n");
        exit(EXIT_FAILURE);
    }

    User* user;
    user = (User*) malloc(sizeof(User));
    user->alias = (char*) malloc(strlen(argv[1]));
    strcpy(user->alias, argv[1]);
    if(inet_pton(AF_INET, argv[2], &user->ip) <= 0) {
        fprintf(stderr, "Invalid IP. errno: %s\n", strerror(errno));
        exit(EXIT_FAILURE);
    }

    errno = 0;
    char *endptr;
    user->port = strtoul(argv[3], &endptr, 10);
    if(errno != 0 || (argv[3] == endptr)) {
        fprintf(stderr, "Invalid port. errno: %s\n", strerror(errno));
        exit(EXIT_FAILURE);
    }

    char str[INET_ADDRSTRLEN];
    if (inet_ntop(AF_INET, &user->ip, str, INET_ADDRSTRLEN) == NULL){

        exit(EXIT_FAILURE);
    }

    printf("Alias: %s\nIP: %s\nport: %u\n", user->alias, str, user->port);
    free(user);
    int server_sfd = make_server(user->ip, user->port);
    if (server_sfd < 0) {
        fprintf(stderr, "Failed to get server socket. errno: %s\n", strerror(errno));
        exit(EXIT_FAILURE);
    }

    CliFds *ptr = make_fds(MAX_CONNECTIONS);
    insert(ptr, STDIN_FILENO, POLLIN);
    insert(ptr, server_sfd, POLLIN);
    while(1) {
        // Wait 10 seconds
        int ret = poll(ptr->pfds, ptr->poll_used, TIMEOUT);
        // Check if poll actually succeded
        if (ret < 0) {
            fprintf(stderr, "Failed to poll. errno: %s\n", strerror(errno));
            exit(EXIT_FAILURE);
        } else if (ret == 0) {
            fprintf(stdout, "Poll timed out.\n");
        } else {
            if (ptr->pfds[0].revents & POLLIN) {
                ptr->pfds[0].revents = 0;
                char buf[255];
                read(STDIN_FILENO, buf, sizeof(buf));
                fprintf(stdout, "read from stdin: %s\n", buf);
            }

            if (ptr->pfds[1].revents & POLLIN) {
                ptr->pfds[1].revents = 0;
                struct sockaddr cli_addr;
                socklen_t cli_len;

                int cli_sfd = accept(server_sfd, &cli_addr, &cli_len);
                if (cli_sfd < 0)
                    fprintf(stderr, "Failed to accept. errno: %s\n", strerror(errno));

                fprintf(stdout, "cli_sfd= %d\n", cli_sfd);
            }
        }
    }

    return 0;
}

