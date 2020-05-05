#!/usr/bin/env bash

usage() {
  echo -e "
Usage: $0 < -f FILE > [ -c INT ]\n
 -f     input CSV file with header
 -c     number of columns to plot
" 1>&2 
  exit 1
}

columns=5

while getopts ":c:f:" options; do
  case "${options}" in
    f)
      file=${OPTARG}
      ;;
    c)
      columns=${OPTARG}
      regex='^[1-9][0-9]*$'
      if [[ ! $columns =~ $regex ]]; then
        usage
      fi
      ;;
    :)
      echo "Error: -${OPTARG} requires an argument."
      exit 1
      ;;
    *)
      usage ;;
  esac
done

if [ -z "$file" ]
then
  usage
fi

now=$(date "+%Y%m%d_%H%M%S")

# double quotes for interpolation
Rscript -e "rmarkdown::render('plot_csv.Rmd', params = list(file = \"$file\", columns = \"$columns\"), output_file=\"$now.html\")"

exit 0

