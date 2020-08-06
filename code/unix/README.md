## README

### Markdown

Use `pandoc` to convert Markdown to PDF.

```bash
pandoc -V geometry:margin=1in \
   -s \
   -S \
   --table-of-contents \
   --toc-depth=2 \
   --highlight-style=tango \
   my.md \
   -o my.html
```

### Bash tips

Find tools in a script; `-x` is true if file exists and is executable.

```bash
if ! [ -x "$(command -v samtools)" ]; then
  echo 'Error: could not find samtools.' 1>&2
  exit 1
fi
```

[Start bash scripts](http://redsymbol.net/articles/unofficial-bash-strict-mode/) with:

```bash
#!/usr/bin/env bash
set -euo pipefail
```

`set -euo pipefail` is short for:

```bash
set -e
set -u
set -o pipefail
```

1. `set -e` instructs bash to immediately exit if any command has a non-zero exit status.
2. `set -u` will cause the script to exit when a reference to any variable has not been previously defined (with the exceptions of $* and $@).
3.  `set -o pipefail` prevents errors in a pipeline from being masked.

Built-In Variables

* $0 -name of the script
* $n -positional parameters to script/function
* $$ -PID of the script
* $! -PID of the last command executed (and run in the background)
* $? -exit status of the last command  (${PIPESTATUS} for pipelined commands)
* $# -number of parameters to script/function
* $@ -all parameters to script/function (sees arguments as separate word)
* $* -all parameters to script/function (sees arguments as single word)

