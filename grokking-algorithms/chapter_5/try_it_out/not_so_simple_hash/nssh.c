#include <stdio.h>
#include <string.h>

#define HASH_SIZE	15

int char_to_pos(char c)
{
	return (int)c - (int)'a';
}

int hash_function(char *str)
{
	int sum = 0;

	for (int i = 0; i < strlen(str); i++)
		sum += char_to_pos(str[i]) * 2 + 1;

	return sum % HASH_SIZE;
}

int main(int argc, char *argv[])
{
	int pos = 0;

	printf("I'm a not so simple hash function test.\n");
	for (int i = argc - 1; i > 0; i--) {
		pos = hash_function(argv[i]);
		printf("%s => pos = %d\n", argv[i], pos);
	}

	return 0;
}
