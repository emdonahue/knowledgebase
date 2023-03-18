# kb
A set of utilities for creating a personal, text-minable knowledgebase out of your pdfs, documents, and notes.

A new knowledgebase can be created with `kb init`, which generates the directory structure used by the various utilities. PDFs and other document typse can be dowloaded into the "inbox" directory, and then processed by visiting the root of the knowledgebase directory and running `kb ingest`. Once documents have been processed, the various other utilities can be used to search, annotate, and analyze the collection. Knowledgebases can be created per project, or as one all-purpose knowledgebase for research notes.

## Documentation
```
kb - Personal KnowledgeBase utility for organizing and searching PDFs, other text-based media, notes, etc.
Usage: kb SUBCOMMAND [ARGUMENTS...]

Subcommands:
	--help|-h|help [SUBCOMMAND]	Prints help text for SUBCOMMAND. If SUBCOMMAND omitted, prints list of subcommands.
	bib [OPTION...] QUERY	Adds or removes records from the bibliography files identified by QUERY. If addition/deletion options are not supplied, print bibliographic data instead.
	import 	Consumes files in inbox and generates appropriate archival copies, analysis extracts, and metadata containers.
	init 	Generates a new directory structure for use by kb in the current directory.
	ls [QUERY]	Lists files matching QUERY. If QUERY omitted, list all files.
	md5 [QUERY]	Prints md5s of files matching QUERY. If QUERY is omitted, print all md5s.
	open QUERY	Opens the document matching QUERY using xdg-open to select an appropriate application.
	org QUERY	Opens the org notes file for the document matching QUERY using $EDITOR.
```
## TODO
- add options to ls to display different columns
- handle multiple filetypes that get added with same md5 (rtf and txt)
- handle merging versions of the same bibliographic item (symlink notes and bib?)
- add search by md5
- add dates to query language
- add regex alongside -eq, maybe -re
- add bib formatter for bibtex output
- make sed case insensitive for substr match
- guarantee keywords already exist when adding if specified
- unique the bib entry fields after editing
- use sed hold space to clip out title, author, year in desired order
