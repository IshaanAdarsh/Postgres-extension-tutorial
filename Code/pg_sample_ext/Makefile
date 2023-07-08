EXTENSION = pg_sample_ext
DATA = pg_sample_ext--1.0.1.sql
REGRESS = pg_sample_ext--regress

PG_CONFIG  ?= pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
