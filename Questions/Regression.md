<h2>What are Regression Tests?</h2>
<p>Regression tests are automated tests that ensure your extension continues to work correctly as changes are made. They are typically run after each build or release to catch any bugs or regressions that may have been introduced.</p>
<h2>How to Write Regression Tests for a PostgreSQL Extension</h2>
<p>To write regression tests for a PostgreSQL extension, you need to do the following:</p>
<p>Set up a test environment: Create a test database and user that you will use for running your tests.&nbsp;</p>
<p>&nbsp;</p>
<p>You can create the test database using the&nbsp;
<code><strong>createdb</strong></code>&nbsp;command:</p>
<p><em><code>createdb my_extension_test</code></em></p>
<p><em>&nbsp;</em></p>
<ol>
<li>Write the test cases: Create one or more SQL scripts that test your extension's functionality. These scripts should create any necessary tables or data, call the functions you want to test, and verify that the results are correct.&nbsp;</li>
</ol>
<p>&nbsp;</p>
<p>For example:</p>
<p><em><code>-- test_my_function.sql</code></em></p>
<p><em><code>CREATE TABLE test_data (id INT, value TEXT);</code></em></p>
<p><em><code>INSERT INTO test_data (id, value) VALUES (1, 'foo'), (2, 'bar');</code></em></p>
<p><em>&nbsp;</em></p>
<p><em><code>SELECT my_function(value) FROM test_data WHERE id = 1; -- should return 'FOO'</code></em></p>
<p><em><code>SELECT my_function(value) FROM test_data WHERE id = 2; -- should return 'BAR'</code></em></p>
<p><em>&nbsp;</em></p>
<ol>
<li>Create a regression test file: Create a file called&nbsp;<code><strong>my_extension.sql</strong></code>&nbsp;that includes all of your test cases.&nbsp;</li>
</ol>
<p>&nbsp;</p>
<p>For example:</p>
<p><em><code>-- my_extension.sql</code></em></p>
<p><em><code>\i test_my_function.sql</code></em></p
<p>&nbsp;</p>
<ol>
<li>Add the regression test to the Makefile: In your extension's Makefile, add the name of your regression test file to the&nbsp;<code><strong>REGRESS</strong></code>&nbsp;variable.&nbsp;</li>
</ol>
<p>&nbsp;</p>
<p>For example:</p>
<p><em><code>MODULES = my_extension</code></em></p>
<p><em><code>DATA = my_extension--1.0.sql</code></em></p>
<p><em><code>PG_CONFIG = pg_config</code></em></p>
<p><em><code>PGXS := $(shell $(PG_CONFIG) --pgxs)</code></em></p>
<p><em><code>REGRESS = my_extension</code></em></p>
<p><em><code>include $(PGXS)</code></em></p>
<p>&nbsp;</p>
<ol>
<li>Run the regression test: Build and install your extension using the&nbsp;<code><strong>make</strong></code>&nbsp;command, then run the regression test using the&nbsp;<code><strong>pg_regress</strong></code>&nbsp;command:</li>
</ol>
<p><em><code>make</code></em></p>
<p><em><code>make install</code></em></p>
<p><em><code>pg_regress my_extension</code></em></p>
<p>&nbsp;</p>
<p>This will run all of the tests in your&nbsp;<code><strong>my_extension.sql</strong></code>&nbsp;file and report any failures.</p>
<p>&nbsp;</p>
<p>https://www.postgresql.org/docs/current/regress.html -> Regression Test</p>
