MODULE_big = extension
OBJS = extension.o

EXTENSION = extension
DATA = extension--1.0.sql

PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)

extension.o: extension.c
	$(CC) $(CFLAGS) -I/opt/homebrew/include/postgresql/server -c extension.c -o extension.o
