#include "postgres.h"
#include "fmgr.h"

PG_MODULE_MAGIC;

PG_FUNCTION_INFO_V1(my_extension_function);

Datum my_extension_function(PG_FUNCTION_ARGS) {
    // Function logic goes here
    PG_RETURN_NULL();
}
