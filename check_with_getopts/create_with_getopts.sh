#!/bin/bash
set -x
while getopts "p:n:" ahmed ; do
  case ${ahmed} in
	p)
	 p=${OPTARG}
	 echo "the path to create files is ${OPTARG}"
	 ;;
	n)
	 n=${OPTARG}
	 echo "the number of files to create is ${OPTARG}"
	 ;;
	*)
	 usage
	 ;;
  esac
done
shift $((OPTIND-1))

if [[ -n "${p}" ]]
 then
	created_path=${p}
 else
	read -r -p "enter path to create files: " created_path
fi
echo "${created_path}"

if [[ -n "${n}" ]]
 then
	number_created=${n}
 else
	read -r -p "enter number of files to create: " number_created
fi
echo "${number_created}"
cd "${created_path}"||exit
pwd
for ((k=1;k<="${number_created}";k++))
do
	echo $((RANDOM % 50 + 1))> file$k
done
set -x