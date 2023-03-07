#!/usr/bin/env bash
#
# Adapted from https://www.shellscript.sh/examples/getopt/
#
set -euo pipefail

alpha=unset
beta=unset
gamma=unset
delta=unset

usage(){
>&2 cat << EOF
Usage: $0
   [ -a | --alpha ]
   [ -b | --beta ]
   [ -g | --gamma input ] 
   [ -d | --delta input ]
   <infile> [infiles]
EOF
exit 1
}

>&2 echo [$@] passed to script

args=$(getopt -a -o abhc:d: --long alpha,beta,help,gamma:,delta: -- "$@")
if [[ $? -gt 0 ]]; then
  usage
fi

>&2 echo getopt creates [${args}]

eval set -- ${args}
while :
do
  case $1 in
    -a | --alpha)   alpha=1    ; shift   ;;
    -b | --beta)    beta=1     ; shift   ;;
    -h | --help)    usage      ; shift   ;;
    -c | --gamma)   gamma=$2   ; shift 2 ;;
    -d | --delta)   delta=$2   ; shift 2 ;;
    # -- means the end of the arguments; drop this, and break out of the while loop
    --) shift; break ;;
    *) >&2 echo Unsupported option: $1
       usage ;;
  esac
done

if [[ $# -eq 0 ]]; then
  usage
fi

>&2 echo "alpha   : ${alpha}"
>&2 echo "beta    : ${beta} "
>&2 echo "gamma   : ${gamma}"
>&2 echo "delta   : ${delta}"
>&2 echo "$# parameter/s remaining: $@"
>&2 echo "Looping through remaining parameter/s:"
# set input field separator to keep quoted parameters together
# for example, "my input" will remain as one input
IFS=$'\n'
for param in $@; do
   >&2 echo -e "\t${param}"
done
exit 0
