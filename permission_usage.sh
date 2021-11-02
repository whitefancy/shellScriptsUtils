#!/bin/zsh #指定命令解释器
#执行shell脚本方法
#给该脚本回执行权限 如:
chmod  a+x 1.sh
#然后直接可执行
#通过    执行
. 1.sh
#通过  执行
source 1.sh
#通过指定sh执行  如:   或
/bin/bash 1.sh
/bin/bin 1.sh

chmod -R a+r *
#此外chmod也可以用数字来表示权限如 :

chmod 777 file
#语法为：
chmod abc file

要递归操作给定目录下的所有文件和目录，请使用chmod带有-R, ( --recursive) 选项的命令。递归更改文件权限的一般语法如下：
chmod -R MODE DIRECTORY

chmod -R 755 /var/www/html