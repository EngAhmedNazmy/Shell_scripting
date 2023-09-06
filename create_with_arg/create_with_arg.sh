#!/bin/bash
set -x
if [[ -n "$1" ]]
then
		created_path=$1
else
		read -r -p "enter full path to create files: " created_path
fi


echo "${created_path}"

if [[ -n "$2" ]]
then
	number_created=$2
else
	read -r "enter number of files to create: " number_created
fi

echo "${number_created}"
cd "${created_path}"||exit
pwd
for ((k=1;k<="${number_created}";k++))
do
	echo k="${k}"
        echo $((RANDOM % 50 + 1))> file$k
done
set -x