#!/bin/bash

# 设置给定文件或文件夹的图标
# mac only
# need xcode develop tools

# Set the icon of file or direstory
# params:
# set_icon [filepath] [iconfile]
function set_icon() {
	fpath=$1
	ipath=$2
	xcode_devtools="/Applications/Xcode.app/Contents/Developer/Tools/"

	if [ -d $xcode_devtools ]; then
		if [ -d $fpath ]; then
			# $fpath is a direstory
			touch $fpath/Icon$'\r'
			cp $ipath tempIcon.icns
			sips -i tempIcon.icns > /dev/null 2>&1
			derez -only icns tempIcon.icns > tempicns.rsrc
			rez -a tempicns.rsrc -o $fpath/Icon$'\r'
			setfile -a C $fpath
			rm tempIcon.icns
			rm tempicns.rsrc
			# hide Icon$'\r' file inside folder
			setfile -a V $fpath/Icon$'\r'
		elif [ -e $fpath ]; then
			# $fpath is a file
			cp $ipath tempIcon.icns
			sips -i tempIcon.icns > /dev/null 2>&1
			derez -only icns tempIcon.icns > tempicns.rsrc
			rez -a tempicns.rsrc -o $fpath
			setfile -a C $fpath
			rm tempIcon.icns
			rm tempicns.rsrc
		else
			echo "$fpath is NOT a file or direstory"
			exit 1
		fi
	else
		echo "[*] Error: this need Xcode Developer/Tools. Please install it first!"
		exit 1
	fi
}

echo "[*] Set the icon of $1"
set_icon $1 $2
echo "[*] done"