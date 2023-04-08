<h2>What are External Languages?</h2>
<p>In addition to the procedural languages supported by PostgreSQL, you can also use external languages to write stored procedures, triggers, and other database objects. These languages are not built into PostgreSQL, but instead run in a separate process and communicate with the database using a communication protocol.</p>
<h2>How to Use External Languages for a PostgreSQL Extension</h2>
<p>To use an external language in a PostgreSQL extension, you need to do the following:</p>
<p>&nbsp;</p>
<ol>
<li>Choose an external language: Select an external language that you want to use in your extension. There are several options available, such as Java, C#, and Node.js. Each language has its own set of tools and libraries, so choose the one that best fits your needs.</li>
</ol>
<p>&nbsp;</p>
<ol>
<li>Write the function: Write a function in your external language that performs the desired operation. This function should communicate with the database using the appropriate communication protocol.&nbsp;</li>
</ol>
<p>&nbsp;</p>
<p>For example, here's a simple function written in Python that returns the sum of two integers:</p>
<p>&nbsp;</p>

<code><p><em>import psycopg2</em></p></code>
<code><p><em>def my_sum(a, b):</em></p></code>
<code><p><em>&nbsp;&nbsp;&nbsp;&nbsp;conn = psycopg2.connect("dbname=mydb user=myuser")</em></p></code>
<code><p><em>&nbsp;&nbsp;&nbsp;&nbsp;cur = conn.cursor()</em></p></code>
<code><p><em>&nbsp;&nbsp;&nbsp;&nbsp;cur.execute("SELECT %s + %s", (a, b))</em></p></code>
<code><p><em>&nbsp;&nbsp;&nbsp;&nbsp;result = cur.fetchone()[0]</em></p></code>
<code><p><em>&nbsp;&nbsp;&nbsp;&nbsp;cur.close()</em></p></code>
<code><p><em>&nbsp;&nbsp;&nbsp;&nbsp;conn.close()</em></p></code>
<code><p><em>&nbsp;&nbsp;&nbsp;&nbsp;return result</em></p></code>
<p>&nbsp;</p>
<ol>
<li>Build the extension: In your extension's Makefile, include the necessary files and libraries for your external language. For example, to include Python:</li>
</ol>
<p>&nbsp;</p>
<code>
<p><em>MODULES = myextension</em></p>
<p><em>DATA = myextension--1.0.sql</em></p>
<p><em>PG_CONFIG = pg_config</em></p>
<p><em>PGXS := $(shell $(PG_CONFIG) --pgxs)</em></p>
<p><em>REGRESS = myextension_test</em></p>
<p><em>DOCS = README.md</em></p>
<p><em>PYTHON_INCLUDE = /usr/include/python3.9</em></p>
<p><em>PYTHON_LIB = /usr/lib/x86_64-linux-gnu/libpython3.9.so</em></p>
<p><em>SHLIB_LINK += -lpython3.9</em></p>
<p><em>include $(PGXS)</em></p>
<p><em>&nbsp;</em></p>
<p><em>myextension.so: myextension.o</em></p>
<p><em>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS) $(PYTHON_LIB)</em></p>
</code>
<p>&nbsp;</p>
<ol>
<li>Test the function: After building and installing the extension, you can test your function using the&nbsp;<strong>SELECT</strong>&nbsp;command. For example:</li>
</ol>
<code>
<p><em>SELECT my_sum(1, 2);</em></p>
</code>
<p>&nbsp;</p>
<p>This should return the value&nbsp;<code><strong>3</strong></code>.</p>
