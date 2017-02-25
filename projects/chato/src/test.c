#include "stdlib.h"
#include "arpa/inet.h"
#include "stdio.h"
#include "string.h"
#include "unistd.h"
#include "errno.h"
#include "limits.h"

int main(void) {
  setvbuf(stdout, NULL, _IONBF, 0);
    char msg[255];
    int ret = 0;
	errno = 0;
    ret = read(STDIN_FILENO, msg, sizeof(msg));
    if (ret < 0) {
        return ret;
    } else if (msg[0] == '/') { 
        if (strncmp("connect ", &msg[1], 8) != 0) {
            return -1;
        };

        int ip_length = 0;
        int ip_index = 9;
        while (msg[ip_length + ip_index] != ' ')  {
	    if(msg[ip_length + ip_index] == '\0') {
		printf("IP null char.\n");
            	return -1;
            }
            ip_length++;
        }

        char ip[ip_length + 1];
        memcpy(ip, &msg[ip_index], ip_length);
        ip[ip_length + 1] = '\0';

        printf("IP= %s\n", ip);
        
        unsigned char dst[sizeof(struct in_addr)];
        ret = inet_pton(AF_INET, ip, &dst);
        if (ret != 1) {
            return -1;
        };

	char *endptr;
        unsigned long val;
        val = strtol(&msg[ip_index + ip_length + 1], &endptr, 0);

           if ((errno == ERANGE && (val == ULONG_MAX || val == 0))
                   || (errno != 0 && val == 0)) {
		printf("Port number out of range\n");
		return -1;
           }

           if (endptr == &msg[ip_index + ip_length + 1]) {
		printf("Empty port\n");
		return -1;
           }

           /* If we got here, strtol() successfully parsed a number */

           printf("strtol() returned %ld\n", val);

           if (*endptr != '\0')        /* Not necessarily an error... */
               printf("Further characters after number: %s\n", endptr);



    } else {
	msg[ret] = '\0';
        printf("%s", msg);
        //TODO: handle messages greater than the buffer length
    }

  
  printf("SUCESS motherfuckers.\n");
  return 0;
}

