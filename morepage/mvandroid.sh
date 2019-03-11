#!/bin/bash
# 移动 dist 中的 js 文件到 Android 的相关目录下

filelist=`ls ./dist`
for file in $filelist
do
  echo 'android:::' + $file
  cp ./dist/$file ./platforms/android/app/src/main/assets/dist
done

exit 1