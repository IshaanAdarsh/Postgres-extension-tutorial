The tutorial should be a quick start guide that assumes only knowledge of Postgres and the target language:

### Prerequisites for writing an extension
- Understanding the Postgres extension architecture and how it works
- Explain what a Postgres extension is and its purpose.
- Highlight the benefits of creating extensions for Postgres
- Provide a list of software and tools required for developing a Postgres extension.
  - Sql Script File, Makefile, Control File, etc.
- Ensure that Postgres and the necessary development libraries are installed and properly set up.
- Specify the supported target languages and their corresponding development environments.
  - C,C++,Python,Java,Ruby,JavaScript (PLV8),Perl,PHP,.NET,etc.

### How to start writing an extension
- 
-   How to write a Makefile and what it should do
-   Do I need PGXS? How does it work?
-   Do I need PGXN? How does it work?
-   How to use Postgres Procedural Languages for the extension
-   How to use languages external to Postgres for the extension
-   How to write regression tests for the extension
-   Extension release management and upgradability
