#!/bin/bash
set -x
Help()
{
   # Display Help
   echo "This script is used to created number of files you need on the path you determine."
   echo "By default this script works in your current location, unless you insert it" 
   echo "Please remove any file named filemd5sum,filemd5sum2,filemd5sum3,and fileresult"
   echo "Syntax: scriptTemplate [-p|-n|-h]"
   echo "options:"
   echo "p     Print the path you need to create files in, if you didn't insert the path, we will use the current working directory."
}

while getopts ":hp:" ahmed ; do
  case ${ahmed} in
  	h)# display Help
         Help
  	 ;;
	p)
	 p=${OPTARG}
	 echo "the path to create files is ${OPTARG}"
	 ;;
	\?) # incorrect option
         echo "Error: Invalid option"
	 ;;
  esac
done
if [[ -n "${p}" ]]
 then
	created_path=${p} # if p not inserted
 else
	created_path="$HOME/Desktop"
fi
echo "${created_path}"
cd "${created_path}"||exit
pwd
find "${created_path}" -type f -exec md5sum {} + | sort > filemd5sum
#get the md5sum of all files in given path
#sort filemd5sum
cat filemd5sum
awk '{print $1}' filemd5sum> filemd5sum2
#create a file containing the first column of the first file
awk '{print $2}' filemd5sum> filemd5sum3
n=$(wc -l < "${created_path}"/filemd5sum2)
echo "${n}"
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
			else 
			  break
		fi
	done
done
set -x