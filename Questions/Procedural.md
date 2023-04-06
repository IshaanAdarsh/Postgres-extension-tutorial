<h2>What are Procedural Languages?</h2>
<p>PostgreSQL supports several procedural languages, including PL/SQL, PL/Python. These languages allow you to write stored procedures, triggers, and other database objects using a familiar programming language.</p>
<h2>How to Use Procedural Languages for a PostgreSQL Extension</h2>
<p>To use a procedural language in a PostgreSQL extension, you need to do the following:</p>
<p>&nbsp;</p>
<ul>
<li><strong><em>Install the language:</em></strong>&nbsp;Use the&nbsp;<strong>CREATE LANGUAGE</strong>&nbsp;command to install the desired procedural language in your PostgreSQL database.&nbsp;</li>
</ul>
<p>For example, to install PL/Python:&nbsp;</p>
<code>
<p><em>CREATE LANGUAGE plpythonu;</em></p>
</code>
<p>&nbsp;</p>
<ul>
<li><strong><em>Create the function:</em></strong>&nbsp;Write a function in your procedural language that performs the desired operation.&nbsp;</li>
</ul>
<p>For example, here's a simple function written in PL/Python that returns the sum of two integers:</p>
<code>
<p><em>CREATE FUNCTION my_sum(a INTEGER, b INTEGER) RETURNS INTEGER</em></p>
<p><em>AS $$</em></p>
<p><em>&nbsp;&nbsp;&nbsp;&nbsp;return a + b</em></p>
<p><em>$$ LANGUAGE plpythonu;</em></p>
</code>
<p>&nbsp;</p>
<ul>
<li><strong><em>Build the extension:</em></strong>&nbsp;In your extension's Makefile, include the procedural language as a dependency.</li>
</ul>
<p>For example, to include PL/Python:</p>
<code>
<p>&nbsp;<em>MODULES = myextension</em></p>
<p><em>DATA = myextension--1.0.sql</em></p>
<p><em>PG_CONFIG = pg_config</em></p>
<p><em>PGXS := $(shell $(PG_CONFIG) --pgxs)</em></p>
<p><em>REGRESS = myextension_test</em></p>
<p><em>DOCS = README.md</em></p>
<p><em>PLPYTHONU = $(shell $(PG_CONFIG) --pkglibdir)/plpythonu</em></p>
<p><em>include $(PGXS)</em><em>&nbsp;</em></p>
<p><em>myextension.so: myextension.o</em></p>
<p><em>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS) $(PLPYTHONU)</em></p>
</code>
<p><em>&nbsp;</em></p>
<ul>
<li><strong><em>Test the function</em></strong>: After building and installing the extension, you can test your function using the&nbsp;<strong>SELECT</strong>command.&nbsp;</li>
</ul>
<p>For example:</p>
<code>
<p><em>SELECT my_sum(1, 2);</em><em>&nbsp;</em></p>
</code>
<p>This should return the value&nbsp;<code><strong>3</strong></code>.</p>