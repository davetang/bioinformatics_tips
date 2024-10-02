#!/usr/bin/env bash

set -euo pipefail

#$ -N job_name
#$ -q all.q
#$ -cwd
#$ -l h_rt=01:00:00
#$ -l h_rss=30720M,mem_free=30720M
#$ -S /bin/bash

export LANGUAGE=en_AU.UTF-8

printf "Hello World!\n"
