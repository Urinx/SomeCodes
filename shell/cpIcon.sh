#!/bin/bash

# readPlist [plist] [key]
function readPlist() {
	plist=$1
	key=$2

	value=`plutil -p "$plist" | grep $key | awk -F '=>' '{print $2}' | sed -e 's/\"//g'`
	echo $value
}

# copyAppIcon [app] [dir]
function copyAppIcon() {
	apath=$1
	iDir=$2
	appName="${apath##*/}"

	if [ -d "$apath" ]; then
		icon=`readPlist "$apath/Contents/Info.plist" "CFBundleIconFile"`
		if [ "${icon##*.}" != "icns" ]; then
			icon="$icon".icns
		fi

		cp "$apath/Contents/Resources/$icon" "$iDir/$appName.icns"
	fi
}

iconDir="icons"
mkdir $iconDir
mkdir $iconDir/Applications
mkdir $iconDir/Utilities

for app in /Applications/*
do
	if [ "$app" != "/Applications/Utilities" ]; then
		copyAppIcon "$app" $iconDir/Applications
	fi
done

for app in /Applications/Utilities/*
do
	copyAppIcon "$app" $iconDir/Utilities
done

echo "[*] copy icons done"
zip -rq icons.zip $iconDir/*
echo "[*] compresses the folder done"
rm -r $iconDir
echo "[*] del icons folder done"