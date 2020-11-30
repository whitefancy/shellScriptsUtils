#!/bin/zsh #指定命令解释器
cd .. #切换到上一级目录
ls #显示当前目录下所有文件

sea=$(ls -a)
oscean="hello world"
echo sea # sea
echo $sea # file lists
echo $oscean # hello world
echo $? $$ $0 $# # 0 23577 /Users/jedigame/github/shellScriptsUtils/1.sh 0
#执行shell脚本方法
#
#给该脚本回执行权限 如: chmod  a+x 1.sh    然后直接可执行
#
#通过  . 1.sh  执行
#
#通过 source 1.sh 执行
#
#通过指定sh执行  如: /bin/bash 1.sh   或 /bin/bin 1.sh