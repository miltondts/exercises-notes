#include <stdio.h>

#define ALPHABET_SIZE	26

int simple_hash_function(char in)
{
	return (int)in - (int)'a';
}

void print_table(char array[], int size)
{
	for (int i = 0; i < size; i++) {
		printf("[%d] = %c, ", i, array[i]);
		if (i % 5 == 0)
			printf("\n");
	}
}

int store_in_table(char array[], int size, char item)
{
	int pos = 0, ret = 0;

	pos = simple_hash_function(item);
	if (array[pos] != 0)
		return -1;

	array[pos] = item;
	return 0;
}

void get_position(char array[], char item)
{
	int pos = simple_hash_function(item);

	if (array[pos] == 0)
		printf("No one's home.\n");
	else
		printf("I'm here: %d.\n", pos);
}

int main(int argc, char *argv[])
{
	char table[ALPHABET_SIZE] = { 0 };

	store_in_table(table, ALPHABET_SIZE, 'm');
	store_in_table(table, ALPHABET_SIZE, 'i');
	store_in_table(table, ALPHABET_SIZE, 'l');
	store_in_table(table, ALPHABET_SIZE, 't');
	store_in_table(table, ALPHABET_SIZE, 'o');
	store_in_table(table, ALPHABET_SIZE, 'n');
	print_table(table, ALPHABET_SIZE);
	get_position(table, 'o');
	get_position(table, 'a');

	return 0;
}
