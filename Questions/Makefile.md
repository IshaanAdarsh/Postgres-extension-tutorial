<h2>What is a Makefile?</h2>
<p>A Makefile is a build automation tool that can help you compile, link, and package your code. Makefiles typically consist of a set of rules that describe how to build different components of your software.</p>
<p>In the context of a PostgreSQL extension, a Makefile should describe how to build and install the extension, as well as any other components required for the extension to function.</p>
<h2>How to Write a Makefile for a PostgreSQL Extension</h2>
<p>Here's an example Makefile for a simple PostgreSQL extension written in C:</p>
<p><em><code>MODULES = myextension</code></em></p>
<p><em><code>DATA = myextension--1.0.sql</code></em></p>
<p><em><code>PG_CONFIG = pg_config</code></em></p>
<p><em><code>PGXS := $(shell $(PG_CONFIG) --pgxs)</code></em></p>
<p><em><code>include $(PGXS)</code></em></p>
<p><em><code>all: myextension.so</code></em></p>
<p><em><code>myextension.so: myextension.o</code></em></p>
<p><em>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<code>$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)</code></em></p>
<p><em><code>myextension.o: myextension.c</code></em></p>
<p><em>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<code>$(CC) $(CFLAGS) $(CPPFLAGS) -c -o $@ $&lt;</code></em></p>
<p><em>&nbsp;</em></p>
<p><em>install: all</em></p>
<p><em>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<code>$(PGXS) install</code></em></p>
<p><em>&nbsp;</em></p>
<p><em>uninstall:</em></p>
<p><em>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<code>$(PGXS) uninstall</code></em></p>
<p>&nbsp;</p>
<p>Let's break down each part of this Makefile:</p>
<ul>
<li><strong>MODULES</strong>: This variable lists the names of the C source files that should be compiled to create the extension.</li>
<li><strong>DATA</strong>: This variable lists the SQL scripts that should be installed along with the extension.</li>
<li><strong>PG_CONFIG</strong>: This variable specifies the location of the&nbsp;<strong>pg_config</strong>&nbsp;utility, which is used to determine the location of the PostgreSQL installation and other configuration options.</li>
<li><strong>PGXS</strong>: This variable uses&nbsp;<strong>pg_config</strong>&nbsp;to determine the location of the PostgreSQL Extension Building Infrastructure (PGXS), which contains the rules for building PostgreSQL extensions.</li>
<li><strong>include $(PGXS)</strong>: This line includes the PGXS rules in the Makefile.</li>
<li><strong>all</strong>: This target is the default target, which builds the extension.</li>
<li><strong>myextension.so</strong>: This target specifies the name of the shared object file that should be created when the extension is built. The target depends on&nbsp;<strong>myextension.o</strong>, which contains the compiled C code for the extension.</li>
<li><strong>myextension.o</strong>: This target specifies how to compile the C code for the extension.</li>
<li><strong>install</strong>: This target installs the extension into the PostgreSQL installation directory.</li>
<li><strong>uninstall</strong>: This target uninstalls the extension from the PostgreSQL installation directory.</li>
</ul>
<p>To build and install the extension, simply run the following commands in the directory containing the Makefile:</p>
<p><em><code>$ make</code></em></p>
<p><em><code>$ make install</code></em></p>
