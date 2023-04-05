<h2 style='margin-right: 0cm;margin-left: 0cm;font-size:24px;font-family: "Times New Roman", serif;color: rgb(0, 0, 0);font-style: normal;text-align: start;text-indent: 0px;text-decoration: none;'>What are Procedural Languages?</h2>
<p style="margin: 0cm;font-size: medium;font-family: Calibri, sans-serif;color: rgb(0, 0, 0);font-style: normal;font-weight: 400;text-align: start;text-indent: 0px;text-decoration: none;">PostgreSQL supports several procedural languages, including PL/SQL, PL/Python. These languages allow you to write stored procedures, triggers, and other database objects using a familiar programming language.</p>
<h2 style='margin-right: 0cm;margin-left: 0cm;font-size:24px;font-family: "Times New Roman", serif;color: rgb(0, 0, 0);font-style: normal;text-align: start;text-indent: 0px;text-decoration: none;'>How to Use Procedural Languages for a PostgreSQL Extension</h2>
<p style="margin: 0cm;font-size: medium;font-family: Calibri, sans-serif;color: rgb(0, 0, 0);font-style: normal;font-weight: 400;text-align: start;text-indent: 0px;text-decoration: none;">To use a procedural language in a PostgreSQL extension, you need to do the following:</p>
<div style='margin:0cm;font-size:16px;font-family:"Calibri",sans-serif;'>
    <ul style="list-style-type: disc;margin-left:8px;">
        <li style='margin:0cm;font-size:16px;font-family:"Calibri",sans-serif;'><strong><em>Install the language:</em></strong> Use the&nbsp;<strong><span style="font-size:14px;font-family: Monaco;border: 1pt solid rgb(217, 217, 227);padding: 0cm;">CREATE LANGUAGE</span></strong> command to install the desired procedural language in your PostgreSQL database.&nbsp;</li>
    </ul>
</div>
<p style="margin: 0cm;font-size: medium;font-family: Calibri, sans-serif;color: rgb(0, 0, 0);font-style: normal;font-weight: 400;text-align: start;text-indent: 0px;text-decoration: none;">&nbsp;</p>
<p style="margin: 0cm;font-size: medium;font-family: Calibri, sans-serif;color: rgb(0, 0, 0);font-style: normal;font-weight: 400;text-align: start;text-indent: 0px;text-decoration: none;">For example, to install PL/Python:</p>
<p style="margin: 0cm;font-size: medium;font-family: Calibri, sans-serif;color: rgb(0, 0, 0);font-style: normal;font-weight: 400;text-align: start;text-indent: 0px;text-decoration: none;">CREATE LANGUAGE plpythonu;</p>
<p style="margin: 0cm;font-size: medium;font-family: Calibri, sans-serif;color: rgb(0, 0, 0);font-style: normal;font-weight: 400;text-align: start;text-indent: 0px;text-decoration: none;">&nbsp;</p>
<div style='margin:0cm;font-size:16px;font-family:"Calibri",sans-serif;'>
    <ul style="list-style-type: disc;margin-left:8px;">
        <li style='margin:0cm;font-size:16px;font-family:"Calibri",sans-serif;'><strong><em>Create the function:</em></strong> Write a function in your procedural language that performs the desired operation.&nbsp;</li>
    </ul>
</div>
<p style="margin: 0cm;font-size: medium;font-family: Calibri, sans-serif;color: rgb(0, 0, 0);font-style: normal;font-weight: 400;text-align: start;text-indent: 0px;text-decoration: none;">&nbsp;</p>
<p style="margin: 0cm;font-size: medium;font-family: Calibri, sans-serif;color: rgb(0, 0, 0);font-style: normal;font-weight: 400;text-align: start;text-indent: 0px;text-decoration: none;">For example, here&apos;s a simple function written in PL/Python that returns the sum of two integers:</p>
<p style="margin: 0cm;font-size: medium;font-family: Calibri, sans-serif;color: rgb(0, 0, 0);font-style: normal;font-weight: 400;text-align: start;text-indent: 0px;text-decoration: none;">CREATE FUNCTION my_sum(a INTEGER, b INTEGER) RETURNS INTEGER</p>
<p style="margin: 0cm;font-size: medium;font-family: Calibri, sans-serif;color: rgb(0, 0, 0);font-style: normal;font-weight: 400;text-align: start;text-indent: 0px;text-decoration: none;">AS $$</p>
<p style="margin: 0cm;font-size: medium;font-family: Calibri, sans-serif;color: rgb(0, 0, 0);font-style: normal;font-weight: 400;text-align: start;text-indent: 0px;text-decoration: none;">&nbsp; &nbsp;&nbsp;return a + b</p>
<p style="margin: 0cm;font-size: medium;font-family: Calibri, sans-serif;color: rgb(0, 0, 0);font-style: normal;font-weight: 400;text-align: start;text-indent: 0px;text-decoration: none;">$$ LANGUAGE plpythonu;</p>
<p style="margin: 0cm;font-size: medium;font-family: Calibri, sans-serif;color: rgb(0, 0, 0);font-style: normal;font-weight: 400;text-align: start;text-indent: 0px;text-decoration: none;">&nbsp;</p>
<div style='margin:0cm;font-size:16px;font-family:"Calibri",sans-serif;'>
    <ul style="list-style-type: disc;margin-left:8px;">
        <li style='margin:0cm;font-size:16px;font-family:"Calibri",sans-serif;'><strong><em>Build the extension:</em></strong> In your extension&apos;s Makefile, include the procedural language as a dependency.</li>
    </ul>
</div>
<p style="margin: 0cm;font-size: medium;font-family: Calibri, sans-serif;color: rgb(0, 0, 0);font-style: normal;font-weight: 400;text-align: start;text-indent: 0px;text-decoration: none;">&nbsp;</p>
<p style="margin: 0cm;font-size: medium;font-family: Calibri, sans-serif;color: rgb(0, 0, 0);font-style: normal;font-weight: 400;text-align: start;text-indent: 0px;text-decoration: none;">For example, to include PL/Python:</p>
<p style="margin: 0cm;font-size: medium;font-family: Calibri, sans-serif;color: rgb(0, 0, 0);font-style: normal;font-weight: 400;text-align: start;text-indent: 0px;text-decoration: none;">MODULES = myextension</p>
<p style="margin: 0cm;font-size: medium;font-family: Calibri, sans-serif;color: rgb(0, 0, 0);font-style: normal;font-weight: 400;text-align: start;text-indent: 0px;text-decoration: none;">DATA = myextension--1.0.sql</p>
<p style="margin: 0cm;font-size: medium;font-family: Calibri, sans-serif;color: rgb(0, 0, 0);font-style: normal;font-weight: 400;text-align: start;text-indent: 0px;text-decoration: none;">PG_CONFIG = pg_config</p>
<p style="margin: 0cm;font-size: medium;font-family: Calibri, sans-serif;color: rgb(0, 0, 0);font-style: normal;font-weight: 400;text-align: start;text-indent: 0px;text-decoration: none;">PGXS := $(shell $(PG_CONFIG) --pgxs)</p>
<p style="margin: 0cm;font-size: medium;font-family: Calibri, sans-serif;color: rgb(0, 0, 0);font-style: normal;font-weight: 400;text-align: start;text-indent: 0px;text-decoration: none;">REGRESS = myextension_test</p>
<p style="margin: 0cm;font-size: medium;font-family: Calibri, sans-serif;color: rgb(0, 0, 0);font-style: normal;font-weight: 400;text-align: start;text-indent: 0px;text-decoration: none;">DOCS = README.md</p>
<p style="margin: 0cm;font-size: medium;font-family: Calibri, sans-serif;color: rgb(0, 0, 0);font-style: normal;font-weight: 400;text-align: start;text-indent: 0px;text-decoration: none;">PLPYTHONU = $(shell $(PG_CONFIG) --pkglibdir)/plpythonu</p>
<p style="margin: 0cm;font-size: medium;font-family: Calibri, sans-serif;color: rgb(0, 0, 0);font-style: normal;font-weight: 400;text-align: start;text-indent: 0px;text-decoration: none;">include $(PGXS)</p>
<p style="margin: 0cm;font-size: medium;font-family: Calibri, sans-serif;color: rgb(0, 0, 0);font-style: normal;font-weight: 400;text-align: start;text-indent: 0px;text-decoration: none;">&nbsp;</p>
<p style="margin: 0cm;font-size: medium;font-family: Calibri, sans-serif;color: rgb(0, 0, 0);font-style: normal;font-weight: 400;text-align: start;text-indent: 0px;text-decoration: none;">myextension.so: myextension.o</p>
<p style="margin: 0cm;font-size: medium;font-family: Calibri, sans-serif;color: rgb(0, 0, 0);font-style: normal;font-weight: 400;text-align: start;text-indent: 0px;text-decoration: none;">&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS) $(PLPYTHONU)</p>
<p style="margin: 0cm;font-size: medium;font-family: Calibri, sans-serif;color: rgb(0, 0, 0);font-style: normal;font-weight: 400;text-align: start;text-indent: 0px;text-decoration: none;">&nbsp;</p>
<div style='margin:0cm;font-size:16px;font-family:"Calibri",sans-serif;'>
    <ul style="list-style-type: disc;margin-left:8px;">
        <li style='margin:0cm;font-size:16px;font-family:"Calibri",sans-serif;'><strong><em>Test the function</em></strong>: After building and installing the extension, you can test your function using the&nbsp;<strong><span style="font-size:14px;font-family: Monaco;border: 1pt solid rgb(217, 217, 227);padding: 0cm;">SELECT</span></strong>command.&nbsp;</li>
    </ul>
</div>
<p style="margin: 0cm;font-size: medium;font-family: Calibri, sans-serif;color: rgb(0, 0, 0);font-style: normal;font-weight: 400;text-align: start;text-indent: 0px;text-decoration: none;">&nbsp;</p>
<p style="margin: 0cm;font-size: medium;font-family: Calibri, sans-serif;color: rgb(0, 0, 0);font-style: normal;font-weight: 400;text-align: start;text-indent: 0px;text-decoration: none;">For example:</p>
<p style="margin: 0cm;font-size: medium;font-family: Calibri, sans-serif;color: rgb(0, 0, 0);font-style: normal;font-weight: 400;text-align: start;text-indent: 0px;text-decoration: none;">SELECT my_sum(1, 2);</p>
<p style="margin: 0cm;font-size: medium;font-family: Calibri, sans-serif;color: rgb(0, 0, 0);font-style: normal;font-weight: 400;text-align: start;text-indent: 0px;text-decoration: none;">This should return the value&nbsp;<code style='font-family: "Courier New";'><strong><span style="font-size:14px;font-family: Monaco;color: black;border: 1pt solid rgb(217, 217, 227);padding: 0cm;">3</span></strong></code>.</p>
<p style="margin: 0cm;font-size: medium;font-family: Calibri, sans-serif;color: rgb(0, 0, 0);font-style: normal;font-weight: 400;text-align: start;text-indent: 0px;text-decoration: none;">&nbsp;</p>
<p style="margin: 0cm;font-size: medium;font-family: Calibri, sans-serif;color: rgb(0, 0, 0);font-style: normal;font-weight: 400;text-align: start;text-indent: 0px;text-decoration: none;">You can now use procedural languages in your PostgreSQL extension to write stored procedures, triggers, and other database objects using a familiar programming language.</p>
<p style="margin: 0cm;font-size: medium;font-family: Calibri, sans-serif;color: rgb(0, 0, 0);font-style: normal;font-weight: 400;text-align: start;text-indent: 0px;text-decoration: none;">&nbsp;</p>
<p style="margin: 0cm;font-size: medium;font-family: Calibri, sans-serif;color: rgb(0, 0, 0);font-style: normal;font-weight: 400;text-align: start;text-indent: 0px;text-decoration: none;">&nbsp;</p>
<p style="margin: 0cm;font-size: medium;font-family: Calibri, sans-serif;color: rgb(0, 0, 0);font-style: normal;font-weight: 400;text-align: start;text-indent: 0px;text-decoration: none;">&nbsp;</p>
<p style="margin: 0cm;font-size: medium;font-family: Calibri, sans-serif;color: rgb(0, 0, 0);font-style: normal;font-weight: 400;text-align: start;text-indent: 0px;text-decoration: none;">&nbsp;</p>
