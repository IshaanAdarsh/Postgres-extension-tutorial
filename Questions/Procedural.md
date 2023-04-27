<h2>What are Procedural Languages?</h2>
<p>PostgreSQL supports several procedural languages, including PL/SQL, PL/Python. These languages allow you to write stored procedures, triggers, and other database objects using a familiar programming language.</p>
<h2>How to Use Procedural Languages for a PostgreSQL Extension</h2>
<p>To use a procedural language in a PostgreSQL extension, you need to do the following:</p>
<p>&nbsp;</p>
<ul>
<li><strong><em>Install the language:</em></strong>&nbsp;Use the&nbsp;<strong>CREATE LANGUAGE</strong>&nbsp;command to install the desired procedural language in your PostgreSQL database.&nbsp;</li>
</ul>
<p>For example, to install PL/Python:&nbsp; </p>
<p><em><code>CREATE LANGUAGE plpythonu;</code></em></p>
<p>&nbsp;</p>
<ul>
<li><strong><em>Create the function:</em></strong>&nbsp;Write a function in your procedural language that performs the desired operation.&nbsp;</li>
</ul>
<p>For example, here's a simple function written in PL/Python that returns the sum of two integers:</p>
<p><em><code>CREATE FUNCTION my_sum(a INTEGER, b INTEGER) RETURNS INTEGER</code></em></p>
<p><em><code>AS $$</code></em></p>
<p><em>&nbsp;&nbsp;&nbsp;&nbsp;<code>return a + b</code></em></p>
<p><em><code>$$ LANGUAGE plpythonu;</code></em></p>
<p>&nbsp;</p>
<ul>
<li><strong><em>Build the extension:</em></strong>&nbsp;In your extension's Makefile, include the procedural language as a dependency.</li>
</ul>
<p>For example, to include PL/Python:</p>
<p>&nbsp;<em><code>MODULES = myextension</code></em></p>
<p><em><code>DATA = myextension--1.0.sql</code></em></p>
<p><em><code>PG_CONFIG = pg_config</code></em></p>
<p><em><code>PGXS := $(shell $(PG_CONFIG) --pgxs)</code></em></p>
<p><em><code>REGRESS = myextension_test</code></em></p>
<p><em><code>DOCS = README.md</code></em></p>
<p><em><code>PLPYTHONU = $(shell $(PG_CONFIG) --pkglibdir)/plpythonu</code></em></p>
<p><em><code>include $(PGXS)</em><em></code>&nbsp;</em></p>
<p><em><code>myextension.so: myextension.o</code></em></p>
<p><em>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<code>$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS) $(PLPYTHONU)</code></em></p>
<p><em>&nbsp;</em></p>
<ul>
<li><strong><em>Test the function</em></strong>: After building and installing the extension, you can test your function using the&nbsp;<strong>SELECT</strong>command.&nbsp;</li>
</ul>
<p>For example:</p>
<p><em><code>SELECT my_sum(1, 2);</code></em><em>&nbsp;</em></p>
<p>This should return the value&nbsp;<code><strong>3</strong></code>.</p>
