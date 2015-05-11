#!/bin/bash

# 判断一个路径是文件还是文件夹
read -p 'Please input the filename: ' filename
fpath=$filename

if [ -d $fpath ]; then
	echo "$fpath is a direstory"
elif [ -e $fpath ]; then
	echo "$fpath is a file"
else
	echo "$fpath is NOT a file or direstory"
fi