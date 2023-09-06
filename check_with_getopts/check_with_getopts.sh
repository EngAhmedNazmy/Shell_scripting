#!/bin/bash
set -x
while getopts "p:" ahmed ; do
  case ${ahmed} in
	p)
	 p=${OPTARG}
	 echo "the path for the created files is ${OPTARG}"
	 ;;
	*)
	 usage
	 ;;
  esac
done
#shift $((OPTIND-1))
if [[ -n "${p}" ]]
 then
	created_path=${p}
 else
	read -r -p "enter absolute path for the created files: " created_path
fi
echo "${created_path}"
cd "${created_path}"||exit
pwd
find "${created_path}" -type f -exec md5sum {} + > filemd5sum
#get the md5sum of all files in given path
cat filemd5sum
awk '{print $1}' filemd5sum> filemd5sum2
#create a file containing the first column of the first file
awk '{print $2}' filemd5sum> filemd5sum3
n=$(wc -l < "${created_path}"/filemd5sum2)
#n=number of lines in the file
for ((i=1;i<=n;i++))
do
	echo i="${i}"
	for ((j=i+1;j<=n;j++))
	do
		echo j="${j}"
		var1=$(awk "NR==\"$i\"" filemd5sum2)
		var3=$(awk "NR==\"$i\"" filemd5sum3)
		echo "${var1}"
		var2=$(awk "NR==\"$j\"" filemd5sum2)
		var4=$(awk "NR==\"$j\"" filemd5sum3)
		echo "${var2}"
		if [ "$var1" == "$var2" ]
    		then
	          echo "${var3}=${var4}">> fileresult
		fi
	done
done
set -x