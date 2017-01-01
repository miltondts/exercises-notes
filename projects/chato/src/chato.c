#include <arpa/inet.h>
#include <errno.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/types.h>

typedef struct Users{
    char *alias;
    uint32_t ip;
    uint16_t port;
} User;

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
        fprintf(stderr, "Invalid IP.\n");
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

    return 0;
}

int make_server(uint32_t ip, uint16_t port)
{
    int sfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sfd < 0) {
        fprintf(stderr, "%s:%d errno: %s\n", __FUNCTION__, __LINE__, strerror(errno));
        exit(EXIT_FAILURE);
    }

    struct sockaddr_in addr;
    memset(&addr, '\0', sizeof(addr));
    addr.sin_family = AF_INET;
    addr.sin_addr.s_addr = INADDR_ANY;
    addr.sin_port = htons(port);
}

