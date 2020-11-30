#!/bin/zsh #指定命令解释器
cd .. #切换到上一级目录
ls #显示当前目录下所有文件

sea=$(ls -a)
oscean="hello world22s"
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

# 变量分类
#
#环境变量: 环境变量由父进程传给子进程, 指当前系统的env环境变量
#
#本地变量: 在脚本内定义的变量我们统称为本地变量,如 sea="hello wolrd!"
#
#
#
#
#内置变量
#
#$? 上一次命令执行结果
#
#$$ 当前进程pid
#
#$0 当前脚本文件名
#
#$[1-n] 脚本参数
#
#$@ 所有参加列表
#
#$* 同上
#
#$# 参数的个数
#
#变量:
#
#字符统配符
#
#
#
#
#
#
#
#
#
#命令展开
#
#`命令` 展开命令  如  sea=`ls`  此时sea保存的是当前目录下所有的文件列表
#
#$(命令)如上