#!/usr/bin/env bash

usage() {
  # redirect STDOUT to STDERR
  echo "Usage: $0 [ -f FILE ] [ -t INT ]" 1>&2 
  exit 1
}

while getopts ":f:t:" options; do
  case "${options}" in
    f)
      file=${OPTARG}
      ;;
    t)
      thread=${OPTARG}
      regex='^[1-9][0-9]*$'
      if [[ ! $thread =~ $regex ]]; then
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

# OPTIND is the number of arguments that are options or arguments to options
if [ $OPTIND -ne 5 ]; then
  usage
fi

printf "File: %s\nThreads: %d\n" $file $thread

exit 0

