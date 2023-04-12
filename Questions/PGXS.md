<p><strong>What is PGXS?</strong></p>
<p>PGXS stands for "PostgreSQL Extension Building Infrastructure". It is a set of Makefiles and scripts that simplify the process of building and installing PostgreSQL extensions.</p>
<p>PGXS is designed to work with the&nbsp;<code><strong>pg_config</strong></code>&nbsp;command, which is used to determine the configuration options and file locations for your PostgreSQL installation. By using PGXS, you can avoid the need to manually specify these options in your Makefile.</p>
<p><strong>Do I Need PGXS?</strong></p>
<p>If you're building a simple PostgreSQL extension that consists of just one or a few source files, you may be able to build it without using PGXS. However, for more complex extensions that include multiple files and dependencies, PGXS can make the process much easier.</p>
<p>In general, if you're building a PostgreSQL extension in C, you should consider using PGXS.</p>
<p><strong>How Does PGXS Work?</strong></p>
<p>To use PGXS, you'll need to create a Makefile for your extension that includes the appropriate PGXS rules. Here's an example Makefile:</p>
<p><em><code>MODULES = myext</code></em></p>
<p><em><code>PG_CONFIG = pg_config</code></em></p>
<p><em><code>PGXS := $(shell $(PG_CONFIG) --pgxs)</code></em></p>
<p><em><code>include $(PGXS)</code></em></p>
<p>&nbsp;</p>

<p>This Makefile defines a variable&nbsp;<code><strong>MODULES</strong></code>&nbsp;that lists the source file(s) for your extension (in this case, just&nbsp;<code><strong>myext.c</strong></code>), and uses the&nbsp;<code><strong>pg_config</strong></code>&nbsp;command to determine the location of the PostgreSQL installation and include the appropriate build rules.</p>
<p>The&nbsp;<code><strong>include $(PGXS)</strong></code>&nbsp;line is what actually includes the PGXS rules. This will define a number of Makefile variables and targets that you can use to build and install your extension.</p>
<p>Once you've created your Makefile, you can use the following commands to build and install your extension:</p>
<p><em><code>$ make</code></em></p>
<p><em><code>$ sudo make install</code></em></p>
<p>&nbsp;</p>
<p>The&nbsp;<code><strong>make</strong></code>&nbsp;command will build your extension and create a shared library file (e.g.&nbsp;<code><strong>myext.so</strong></code>). The&nbsp;<code><strong>sudo make install</strong></code>&nbsp;command will install the shared library file in the appropriate location (e.g.&nbsp;<code><strong>/usr/lib/postgresql/&lt;version&gt;/lib/myext.so</strong></code>) and register your extension with PostgreSQL.</p>
<p>Once your extension is installed, you can use the&nbsp;<code><strong>CREATE EXTENSION</strong></code>&nbsp;command to load it into a database:</p>
<p><em><code>CREATE EXTENSION myext;</code></em></p>

