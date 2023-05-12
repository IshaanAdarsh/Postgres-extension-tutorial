## What is PGXN?

PGXN stands for "PostgreSQL Extension Network". It is a community-driven repository of PostgreSQL extensions that makes it easy to discover, download, and install extensions for your PostgreSQL database.

PGXN includes a web interface for browsing and searching extensions, as well as a command-line tool called `pgxnclient` for downloading and installing extensions.
## Do I Need PGXN?

If you're building a PostgreSQL database and need to add functionality beyond what is included in the core PostgreSQL distribution, you may want to consider using PGXN to find and install extensions.

PGXN provides a convenient and centralized repository of PostgreSQL extensions, making it easy to discover and download the extensions you need. However, if you're already familiar with a specific extension and know where to find it, you may not need to use PGXN.
## How Does PGXN Work?

To use PGXN, you'll need to install the `pgxnclient` command-line tool. You can do this using the following command:

```shell

$ sudo apt-get install pgxnclient # for Debian/Ubuntu
$ sudo yum install pgxnclient # for CentOS/Fedora
```



Once you have `pgxnclient` installed, you can use it to search for and download extensions. For example, to search for extensions related to JSON, you can use the following command:

```shell

$ pgxnclient search json
```



This will return a list of extensions related to JSON. You can then use the `install` command to download and install an extension. For example, to install the `pgjwt` extension for working with JSON Web Tokens, you can use the following command:

```shell

$ pgxnclient install pgjwt
```



This will download and install the `pgjwt` extension, making it available for use in your PostgreSQL database.

Once you've installed an extension, you can load it into your database using the `CREATE EXTENSION` command. For example, to load the `pgjwt` extension, you can use the following SQL command:

```sql

CREATE EXTENSION pgjwt;
```


