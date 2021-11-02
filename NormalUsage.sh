常用案例
判断根分区的使用率超过 80% 则向管理员报警
s举个例子，我想通过脚本判断根分区的使用率是否超过 80%，如果超过 80% 则向管理员报警，请他注意。 脚本就可以这样写：
[root@localhost ~]# df -h
#查看一下服务器的分区状况
文件系统 容量 已用 可用 已用％ %挂载点
/dev/sda3 20G 1.8G 17G 10% /
tmpfs 306M 0 306M 0% /dev/shm
/dev/sda1 194M 26M 158M 15% /boot
/dev/srO 3.5G 3.5G 0100% /mnt/cdrom
[root@localhost ~]# vi sh/if1.sh
#!/bin/bash
#统计根分区的使用率
rate=$(df -h | grep "/dev/sda3" | awk '{print $5}' | cut -d"%"-f1)
#把根分区使用率作为变量值赋予变量rate
if [$rate -ge 80]
  #判断rate的值，如果大于等于80,则执行then程序
then
  echo 'Warning! /dev/sda3 is full!!'
  #打印警告信息。在实际工作中，也可以向管理员发送邮件
fi
其实这个脚本最主要的地方是"rate=$(df-h|grep "/dev/sda3"|awk'{print$5}'|cut-d"%"-f1)"这条命令，我们来分析一下这条命令：先使用"df-h"列出系统中的分区情况；然后使用"grep"命令提取出根分区行；再使用"awk"命令列出第五列，也就是根分区使用率这一列（不过使用率是 10%，不好比较，还要提取出 10 这个数字）；最后使用"cut"命令（cut 命令比 awk 命令简单），以"％"作为分隔符，提取出第一列。
这条命令的执行结果如下：
[root@localhost ~]# df -h | grep "/dev/sda3" |awk'{print $5}'|cut -d"%" -f1 10
提取出根分区的使用率后，判断这个数字是否大于等于 80，如果大于等于 80 则报警。至于报警信息，我们在脚本中直接输出到屏幕上。在实际工作中，因为服务器屏幕并不是 24 小时有人值守的，所以也可以给管理员发送邮件，用于报警。
脚本写好之后，就可以利用我们在前面章节中讲到的系统定时任务，让这个脚本每天或几天执行一次，就可以实现自动检测硬盘剩余空间了。后续的系统管理的脚本，如果需要重复执行，则也需要依赖系统定时任务。
中括号[]的用法
Shell 里面的中括号（包括单中括号与双中括号）可用于一些条件的测试：
[ 和test 是 Shell 的内部命令，而[[是Shell的关键字。
[ 和test 是相等的。
在[[中使用&&和||表示逻辑与和逻辑或。[中使用-a 和-o 表示逻辑与和逻辑或。
[[支持字符串的模式匹配，使用=~操作符时甚至支持shell的正则表达式。字符串比较时可以把右边的作为一个模式，而不仅仅是一个字符串，比如[[ hello == hell? ]]，结果为真。[[ ]] 中匹配字符串或通配符，不需要引号。
使用[[ ... ]]条件判断结构，而不是[ ... ]，能够防止脚本中的许多逻辑错误。比如，&&、||、<和> 操作符能够正常存在于[[ ]]条件判断结构中，
但是如果出现在[ ]结构中的话，会报错。比如可以直接使用if [[ $a != 1 && $a != 2 ]]
如果不使用双括号, 则为if [ $a -ne 1] && [ $a != 2 ]或者if [ $a -ne 1 -a $a != 2 ]
bash把双中括号中的表达式看作一个单独的元素，并返回一个退出状态码。
$[ !(pip list | grep pip) ] && echo True || echo False
-bash: [: too many arguments
False
$[[ !(pip list | grep pip) ]] && echo True || echo False
True
算术比较
, 比如一个变量是否为0, [ $var -eq 0 ]。
对变量或值进行算术条件判断：
[ $var -eq 0 ]  # 当 $var 等于 0 时，返回真
[ $var -ne 0 ]  # 当 $var 不等于 0 时，返回真
1
2
需要注意的是 [ 与 ] 与操作数之间一定要有一个空格，否则会报错。比如下面这样就会报错:
[$var -eq 0 ]  或 [ $var -ne 0]
其他比较操作符：
操作符	意义
-gt	大于
-lt	小于
-ge	大于或等于
-le	小于或等于
可以通过 -a (and) 或 -o (or) 结合多个条件进行测试：
[ $var1 -ne 0 -a $var2 -gt 2 ]  # 使用逻辑与 -a
[ $var1 -ne 0 -o $var2 -gt 2 ]  # 使用逻辑或 –o
文件属性测试
比如一个文件是否存在，[ -e $var ], 是否是目录，[ -d $var ]。
使用不同的条件标志测试不同的文件系统属性。
操作符	意义
[ -f $file_var ]	变量 $file_var 是一个正常的文件路径或文件名 (file)，则返回真
[ -x $var ]	变量 $var 包含的文件可执行 (execute)，则返回真
[ -d $var ]	变量 $var 包含的文件是目录 (directory)，则返回真
[ -e $var ]	变量 $var 包含的文件存在 (exist)，则返回真
[ -c $var ]	变量 $var 包含的文件是一个字符设备文件的路径 (character)，则返回真
[ -b $var ]	变量 $var 包含的文件是一个块设备文件的路径 (block)，则返回真
[ -w $var ]	变量 $var 包含的文件可写(write)，则返回真
[ -r $var ]	变量 $var 包含的文件可读 (read)，则返回真
[ -L $var ]	变量 $var 包含是一个符号链接 (link)，则返回真
fpath="/etc/passwd"
if [ -e $fpath ]; then
  echo File exits;
else
  echo Does not exit;
fi
字符串比较
比如两个字符串是否相同， [[ $var1 = $var2 ]]。
在进行字符串比较时，最好使用双中括号 [[ ]]. 因为单中括号可能会导致一些错误，因此最好避开它们。
检查两个字符串是否相同：
[[ $str1 = $str2 ]]
1
当 str1等于str2 时，返回真。也就是说，str1 和 str2 包含的文本是一样的。其中的单等于号也可以写成双等于号，也就是说，上面的字符串比较等效于 [[ $str1 == $str2 ]].
注意 = 前后有一个空格，如果忘记加空格, 就变成了赋值语句，而非比较关系了。
字符串的其他比较情况：
操作符	意义
[[ $str1 != $str2 ]]	如果 str1 与 str2 不相同，则返回真
[[ -z $str1 ]]	如果 str1 是空字符串，则返回真
[[ -n $str1 ]]	如果 str1 是非空字符串，则返回真
使用逻辑运算符 && 和 || 可以轻松地将多个条件组合起来, 比如：
str1="Not empty"
str2=""
if [[ -n $str1 ]] && [[ -z $str2 ]];
then
  echo str1 is nonempty and str2 is empty string.
Fi
test 命令
test 命令也可以从来执行条件检测，用 test 可以避免使用过多的括号，[] 中的测试条件同样可以通过 test 来完成。
if [ $var -eq 0 ]; then echo "True"; fi
等价于
if test $var -eq 0; then echo "True"; fi
括号的特殊用法
d 1. 符号$后的括号
${a} 变量a的值, 在不引起歧义的情况下可以省略大括号.
$(cmd) 命令替换, 结果为shell命令cmd的输出, 和`cmd`效果相同, 不过某些Shell版本不支持$()形式的命令替换, 如tcsh.
$((exp)) 和`expr exp`效果相同, 计算数学表达式exp的数值, 其中exp只要符合C语言的运算规则即可, 甚至三目运算符和逻辑表达式都可以计算.
2. 多条命令执行
(cmd1;cmd2;cmd3) 新开一个子shell顺序执行命令cmd1,cmd2,cmd3, 各命令之间用分号隔开, 最后一个命令后可以没有分号.
{ cmd1;cmd2;cmd3;} 在当前shell顺序执行命令cmd1,cmd2,cmd3, 各命令之间用分号隔开, 最后一个命令后必须有分号, 第一条命令和左括号之间必须用空格隔开.
对{}和()而言, 括号中的重定向符只影响该条命令, 而括号外的重定向符影响到括号中的所有命令.
3. 双括号的特殊用法
(()) 增强括号的用法, 常用于算术运算比较. 双括号中的变量可以不使用$符号前缀, 只要括号中的表达式符合C语言运算规则, 支持多个表达式用逗号分开.
比如可以直接使用for((i=0;i<5;i++)), 如果不使用双括号, 则为for i in `seq 0 4`或者for i in {0..4}.
再如可以直接使用if (($i<5)), 如果不使用双括号, 则为if [ $i -lt 5 ].
[[]] 增强方括号用法, 常用于字符串的比较. 主要用于条件测试, 双括号中的表达式可以使用&&, ||, <, >等C语言语法.
比如可以直接使用if [[ $a != 1 && $a != 2 ]], 如果不适用双括号, 则为if [ $a -ne 1] && [ $a != 2 ]或者if [ $a -ne 1 -a $a != 2 ].
Shell判断字符串包含关系的几种方法
方法一：利用grep查找
1 strA="long string"
2 strB="string"
3 result=$(echo $strA | grep "${strB}")
4 if [[ "$result" != "" ]]
5 then
6 echo "包含"
7 else
8 echo "不包含"
9 fi
先打印长字符串，然后在长字符串中 grep 查找要搜索的字符串，用变量result记录结果
如果结果不为空，说明strA包含strB。如果结果为空，说明不包含。
这个方法充分利用了grep 的特性，最为简洁。
方法二：利用字符串运算符
strA="helloworld"
strB="low"
if [[ $strA =~ $strB ]]
then
echo "包含"
else
echo "不包含"
fi利用字符串运算符 =~ 直接判断strA是否包含strB。（这不是比第一个方法还要简洁吗摔！）
方法三：利用通配符
A="helloworld"
B="low"
if [[ $A == *$B* ]]
then
echo "包含"
else
echo "不包含"
fi这个也很easy，用通配符*号代理strA中非strB的部分，如果结果相等说明包含，反之不包含。
方法四：利用case in 语句
thisString="1 2 3 4 5" # 源字符串
searchString="1 2" # 搜索字符串
case $thisString in
*"$searchString"*) echo Enemy Spot ;;
*) echo nope ;;
esa这个就比较复杂了，case in 我还没有接触到，不过既然有比较简单的方法何必如此
方法五：利用替换
STRING_A=$1
STRING_B=$2
if [[ ${STRING_A/${STRING_B}//} == $STRING_A ]]
then
## is not substring.
echo N
return 0
else
## is substring.
echo Y
return 1
fi
字符串分割
方法一: 借助于{str//,/}来处理
[root@host ~]# str="ONE,TWO,THREE,FOUR"
[root@host ~]# arr=(${str//,/})
[root@host ~]# echo ${arr[@]}
ONE TWO THREE FOUR
方法二: 借助于tr命令来处理
[root@host ~]# str="ONE,TWO,THREE,FOUR"
[root@host ~]# arr=(`echo $str | tr ',' ' '`)
[root@host ~]# echo ${arr[@]}
ONE TWO THREE FOUR
方法三: 借助于awk命令来处理
[root@host ~]# str="ONE,TWO,THREE,FOUR"
[root@host ~]# arr=($(echo $str | awk 'BEGIN{FS=",";OFS=" "} {print $1,$2,$3,$4}'))
[root@host ~]# echo ${str[*]}
方法四: 借助于IFS来处理分隔符
[root@host ~]# str="ONE,TWO,THREE,FOUR"
[root@host ~]# IFS=","
[root@host ~]# arr=(str)
[root@host ~]# echo ${str[@]}
Bash脚本代码：
#!/bin/bash
#Example for bash split string by Symbol (comma)
read -p "Enter Name, City and Age separated by a comma: " entry #reading string value
IFS=',' #setting comma as delimiter
read -a strarr <<<"$entry" #reading str as an array as tokens separated by IFS
echo "Name : ${strarr[0]} "
echo "City : ${strarr[1]} "
echo "Age : ${strarr[2]}"
shell中脚本参数传递
方式一：$0,$1,$2..
采用$0,$1,$2..等方式获取脚本命令行传入的参数，值得注意的是，$0获取到的是脚本路径以及脚本名，后面按顺序获取参数，当参数超过10个时(包括10个)，需要使用${10},${11}....才能获取到参数，但是一般很少会超过10个参数的情况。
1.1 示例：新建一个test.sh的文件
#!/bin/bash
echo "脚本$0"
echo "第一个参数$1"
echo "第二个参数$2"
在shell中执行脚本，结果如下
$ ./test.sh 1 2
#shell中将会输出：
脚本./test.sh
第一个参数1
第二个参数2
优点：获取参数更容易，执行脚本时需要的输入少
缺点：必须按照顺序输入参数，如果中间漏写则参数对应就会错误
方式二：getopts
语法格式：getopts [option[:]] [DESCPRITION] VARIABLE
option：表示为某个脚本可以使用的选项
":"：如果某个选项（option）后面出现了冒号（":"），则表示这个选项后面可以接参数（即一段描述信息DESCPRITION）
VARIABLE：表示将某个选项保存在变量VARIABLE中
2.1 示例：同样新建一个test.sh文件
while getopts ":a:b:c:" opt
do
case $opt in
a)
echo "参数a的值$OPTARG"
;;
b)
echo "参数b的值$OPTARG"
;;
c)
echo "参数c的值$OPTARG"
;;
?)
echo "未知参数"
exit 1;;
esac
done
用一个while循环加case分支获取不同参数，:a:b:c相当于定义参数的变量名，有时候可能会有未知参数，所以增加一个?的分支。
$ ./test.sh -a 1 -c 3 -d 4
#在shell中的输出
参数a的值1
参数c的值3
未知参数
优点：由于使用了-a加参数值的方式进行一一匹配，所以不会参数匹配错误，同时也可以缺省参数，并不会导致参数错误，同时也便于后期参数的扩展和移植
缺点：脚本执行时参数需要的输入会增多
Linux getopts命令用于获取命令行中的参数
调用格式：
getopts option_string variable
1
参数说明：
option_string 选项名称
variable 选项的值
选项之间使用冒号:分隔，也可以直接连接， : 表示选项后面有传值。
当getopts命令发现冒号后，会从命令行该选项后读取该值。如该值存在，将保存在特殊的变量OPTARG中。
当option_string用:开头，getopts会区分invalid option错误和miss option argument错误。
invalid option时, varname会被设成?
miss option argument时，varname会被设成:
如果option_string不用:开头，invalid option错误和miss option argument错误都会使varname被设成?。
getopts包含两个内置变量，OPTARG和OPTIND
OPTARG 保存选项后的参数值
OPTIND 表示命令行下一个选项或参数的索引
例子1，使用getopts命令获取参数
#!/bin/bash
while getopts a:b:c:d opts; do
case $opts in
a) a=$OPTARG ;;
b) b=$OPTARG ;;
c) c=$OPTARG ;;
d) d=$OPTARG ;;
?) ;;
esac
done
echo "a=$a"
echo "b=$b"
echo "c=$c"
echo "d=$d"
exit 0
执行输出
./test.sh -a 1 -b 2 -c 3 -d 4
a=1
b=2
c=3
d=
option_string a:b:c:d
a,b,c后都有:，d后没有:
所以可以获取到a,b,c的值
例子2，option_string前加:
上例中，如果a,b,c任意一个没有传值，将会提示出错。例如 -c 不传值。
./test.sh -a 1 -b 2 -c
./test.sh: option requires an argument -- c
a=1
b=2
c=
d=
我们在option_string前加上:，则可以屏蔽这个错误。
#!/bin/bash
while getopts :a:b:c:d opts; do
case $opts in
a) a=$OPTARG ;;
b) b=$OPTARG ;;
c) c=$OPTARG ;;
d) d=$OPTARG ;;
?) ;;
esac
done
echo "a=$a"
echo "b=$b"
echo "c=$c"
echo "d=$d"
exit 0
执行输出
./test.sh -a 1 -b 2 -c
a=1
b=2
c=
d=
在option_string前加上:，可以屏蔽缺失传值的错误，但如果缺失的是前面选项的值，那么获取到的值将会错误。
例如缺失a的传值，命令会把-a后的-b作为了-a的值，导致错误。
./test.sh -a -b 2 -c 3
a=-b
b=
c=
d=
因此使用getopts命令时，对于没有传值的选项，选项名称也不要加入命令行中。
例如a不传值，则-a不要加入命令行。
./test.sh -b 2 -c 3
a=
b=2
c=3
d=
总结：推荐使用getopts的方式进行参数传递
shell函数【参数传递及输入输出】
function copyfile()
{
local srcfile=$1
local dstfile=$2
cp $srcfile $dstfile
return 0 # always return success
}
copyfile /tmp/myconf /etc/sysconf
调用
function_name params
可以通过return命令让函数返回数字值，或者echo一个字符串返回
参数传递：
参数使用与位置参数一样
$1, $2, ……
$@, $*
$#
func $var1 $var2
注：变量中间用空格、Tab分割
return:主要用来返回退出状态,即$?
0 <= 返回值（整数） <= 255；
0 为无错误；
非0 为有错误；
注：如果返回其他数据，可以使用echo或者全局变量
return_var=`func $var1 $var2`
常用场景示例
shell遍历某个目录下级的所有文件名
#!/bin/bash
for file in `ls /bin`; do
echo ${file}
done
shell bash判断文件或文件夹是否存在
#如果文件夹不存在，创建文件夹
if [ ! -d "/myfolder" ]; then
mkdir /myfolder
fi
#shell判断文件,目录是否存在或者具有权限
folder="/var/www/"
file="/var/www/log"
# -x 参数判断 $folder 是否存在并且是否具有可执行权限
if [ ! -x "$folder"]; then
mkdir "$folder"
fi
# -d 参数判断 $folder 是否存在
if [ ! -d "$folder"]; then
mkdir "$folder"
fi
# -f 参数判断 $file 是否存在
if [ ! -f "$file" ]; then
touch "$file"
fi
# -n 判断一个变量是否有值
if [ ! -n "$var" ]; then
echo "$var is empty"
exit 0
fi
# 判断两个变量是否相等
if [ "$var1" = "$var2" ]; then
echo '$var1 eq $var2'
else
echo '$var1 not eq $var2'
fi
linux--shell--判断参数为文件还是目录
file=$1
if [ -f $file ]
then
echo "普通"
elif [ -d $file ]
then
echo "目录"
else
echo "其他"
fi
shell 按行读取并保存成数组
从ip.txt里读取IP.然后把IP地址赋值到一个数组里.
IP文件如下：
Address: 220.181.26.163
Address: 220.181.26.174
Address: 220.181.26.175
Address: 220.181.26.176
Address: 220.181.19.228
Address: 220.181.19.229
Address: 220.181.26.161
Address: 220.181.26.162
Shell代码
方法一：
for x in ` awk '{print $2}' ip.txt `
{
echo $x
}
方法二：
ARRAY=($(awk '{print $2}' ip.txt))
方法三：
n=0;while read a b;do array[$n]=$b;((n++));done<ip.txt
方法四：
n=1
while ((n<=$(cat ip.txt|wc -l)))
do
ipaddr[$n]=$(cat ip.txt|sed -n "${n}p"|awk '{print $2}')
((n+=1))
done
n=`expr $n1`
在shell中把ls的输出存进一个数组变量
c=0
for file in `ls`
do
filelist[$c]=$file
((c++))
done
或者
set -a myfiles
index=0
for f in ` ls `; do myfiles[index]=$f; let index=index+1; done
注：用这种方法，如果文件名中有空格的话，会将一个文件名以空格为分隔符分成多个存到数组中，最后出来的结果就是错误的。
以下代码，这种赋值方法可以使获取到的文件名正确。
c=0
for file in *
do
filelist[$c]="$file" （为了准确起见，此处要加上双引号“”）
((c++))
done