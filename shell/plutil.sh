#!/bin/bash
# 获取App图标文件名

# readPlist [plist] [key]
function readPlist() {
	plist=$1
	key=$2

	value=`plutil -p "$plist" | grep $key | awk -F '=>' '{print $2}' | sed -e 's/\"//g'`
	echo $value
}

for i in /Applications/*
do
	if [ "$i" != "/Applications/Utilities" ]; then
		app="${i##*/}"
		icon=`readPlist "$i/Contents/Info.plist" "CFBundleIconFile"`
		if [ "${icon##*.}" != "icns" ]; then
			icon="$icon".icns
		fi
		echo "$app $icon"
	fi
done