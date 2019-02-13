#!/bin/bash
# weex run ios
# 移动相应文件, 并修改相关配置

weexPath="./platforms/ios"
weexPlist="${weexPath}/WeexDemo/WeexDemo-Info.plist"
targetWXEntryBundleURL=$(/usr/libexec/PlistBuddy -c "Print WXEntryBundleURL" ${weexPlist})
targetWXSocketConnectionURL=$(/usr/libexec/PlistBuddy -c "Print WXSocketConnectionURL" ${weexPlist})
echo $targetWXEntryBundleURL
echo $targetWXSocketConnectionURL

fixPath="../OCWeexNative/"
fixPlist="${fixPath}/OCWeexNative/Info.plist"
$(/usr/libexec/PlistBuddy -c "Set WXEntryBundleURL $targetWXEntryBundleURL" ${fixPlist})
if [ $? -eq 0 ]; then
	echo '修改 WXEntryBundleURL 成功'
fi
$(/usr/libexec/PlistBuddy -c "Set WXSocketConnectionURL $targetWXSocketConnectionURL" ${fixPlist})
if [ $? -eq 0 ]; then
	echo '修改 WXSocketConnectionURL 成功'
fi