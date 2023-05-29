<!DOCTYPE html>
<html>
<body>
	<h1>Sample Postgres Extension with Python</h1>
	<p>To illustrate the concepts covered in the tutorial, a sample Postgres extension can be developed using Python. Below is a detailed description of the process:</p>
<p>
	<h2>Prerequisites </h2>
	<ul>
		<li>Postgres installed on your machine</li>
		<li>Python installed on your machine</li>
		<li>Basic knowledge of SQL and Python</li>
	</ul>
</p>
  <p>
	<h2>Steps to create the extension</h2>
	<ol>
		<li>Create a new directory for your extension</li>
<pre><code>$ mkdir myextension
$ cd myextension</code></pre>
		<li>Create a new file called myextension.control:</li>
<pre><code>$ touch myextension.control</code></pre>
		<li>Edit the myextension.control file and add the following contents:</li>
<pre><code>comment = 'My Postgres extension'
default_version = '1.0'
module_pathname = '$libdir/myextension'
relocatable = true</pre></code>
		<li>Create a new file called myextension.py:</li>
<pre><code>$ touch myextension.py</code></pre>
		
		
</body>
</html>

		
