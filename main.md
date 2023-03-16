<h1>Basics of extension</h1>

<p>Extensions are a loaded set of functions. They enable additional functionality based on the needs of your application. 
Extentions help Postgres extend beyond Core PostgreSTL funtionality and are easy ti use and develop.</p>
<h3>Minimum Requirements for an Extention</h3>
<ul>
  <li> Requires a control file
  <li> Requires a script of SQL commands with funtion definitions
  <li> Can also have loadable modules (Not entirely necessary)
</ul>

<h3>Basic Syntax to make an Extention</h3>
CREATE EXTENSION [ IF NOT EXISTS ] extension_name<br>
    [ WITH ] [ SCHEMA schema_name ]<br>
             [ VERSION version ]<br>
             [ CASCADE ]<br>
