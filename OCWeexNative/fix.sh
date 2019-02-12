#!/bin/bash

originPath="./"
originPathPlist="${originPath}/OCWeexNative/Info.plist"

targetPath="../awsomeweexui01/platforms/ios"
targetPathPlist="${targetPath}/WeexDemo/WeexDemo-Info.plist"

echo '*********开始解析 plist 文件*********'
ProjectNameOrigin="\$(PRODUCT_NAME)"
ProjectName=$(/usr/libexec/PlistBuddy -c "Print CFBundleName" ${originPathPlist})

if [ "${ProjectName}" == "${ProjectNameOrigin}" ]; then
	ProjectName='OCWeexNative'
else 
	echo '工程名不相等'
fi
BundleVersionString=$(/usr/libexec/PlistBuddy -c "Print CFBundleShortVersionString" ./OCWeexNative/Info.plist)
BundleVersion=$(/usr/libexec/PlistBuddy -c "Print CFBundleVersion" ./OCWeexNative/Info.plist)
BundleVersion=`expr $BundleVersion + 1`

/usr/libexec/PlistBuddy -c "Set CFBundleVersion $BundleVersion" ./OCWeexNative/Info.plist
echo '工程名称：' $ProjectName
echo '版本号 String：'$BundleVersionString
echo '版本号：'$BundleVersion

echo '*********修改主要参数*********'

targetWXEntryBundleURL=$(/usr/libexec/PlistBuddy -c "Print WXEntryBundleURL" ${targetPathPlist})
targetWXSocketConnectionURL=$(/usr/libexec/PlistBuddy -c "Print WXSocketConnectionURL" ${targetPathPlist})
echo '目标 BundleURL:' ${targetWXEntryBundleURL}
echo '目标 SocketURL:' ${targetWXSocketConnectionURL}
echo '*********移除和 copy bundlejs 文件*********'
`rm -vrf ${originPath}bundlsejs`
`cp  -rf ${targetPath}/bundlejs ${originPath}`
echo '*********修改源工程的相关参数*********'
/usr/libexec/PlistBuddy -c "Set WXEntryBundleURL $targetWXEntryBundleURL" ./OCWeexNative/Info.plist
if [ $? -eq 0 ]; then
	echo '修改 bundleurl 成功'
else
	echo '修改失败'
fi
# $? 0: 成功 非零 为失败
/usr/libexec/PlistBuddy -c "Set WXSocketConnectionURL $targetWXSocketConnectionURL" ./OCWeexNative/Info.plist
if [ $? -eq 0 ]; then
	echo '修改 socketconnecturl 成功'
else
	echo '修改失败'
fi
echo '*********修改参数完成*********'