#!/usr/bin/env bash

set -euo pipefail

version=4.3.0
rstudio_image=davetang/rstudio:${version}
container_name=rstudio_dtang_bioinfo
port=8989
package_dir=${HOME}/r_packages_${version}
path=$(realpath $(dirname $0)/..)

if [[ ! -d ${package_dir} ]]; then
   mkdir ${package_dir}
fi

docker run -d \
   -p ${port}:8787 \
   --rm \
   --name ${container_name} \
   -v ${package_dir}:/packages \
   -v ${path}:/home/rstudio/bioinformatics_tips \
   -e PASSWORD=password \
   -e USERID=$(id -u) \
   -e GROUPID=$(id -g) \
   ${rstudio_image}

>&2 echo ${container_name} listening on port ${port}
exit 0
