MODULE_big = myext
OBJS = myext.o

EXTENSION = myext
DATA = myext--1.0.sql

PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)

myext.o: myext.c
	$(CC) $(CFLAGS) -c myext.c -o myext.o
