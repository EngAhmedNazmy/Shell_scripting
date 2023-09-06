#!/bin/bash
set -x
Help()
{
   # Display Help
   echo "This script is used to created number of files you need on the path you determine."
   echo "By default this script create 25 file in your current location, unless you insert them" 
   echo "Syntax: scriptTemplate [-p|-n|-h]"
   echo "options:"
   echo "p     Print the path you need to create files in."
   echo "n     Print the number of files needed to be created."   
}

while getopts ":hp:n:" ahmed ; do
  case ${ahmed} in
  	h)# display Help
        Help
  	 ;;
	p)
	 p=${OPTARG}
	 echo "the path to create files is ${OPTARG}"
	 ;;
	n)
	 n=${OPTARG}
	 echo "the number of files to create is ${OPTARG}"
	 ;;
	\?) # incorrect option
         echo "Error: Invalid option"
	 ;;
  esac
done
if [[ -n "${p}" ]]
 then
	created_path=${p}
 else
	created_path=$PWD
fi
echo "${created_path}"

if [[ -n "${n}" ]]
 then
	number_created=${n}
 else
	number_created=25
fi
echo "${number_created}"
cd "${created_path}"||exit
pwd
for ((k=1;k<="$number_created";k++))
do
	echo $((RANDOM % 50 + 1))> file$k
done
set -x