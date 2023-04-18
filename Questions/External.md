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
<p>For example, here's a simple function written in Python that returns the sum of two integers: </p>
<p>&nbsp;</p>
<p><em><code>import psycopg2</code></em></p>
<p><em><code>def my_sum(a, b):</code></em></p>
<p><em>&nbsp;&nbsp;&nbsp;&nbsp;<code>conn = psycopg2.connect("dbname=mydb user=myuser")</code></em></p>
<p><em>&nbsp;&nbsp;&nbsp;&nbsp;<code>cur = conn.cursor()</code></em></p>
<p><em>&nbsp;&nbsp;&nbsp;&nbsp;<code>cur.execute("SELECT %s + %s", (a, b))</code></em></p>
<p><em>&nbsp;&nbsp;&nbsp;&nbsp;<code>result = cur.fetchone()[0]</code></em></p>
<p><em>&nbsp;&nbsp;&nbsp;&nbsp;<code>cur.close()</code></em></p>
<p><em>&nbsp;&nbsp;&nbsp;&nbsp;<code>conn.close()</code></em></p>
<p><em>&nbsp;&nbsp;&nbsp;&nbsp;<code>return result</code></em></p>
<p>&nbsp;</p>
<ol>
<li>Build the extension: In your extension's Makefile, include the necessary files and libraries for your external language. For example, to include Python:</li>
</ol>
<p><em><code>MODULES = myextension</code></em></p>
<p><em><code>DATA = myextension--1.0.sql</code></em></p>
<p><em><code>PG_CONFIG = pg_config</code></em></p>
<p><em><code>PGXS := $(shell $(PG_CONFIG) --pgxs)</code></em></p>
<p><em><code>REGRESS = myextension_test</code></em></p>
<p><em><code>DOCS = README.md</code></em></p>
<p><em><code>PYTHON_INCLUDE = /usr/include/python3.9</code></em></p>
<p><em><code>PYTHON_LIB = /usr/lib/x86_64-linux-gnu/libpython3.9.so</code></em></p>
<p><em><code>SHLIB_LINK += -lpython3.9</code></em></p>
<p><em><code>include $(PGXS)</code></em></p>
<p><em><code>myextension.so: myextension.o</code></em></p>
<p><em>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<code>$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS) $(PYTHON_LIB)</code></em></p>
<ol>
<li>Test the function: After building and installing the extension, you can test your function using the&nbsp;<strong>SELECT</strong>&nbsp;command. For example:</li>
</ol>
<p><em><code>SELECT my_sum(1, 2);</code></em></p>
<p>&nbsp;</p>
<p>This should return the value&nbsp;<code><strong>3</strong></code>.</p>
