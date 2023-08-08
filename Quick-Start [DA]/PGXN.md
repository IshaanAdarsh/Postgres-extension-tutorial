# PGXN (PostgreSQL Extension Network):
PGXN is a centralized repository solely focused on the distribution of PostgreSQL extensions. It facilitates developers in sharing and distributing their PostgreSQL extensions, contributing to the overall ecosystem and accessibility of extensions for the PostgreSQL community.

## Uploading the Extension on PGXN:
### Step 1: Set up a PGXN Account: 
Visit [PGXN manager](https://manager.pgxn.org/) and create an account. This will allow you to manage your extensions and publish them on the PGXN repository.

### Step 2: Prepare Your Extension: 
- Ensure that your extension is properly developed, tested, and ready for distribution. Make sure you have a well-documented README file, docfile, changelog, SQL scripts, and any necessary code files or dependencies.
- Refer to documentation on how to create a [Simple Postgres Extension](https://github.com/IshaanAdarsh/Postgres-extension-tutorial/pull/14)

### Step 3: Create a PGXN Metadata File: 
PGXN requires a metadata file that provides information about your extension. Create a file named `META.json` that includes details such as the extension name, version, author, description, dependencies, and other relevant information. Refer to the [PGXN Meta Specification](https://pgxn.org/spec/) for the required format and fields.

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
      "file": "my_extension--1.0.0.sql",
      "version": "1.0.0"
    }
  },
  "meta-spec": {
    "version": "1.0.0",
    "url": "https://pgxn.org/meta/spec.txt"
  }
}
```
1. "name": Specifies the name of the PostgreSQL extension. In this case, the extension is named "my_extension."

2. "abstract": Provides a brief description or abstract of the extension's functionality. In this example, it describes the extension as a "basic PostgreSQL extension."

3. "version": Indicates the version number of the extension. The current version of this extension is "1.0.0."

4. "maintainer": Specifies the contact information of the person responsible for maintaining the extension. In this case, the maintainer is "Ishaan Adarsh" with the email address "ishaanad9@gmail.com."

5. "license": Indicates the type of license under which the extension is distributed. In this example, the extension is distributed under the "postgresql" license.

6. "provides": Specifies the details of the extension provided by this package. It includes the extension name, the file containing the SQL code for the extension ("my_extension--1.0.sql"), and the version of the provided extension ("1.0.0").

7. "meta-spec": Refers to the specification for the format of the metadata in the package. It includes the version of the specification used ("1.0.0") and the URL where the [specification](https://pgxn.org/meta/spec.txt) can be found.

> While updating the extension: The `meta-spec` must be version `1.0.0`.  That's referring to the version of the JSON specification, NOT your module version.  `1.0.0` is the only spec that exists.

### Step 4: Build a Distribution Package:
- Ensure your extension follows the [PGXN packaging guidelines](https://manager.pgxn.org/howto) and is ready for distribution.
- Package your extension and the `META.json` file into a distribution package. This package should be in a compressed format (zip format) and include all the necessary files for installation and usage of your extension.

To create the distribution package, follow these steps:

#### 1) Create a new directory for the distribution package and copy all the necessary files into it.

```
mkdir my_extension_dist
```

#### 2) Compress the directory into a zip file.

```
zip -r my_extension-1.0.0.zip my_extension_dist/
```

This will create a zip file named `my_extension-1.0.0.zip` containing all the necessary files for the installation and usage of your extension.

For additional details and guidelines on packaging PostgreSQL extensions, you can refer to the official [PGXN website](https://manager.pgxn.org/howto)

### Step 5: Publish Your Extension:
- Use the PGXN web interface to publish your extension. Provide the distribution package created in the previous step and upload it to PGXN. The tool will validate the package and extract the metadata.

## pgxnclient: Exploring PostgreSQL Extensions

pgxnclient is a versatile command-line tool that facilitates interaction with the PostgreSQL Extension Network (PGXN). It allows users to search, download, install, upgrade, and manage PostgreSQL extensions effortlessly. Let's dive into each of the available commands to understand how they work.

### Command: `pgxn check`

The `pgxn check` command is used to run tests for a specific distribution. It ensures that the extension is working as expected and its tests pass successfully. Here's how to use it:

```bash
pgxn check distribution_name
```
> [Additional Information on `pgxn check`](https://pgxn.github.io/pgxnclient/usage.html#pgxn-check)

### Command: `pgxn download`

The `pgxn download` command allows users to download a distribution from the PGXN network. It fetches the necessary files and prepares the distribution for installation.

```bash
pgxn download distribution_name
```
> [Additional Information on `pgxn download`](https://pgxn.github.io/pgxnclient/usage.html#pgxn-download)

### Command: `pgxn help`

The `pgxn help` command displays helpful information about the pgxnclient tool. You can use it to get general help or get detailed information about specific commands.

```bash
pgxn help
pgxn help command_name
```
> [Additional Information on `pgxn help`](https://pgxn.github.io/pgxnclient/usage.html#pgxn-help)

### Command: `pgxn info`

The `pgxn info` command provides detailed information about a specific distribution. It displays metadata, such as version, description, and the author of the extension.

```bash
pgxn info distribution_name
```
> [Additional Information on `pgxn info`](https://pgxn.github.io/pgxnclient/usage.html#pgxn-info)

### Command: `pgxn install`

The `pgxn install` command is used to download, build, and install a distribution from the PGXN network. It installs the extension into your PostgreSQL installation.

```bash
pgxn install distribution_name
```
> [Additional Information on `pgxn install`](https://pgxn.github.io/pgxnclient/usage.html#pgxn-install)

### Command: `pgxn load`

The `pgxn load` command allows users to load an extension's functions into a specific database. It enables the extension's functionality for the chosen database.

```bash
pgxn load distribution_name -d your_database_name
```
> [Additional Information on `pgxn load`](https://pgxn.github.io/pgxnclient/usage.html#pgxn-load)

### Command: `pgxn mirror`

The `pgxn mirror` command returns information about the available mirrors for PGXN. It helps users select an appropriate mirror for faster downloads.

```bash
pgxn mirror
```
> [Additional Information on `pgxn mirror`](https://pgxn.github.io/pgxnclient/usage.html#pgxn-mirror)

### Command: `pgxn search`

The `pgxn search` command is used to search for available extensions on PGXN based on a specific keyword.

```bash
pgxn search search_keyword
```
> [Additional Information on `pgxn search`](https://pgxn.github.io/pgxnclient/usage.html#pgxn-search)

### Command: `pgxn uninstall`

The `pgxn uninstall` command removes a distribution from the system. It uninstalls the extension from your PostgreSQL installation.

```bash
pgxn uninstall distribution_name
```
> [Additional Information on `pgxn uninstall`](https://pgxn.github.io/pgxnclient/usage.html#pgxn-uninstall)

### Command: `pgxn unload`

The `pgxn unload` command unloads an extension's functions from a specific database. It disables the extension's functionality in the chosen database.

```bash
pgxn unload distribution_name -d your_database_name
```
> [Additional Information on `pgxn unload`](https://pgxn.github.io/pgxnclient/usage.html#pgxn-unload)
