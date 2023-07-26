## PGXN (PostgreSQL Extension Network):

### Uploading the Extension on PGXN:

- It is a collaborative platform and centralized repository for PostgreSQL extensions. It provides a platform for developers to share, distribute, and collaborate on PostgreSQL extensions, enhancing the overall ecosystem and community support for PostgreSQL.

To set up and use PGXN to publish using the website and distribute your extension to other users, you can follow these steps:

### Step 1: Set up a PGXN Account: 
Visit the PGXN website (<https://pgxn.org/>) and create an account. This will allow you to manage your extensions and publish them on the PGXN repository.

### Step 2: Prepare Your Extension: 
Ensure that your extension is properly developed, tested, and ready for distribution. Make sure you have a well-documented README file, docfile, changelog, SQL scripts, and any necessary code files or dependencies.

### Step 3: Create a PGXN Metadata File: 
PGXN requires a metadata file that provides information about your extension. Create a file named `META.json` that includes details such as the extension name, version, author, description, dependencies, and other relevant information. Refer to the PGXN documentation for the required format and fields.

#### Code for META.json file for my_extension:
```json
{
  "name": "my_extension",
  "abstract": "A basic PostgreSQL extension.",
  "version": "1.0.0",
  "maintainer": "Ishaan Adarsh <ishaanad9@gmail.com>",
  "license": "postgresql",
  "provides": {
    "my_extension": {
      "file": "my_extension--1.0.sql",
      "version": "1.0.0"
    }
  },
  "meta-spec": {
    "version": "1.0.0",
    "url": "https://pgxn.org/meta/spec.txt"
  }
}
```

> While updating the extension: The `meta-spec` must be version `1.0.0`.  That's referring to the version of the JSON specification, NOT your module version.  `1.0.0` is the only spec that exists.

### Step 4: Build a Distribution Package:
- Ensure your extension follows the PGXN packaging guidelines and is ready for distribution.
- Package your extension and the `META.json` file into a distribution package. This package should be in a compressed format (zip format) and include all the necessary files for installation and usage of your extension.

### Step 5: Publish Your Extension:
- Use the PGXN command-line tool or web interface to publish your extension. Provide the distribution package created in the previous step and upload it to PGXN. The tool will validate the package and extract the metadata.

## pgxnclient: Exploring PostgreSQL Extensions

pgxnclient is a versatile command-line tool that facilitates interaction with the PostgreSQL Extension Network (PGXN). It allows users to search, download, install, upgrade, and manage PostgreSQL extensions effortlessly. Let's dive into each of the available commands to understand how they work.

### Command: `pgxn check`

The `pgxn check` command is used to run tests for a specific distribution. It ensures that the extension is working as expected and its tests pass successfully. Here's how to use it:

```bash
pgxn check distribution_name
```

### Command: `pgxn download`

The `pgxn download` command allows users to download a distribution from the PGXN network. It fetches the necessary files and prepares the distribution for installation.

```bash
pgxn download distribution_name
```

### Command: `pgxn help`

The `pgxn help` command displays helpful information about the pgxnclient tool. You can use it to get general help or get detailed information about specific commands.

```bash
pgxn help
pgxn help command_name
```

### Command: `pgxn info`

The `pgxn info` command provides detailed information about a specific distribution. It displays metadata, such as version, description, and the author of the extension.

```bash
pgxn info distribution_name
```

### Command: `pgxn install`

The `pgxn install` command is used to download, build, and install a distribution from the PGXN network. It installs the extension into your PostgreSQL installation.

```bash
pgxn install distribution_name
```

### Command: `pgxn load`

The `pgxn load` command allows users to load an extension's functions into a specific database. It enables the extension's functionality for the chosen database.

```bash
pgxn load distribution_name -d your_database_name
```

### Command: `pgxn mirror`

The `pgxn mirror` command returns information about the available mirrors for PGXN. It helps users select an appropriate mirror for faster downloads.

```bash
pgxn mirror
```

### Command: `pgxn search`

The `pgxn search` command is used to search for available extensions on PGXN based on a specific keyword.

```bash
pgxn search search_keyword
```

### Command: `pgxn uninstall`

The `pgxn uninstall` command removes a distribution from the system. It uninstalls the extension from your PostgreSQL installation.

```bash
pgxn uninstall distribution_name
```

### Command: `pgxn unload`

The `pgxn unload` command unloads an extension's functions from a specific database. It disables the extension's functionality in the chosen database.

```bash
pgxn unload distribution_name -d your_database_name
```
