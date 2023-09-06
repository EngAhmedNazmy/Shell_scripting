#!/bin/bash
set -x
read -r -p "enter number " n
for ((k=1;k<=n;k++))
do
            echo k="${k}"
        echo $((RANDOM % 50 + 1))> ~/file$k
        md5sum file$k>> ~/filemd5sum
done
awk '{print $1}' filemd5sum >> ~/filemd5sum2

for ((i=1;i<=n;i++))
do
            echo i="${i}"
            for ((j=i+1;j<=n;j++))
            do
                        echo j="${j}"
                        var1=$(awk "NR==\"$i\"" filemd5sum2)
                        echo "${var1}"
                        var2=$(awk "NR==\"$j\"" filemd5sum2)
                        echo "${var2}"
                        if [ "$var1" == "$var2" ]
                        then
                      echo "file${i}=file${j}">> ~/filerslt
                        fi
            done
done
set -x