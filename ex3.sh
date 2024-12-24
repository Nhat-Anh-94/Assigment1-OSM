#!/bin/sh

#Hien thi danh sach cac he thong tap tin
echo "List of all filesystem"
df

#Hien thi cac tap tin con lai it hon 80% bo nho
echo "Filesystem less than 80% free space"
for line in $(df -h | tail -n +2 | tr -s ' ' | cut -d ' ' -f 1,5 --output-delimiter=,);do
    filesystem=$(echo $line | cut -d ',' -f 1)
    usage=$(echo $line | cut -d ',' -f 2 | tr -d '%')
    if [ "$usage" -gt 20 ]; then
	echo "$filesystem: $usage% used"
    fi
done

