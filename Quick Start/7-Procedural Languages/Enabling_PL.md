There are a few different ways to enable procedural languages in PostgreSQL. Here are the common methods:

1.  Using the `CREATE LANGUAGE` Command: The `CREATE LANGUAGE` command is the simplest way to enable a procedural language. You can execute this command in a PostgreSQL database to enable the desired language.

Example:

```sql
CREATE LANGUAGE plpythonu;
```

2.  Using the `psql` Command-Line Tool: You can also use the `psql` command-line tool to enable procedural languages. Start the `psql` tool and connect to the target database. Then, use the `\c` command to connect to the desired database and the `\q` command to exit the `psql` tool. The language will be enabled automatically.

Example:

```bash
psql -U <username> -d <database_name>
\c <database_name>
\q
```

3.  Modifying the `postgresql.conf` File: Another method is to modify the `postgresql.conf` configuration file. Locate the `shared_preload_libraries` parameter in the file and add the name of the procedural language you want to enable. Save the changes and restart the PostgreSQL service for the language to take effect.

Example:

```arduino
shared_preload_libraries = 'plpythonu'
```

4.  Using the `ALTER DATABASE` Command: If you want to enable a procedural language for a specific database, you can use the `ALTER DATABASE` command.

Example:

```sql
ALTER DATABASE <database_name> SET plpythonu;
```

These are the common ways to enable procedural languages in PostgreSQL. Choose the method that suits your requirements and access level to enable the desired language in your PostgreSQL database.
