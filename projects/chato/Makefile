CFLAGS += -Wall

SRC_DIR = src
SRC = $(filter-out $(SRC_DIR)/test.c, $(wildcard $(SRC_DIR)/*.c))
OBJS = $(SRC:.c=.o)

chato: $(OBJS)
	$(CC) $(OBJS) -o $@

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@ -Wall -g

clean:
	@rm $(APP) $(OBJS)

.PHONY: chato clean
