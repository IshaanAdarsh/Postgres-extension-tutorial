EXTENSION = my_extension
DATA = my_extension--1.0.sql
REGRESS = my_extension--regress.sql

PG_CONFIG  ?= pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
