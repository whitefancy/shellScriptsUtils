# Shell 语言
# shell本身是一个以C语言编写的程序，是用户和操作系统内核之间通信的桥梁。shell既是一种命令解释程序，又是一种功能强大的解释型程序设计语言。shell解释用户输入的命令，提交到内核处理，最后返回结果给用户。

# 1. shell命令语法分析
command[option] - [arguments]

# 2. shell的通配符
# bash中常用的通配符有 * ? []
# *： 匹配任意一个或多个字符
# ?： 匹配任意单一字符
# []：　 匹配任何包含在方括号内的单字符
ls / dev / sda[12345]
# /dev/sda1 /dev/sda2 /dev/sda3 /dev/sda4 /dev/sda5

# 3. shell的重定向
# 3.1 输入重定向
# 输入重定向用于改变命令的输入源，可以把一个文件的内容作为命令的输入
# 输入重定向操作符有 < 和 <<
# // 利用wc统计输入文件的行数、单词数、字符数wc</etc/shadow
# 41 41 1275
# << 是告诉shell当前命令的标准输入是来自命令行中一对分隔号之间的内容
# 把一对分隔号aa之间的内容作为wc命令的输入，分隔号可以是任意字符
# ALW-VM# wc<< aa
# heredoc> 1.Test1
# heredoc> 2.Test2
# heredoc> 3.Test3
# heredoc> aa
# 3.2 输出重定向
# 输出重定向是指把命令的输出结果保存在一个指定文件中（常用）
# 输出重定向操作符： > 和 >>
# ALW-VM% ps -ef >ps.txt
# ALW-VM% ls
# a ps.txt testgfile1
# ALW-VM% vim ps.txt
# > 与 >>的区别：
# 如果 > 后面指定的文件不存在，则会自动创建；如果存在，则覆盖
# >> 操作符不会覆盖原文件，会把新的信息追加到原文件
# 3.3 错误重定向
# 错误重定向操作符： 2> 和 2>>

# 4. shell的管道
# 管道可以把很多命令连接起来，可以把第一个命令的输出当作第二个命令的输入，以此类推
# 管道符： |
# ALW-VM% ps -ef | grep httpd
# juntaran 38489 38426 0 20:19 pts/3 00:00:00 grep httpd
# ALW-VM% ps -ef | grep httpd | wc -l1

# 5. shell的引用
# bash中有很多特殊字符，本身就具有特殊含义。如果shell的参数中使用它们就会出现问题。
# 引用技术来忽略这些自负的特殊含义，通知shell把这些特殊字符当作普通字符处理
# 转义字符 \ 单引号 ' ' 双引号 ""
# 5.1 转义字符 \
# 把 \ 放到特殊字符前面，shell就忽略这些特殊字符的特殊含义
# 5.2 单引号 ' '
# 把字符串放到一对单引号之间，那么字符串中所有特殊字符的特殊含义均忽略
# 5.3 双引号
# 双引号与单引号基本相同，但是有些特殊字符用双引号括起来也会发挥作用
# 比如 $ \ 和 `
# ALW-VM% echo The date is `date`
# The date is 2016年 11月 07日 星期一 20:25:46 CST
# ALW-VM% echo 'The date is `date`'
# The date is `date`
# ALW-VM% echo "The date is `date`"
# The date is 2016年 11月 07日 星期一 20:26:23 CST

#shell中将命令结果赋值给变量
#两种方法，推荐使用后者，支持嵌套，下面两个参考链接写得很清楚了
var=`command`
var=$(command)
