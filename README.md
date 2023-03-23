# kb
A set of utilities for creating a personal, text-minable knowledgebase out of your pdfs, documents, and notes.

A new knowledgebase can be created with `kb init`, which generates the directory structure used by the various utilities. PDFs and other document typse can be dowloaded into the "inbox" directory, and then processed by visiting the root of the knowledgebase directory and running `kb import`. Once documents have been processed, the various other utilities can be used to search, annotate, and analyze the collection. Knowledgebases can be created per project, or as one all-purpose knowledgebase for research notes.

## Querying
kb stores all files as md5 hashes of their contents. Most of its subcommands involve querying a list of those md5s by metadata or content, and then postprocessing that list to, for instance, display a list of titles, open a notes file in an editor, etc. Consequently, most commands accept a QUERY, which can be composed from the following operators inspired by the unix `test` command:

```
-q QUERY -- Begins a query. Usually optional.
-a QUERY -- Logical "and".
-o QUERY -- Logical "or".
A -eq B or -eq A B -- Equals. Searches for a substring in a specified metadata field or content block.
A -ne B or -ne A B -- Not equals. Inverts results of -eq.
--bib -eq A or --bib ne A -- Wildcard specifying a match with any metadata field in the bibliography file.
--org -eq A or --org -ne A -- Full content search of the org note document.
--subq FILE -- Subquery. Reads md5s from FILE.
```

Using the `ls` command as a running example, the following example queries demonstrate the range of expressions allowable with this query language. Note that associativity is always left to right, as the query terms are processed in order:

Search for a substring in a title:
```zsh
> kb ls -q title -eq midsummer
"A Midsummer Night's Dream"
```

Search for a substring in a title:
```zsh
> kb ls -q title -eq midsummer
"A Midsummer Night's Dream"
```

Search all bibliographic fields:
```zsh
> kb ls -q --bib -eq shakespeare
"A Midsummer Night's Dream"
"The Complete Works of William Shakespeare"
```

Search for files for which your org notes metion the search term
```zsh
> kb ls -q --org -eq shakespeare
"The Complete Works of William Shakespeare"
```

Search by title and author:
```zsh
> kb ls -q title -eq midsummer -a author -eq shakespeare
"A Midsummer Night's Dream"
```

Search by title or author:
```zsh
> kb ls -q title -eq midsummer -o author -eq 'bob dylan'
"A Midsummer Night's Dream"
"Blood on the Tracks"
```

Use the -i flag in any query to interactively select just one md5 instead of returning the whole list:
```zsh
> kb ls -i -q --bib -eq shakespeare
1) "A Midsummer Night's Dream"
2) "The Complete Works of William Shakespeare"
Type a number ot disambiguate:
> kb 1
"A Midsummer Night's Dream"
```

Note that because the -a and -o flags join the subsequent query with stdin, they can be used to pipe a custom list of md5s into a query from any manual or automatic process. However, the md5s must be sorted alphabetically. Note also that -q is omitted since this is not the beginning of a new query but rather a subquery within a larger query.

```zsh
> echo '99a5d408069900d268c56c79e68a1670\nc6793099238dfa432f0f718b071ee8a5' | sort | kb ls -a
"A Midsummer Night's Dream"
"The Complete Works of William Shakespeare"
```

Other commands operate on the same query principle. For instance, `bib` applies the modifications to bibliographic data specified using its options to all md5s returned by the query. The following query adds the keyword "plays" to the results of the query.

```zsh
> kb bib -m keyword=plays -q title -eq midsummer -a author -eq shakespeare
```

For complex queries that require grouping, use --subq to compose subqueries along with the `md5` subcommand to search over raw md5s. For instance, to query (author1 OR author2) AND (title1 OR title2):
```zsh
> kb ls -q title -eq midsummer -o -title -eq tracks -a --subq <(kb md5 -q author -eq 'bob dylan' -o author -eq shakespeare)
"A Midsummer Night's Dream"
"Blood on the Tracks"
```

## Documentation
```
kb - Personal KnowledgeBase utility for organizing and searching PDFs, other text-based media, notes, etc.
Usage: kb SUBCOMMAND [ARGUMENTS...]

Subcommands:
	--help|-h|help [SUBCOMMAND]	Prints help text for SUBCOMMAND. If SUBCOMMAND omitted, prints list of subcommands.
	bib [OPTION...] QUERY	Adds or removes records from the bibliography files identified by QUERY. If addition/deletion options are not supplied, print bibliographic data instead.
	import 	Consumes files in inbox and generates appropriate archival copies, analysis extracts, and metadata containers. Automatically adds both a title and a filename field to the bibliography, both corresponding to the original filename.
	init 	Generates a new directory structure for use by kb in the current directory.
	ls [QUERY]	Prints a TSV of files matching QUERY. If QUERY omitted, list all files.
	md5 [QUERY]	Prints md5s of files matching QUERY. If QUERY is omitted, print all md5s.
	open QUERY	Opens the document matching QUERY using xdg-open to select an appropriate application.
	org QUERY	Opens the org notes file for the document matching QUERY using $EDITOR.
```
## TODO
- add options to ls to display different columns (use awk)
- handle multiple filetypes that get added with same md5 (rtf and txt)
- handle merging versions of the same bibliographic item (symlink notes and bib?)
- add search by md5
- add dates to query language
- add regex alongside -eq, maybe -re
- add bib formatter for bibtex output
- guarantee keywords already exist when adding if specified
