# Data

`iris.csv`

```r
Rscript -e 'write.csv(iris, "iris.csv", row.names = FALSE)'
```

`example.json`

```bash
curl -H 'Accept: application/json' \
-H 'Content-type: application/json' -X POST \
-d '{ "ids" : ["rs116035550", "COSM476" ] }' \
https://rest.ensembl.org/vep/human/id/ > example.json
```

