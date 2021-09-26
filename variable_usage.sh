# 变量分类
#环境变量: 环境变量由父进程传给子进程, 指当前系统的env环境变量
#本地变量: 在脚本内定义的变量我们统称为本地变量,如
sea=$(ls -a)
oscean="hello world"
echo sea # sea
echo $sea # file lists
echo $oscean # hello world
#变量使用:
#    变量名定义  变量名=变量值 (等号两边不能有空格) 如
sea="hello world!"
#     $变量名: 取变量的值 如
sea="hello world!"
echo $sea
#输出结果hello world!
#     删除已定义的变量: unset 变量名  如
unset sea

#内置变量
$? #上一次命令执行结果
$$ #当前进程pid
$0 #当前脚本文件名
$[1-n] #脚本参数
$@ #所有参加列表
$* #同上
$# #参数的个数

echo $? $$ $0 $# # 0 23577 /Users/jedigame/github/shellScriptsUtils/1.sh 0

#字符统配符
#命令展开
`命令` #展开命令  如
sea=`ls`  # 此时sea保存的是当前目录下所有的文件列表
#
$(命令) #如上

