#!/usr/bin/env bash

set -euo pipefail

num_param=1

usage(){
   echo "Usage: $0 <file.Rmd> [outfile.pptx]"
   exit 1
}

if [[ $# -lt ${num_param} ]]; then
   usage
fi

check_depend (){
   tool=$1
   if [[ ! -x $(command -v ${tool}) ]]; then
     >&2 echo Could not find ${tool}
     exit 1
   fi
}

dependencies=(docker)
for tool in ${dependencies[@]}; do
   check_depend ${tool}
done


infile=$(realpath $1)
if [[ ! ${infile} =~ \.Rmd$ ]]; then
   >&2 echo Input file [${infile}] does not end with .Rmd
   exit 1
fi

if [[ ! -e ${infile} ]]; then
  >&2 echo ${infile} does not exist
  exit 1
fi

outbase=$(basename ${infile} .Rmd).pptx
if [[ $# -ge 2 ]]; then
   outbase=$2
fi
outfile=$(dirname ${infile})/${outbase}

now(){
   date '+%Y/%m/%d %H:%M:%S'
}

SECONDS=0

>&2 printf "[ %s %s ] Start job\n\n" $(now)

# go to script directory
cd $(dirname $0)

# copy file to make it accessible to container
# note that the PowerPoint file will not render plots if the file extension is not Rmd!
# the the temporary file will have two .Rmd suffixes
cp ${infile} ${infile}.Rmd

r_version=4.1.3
docker_image=davetang/r_build:${r_version}
package_dir=${HOME}/r_packages_${r_version}

if [[ ! -d ${package_dir} ]]; then
   mkdir ${package_dir}
fi

USERID=$(id -u)
GROUPID=$(id -g)

docker run \
   --rm \
   -v ${package_dir}:/packages \
   -v $(pwd):$(pwd) \
   -w $(pwd) \
   ${docker_image} \
   /usr/bin/env bash -c "Rscript -e \"rmarkdown::render('${infile}.Rmd', output_file = '${outfile}')\" && chown ${USERID}:${GROUPID} ${outfile}"

rm ${infile}.Rmd

>&2 printf "\n[ %s %s ] Work complete\n" $(now)

duration=$SECONDS
>&2 echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."

exit 0

