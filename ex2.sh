#!/bin/sh
#Cau 2: In ra thong tin cua he dieu hanh

#Hien thi ngay gio hien tai
now=$(date)
echo $now

#Hien thi cac tien trinh hien co
echo
echo "Process:"
echo
ps

#Hien thi tinh trang bo nho
echo
echo
echo "Memory usage:"
echo
free -h

#Hien thi thong tin CPU
echo
echo
echo "CPU load:"
echo
uptime

#Hien thi thong tin phien ban kernel
echo
echo
echo "Kernel version is:"
echo
uname -r
echo
