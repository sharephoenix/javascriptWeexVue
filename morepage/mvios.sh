#!/bin/bash
# 移动 dist 中的 js 文件到 iOS 的相关目录下

filelist=`ls ./dist`

for file in $filelist
do 
  echo 'ios:::' + $file
  cp ./dist/$file ./platforms/ios/bundlejs
done

exit 1