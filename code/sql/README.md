## README

Use https://dbplyr.tidyverse.org/articles/sql-translation.html to translate expressions to SQL.

```r
library(dbplyr)
library(dplyr)

translate_sql(mean(x, na.rm = TRUE))
<SQL> AVG(`x`) OVER ()
```

### MySQL

Save MySQL server information in an MySQL config file (`~/.my.cnf`).

```
[clientucsc]
user=genome
password=
host=genome-mysql.cse.ucsc.edu
```

Use `--defaults-group-suffix=` to use settings from `[clientucsc]`.

```bash
mysql --defaults-group-suffix=ucsc -A -e "select chrom, size from hg19.chromInfo" > hg19_info.tsv
```

