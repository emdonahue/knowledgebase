# kb
A set of utilities for creating a personal, text-minable knowledgebase out of your pdfs, documents, and notes.

A new knowledgebase can be created with `kb init`, which generates the directory structure used by the various utilities. PDFs and other document typse can be dowloaded into the "inbox" directory, and then processed by visiting the root of the knowledgebase directory and running `kb ingest`. Once documents have been processed, the various other utilities can be used to search, annotate, and analyze the collection. Knowledgebases can be created per project, or as one all-purpose knowledgebase for research notes.

## Documentation
```
kb - Personal KnowledgeBase utility for organizing and searching PDFs, other text-based media, notes, etc.
Usage: kb SUBCOMMAND [ARGUMENTS...]

Subcommands:
	--help|-h|help [SUBCOMMAND]	Prints help text for SUBCOMMAND. If SUBCOMMAND omitted, prints list of subcommands.
	bib SEARCH	Opens the bibliography file with title matching SEARCH term using $EDITOR.
	import 	Consumes files in inbox and generates appropriate archival copies, analysis extracts, and metadata containers.
	init 	Generates a new directory structure for use by kb in the current directory.
	ls [OPTION...] SEARCH	Lists files matching search criteria.
	md5 [OPTION]... SEARCH	Searches for files matching SEARCH string and prints a list of md5's for further processing. SEARCH is matched against all bibtex fields and the md5 hash itself. Use options to limit the bibtex search or search notes or fulltext.
	notes SEARCH	Opens the notes file for the document with title matching the SEARCH term using $EDITOR.	
```
## TODO
- enable searching by keyword
- add easy metadata editing shortcuts
- use sed hold space to clip out title, author, year in desired order
