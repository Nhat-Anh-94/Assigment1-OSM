#!/bin/sh

fileName="$1"
outputFile="output.txt"
> "$outputFile"
#Nhap so dong bat dau hien thi
echo "Nhap so dong bat dau: "
read n
count=1
resultLine=""
while read -r line;do
    #Hien thi so dong tu n+1 tro di
    if [ "$count" -gt "$n" ]; then
	echo "$count. $line"
    fi
    #Ghi dong chia het cho 2 vao file output.txt
    if [ $(($count%2)) -eq 0 ]; then
	echo "$line" >> "$outputFile"
    fi
    #kiem tra neu so thu tu dong lon hon n
    if [ "$count" -gt "$n" ]; then
	resultLine="$resultLine$count. $line\n"
    fi
    
    count=$((count+1))
done < "$fileName"

#Ghi cac dong co so thu tu lon hon n vao output.txt
if [ -n "$resultLine" ]; then
    echo >> "$outputFile"
    echo "Cac dong co so thu tu lon hon $n: " >> "$outputFile"
    printf "%b" "$resultLine" >> "$outputFile"
fi
