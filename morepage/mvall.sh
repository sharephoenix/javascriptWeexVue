#!/bin/bash
#执行脚本，将打包文件分别放进 android ios 两个平台中
# https://blog.csdn.net/simple_the_best/article/details/76285429

#npm run-script build

# fork 的执行方式
echo "before exec/source/fork: PID for sh = $$"
./mvios.sh
./mvandroid.sh



# source 的执行方式
# ./mvios.sh --source
# ./mvandroid.sh --source

# exec 的执行方式
# ./mvios.sh --exec
# ./mvandroid.sh --exec

echo "after exec/source/fork: PID for sh = $$"
echo '执行完毕！！！'