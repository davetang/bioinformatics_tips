#!/usr/bin/env bash
#
# adapted from https://gist.github.com/m-radzikowski/53e0b39e9a59a1518990e76c2bff8038
#

#
# https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
#
# -E If set, any trap on ERR is inherited by shell functions, command
# substitutions, and commands executed in a subshell environment. The ERR trap
# is normally not inherited in such cases.
#
# -e Exit immediately if a pipeline (see Pipelines), which may consist of a
# single simple command (see Simple Commands), a list (see Lists), or a
# compound command (see Compound Commands) returns a non-zero status
#
# -u Treat unset variables and parameters other than the special parameters ‘@’
# or ‘*’ as an error when performing parameter expansion.
#
# -o pipefail If set, the return value of a pipeline is the value of the last
# (rightmost) command to exit with a non-zero status, or zero if all commands
# in the pipeline exit successfully.
set -Eeuo pipefail

#
# SIGINT - usually <control>+c
# SIGTERM - exit code 143, polite kill
# SIGKILL - exit code 137, brutal kill, i.e. kill -9
#
# ERR and EXIT do not correspond to any signals, they are implemented
# internally by Bash; used in conjunction with set -E
# see https://stackoverflow.com/questions/26260581/what-is-the-actual-signal-behind-err
trap cleanup SIGINT SIGTERM ERR EXIT

# https://stackoverflow.com/questions/35006457/choosing-between-0-and-bash-source
script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

usage() {
  cat <<EOF
Usage: $(basename "${BASH_SOURCE[0]}") [options] arg1 <arg2> ...

Script description here.

Optional arguments:

-h, --help      Print this help and exit
-v, --verbose   Print script debug info
-f, --flag      Some flag description
-p, --param     Some param description

EOF
  exit
}

cleanup() {
  trap - SIGINT SIGTERM ERR EXIT
  # script cleanup here
}

# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html
#
# -t fd True if file descriptor fd is open and refers to a terminal.
# -z string True if the length of string is zero.
# TERM env explained in https://bash.cyberciti.biz/guide/%24TERM_variable
#
# for the colour settings see
# https://unix.stackexchange.com/questions/116243/what-does-a-bash-sequence-033999d-mean-and-where-is-it-explained
setup_colors() {
  if [[ -t 2 ]] && [[ -z "${NO_COLOR-}" ]] && [[ "${TERM-}" != "dumb" ]]; then
    NOFORMAT='\033[0m' RED='\033[0;31m' GREEN='\033[0;32m' ORANGE='\033[0;33m' BLUE='\033[0;34m' PURPLE='\033[0;35m' CYAN='\033[0;36m' YELLOW='\033[1;33m'
  else
    NOFORMAT='' RED='' GREEN='' ORANGE='' BLUE='' PURPLE='' CYAN='' YELLOW=''
  fi
}

msg() {
  echo >&2 -e "${1-}"
}

die() {
  local msg=$1
  local code=${2-1} # default exit status 1
  msg "$msg"
  exit "$code"
}

parse_params() {
  # default values of variables set from params
  flag=0
  param=default

  # https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html
  # ${parameter:-word}
  # If parameter is unset or null, the expansion of word is substituted.
  # Otherwise, the value of parameter is substituted.
  # echo ${notset-default}

  # set -x Print a trace of simple commands, for commands, case commands,
  # select commands, and arithmetic for commands and their arguments or
  # associated word lists after they are expanded and before they are executed.

  # case statement syntax
  #
  # case EXPRESSION in
  #   PATTERN_1)
  #     STATEMENTS
  #     ;;
  #   PATTERN_N)
  #     STATEMENTS
  #     ;;
  #   *)
  #     STATEMENTS
  #     ;;
  # esac
  #
  # -?* is used to match unknown arguments
  # * will always match and in this case is used to end the while loop

  while :; do
    case "${1-}" in
    -h | --help) usage ;;
    -v | --verbose) set -x ;;
    --no-color) NO_COLOR=1 ;;
    -f | --flag) flag=1 ;; # example flag
    -p | --param) # example named parameter
      param="${2-}"
      shift
      ;;
    -?*) die "Unknown option: $1" ;;
    *) break ;;
    esac
    shift
  done

  args=("$@")
  # echo ${#args[@]}

  # check required positional arguments
  [[ ${#args[@]} -eq 0 ]] && usage

  return 0
}

parse_params "$@"
setup_colors

# script logic here

msg "${RED}Read parameters:${NOFORMAT}"
msg "- flag: ${flag}"
msg "- param: ${param}"
msg "- arguments: ${args[*]-}"

die Done 0

