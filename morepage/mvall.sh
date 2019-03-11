#!/bin/bash
#执行脚本，将打包文件分别放进 android ios 两个平台中
# https://blog.csdn.net/simple_the_best/article/details/76285429

# ./mvios.sh
# ./mvandroid.sh

# ./mvios.sh --source
# ./mvandroid.sh --source

./mvios.sh --exec
./mvandroid.sh --exec

echo '执行完毕！！！'