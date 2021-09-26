the_world_is_flat=true
if $the_world_is_flat; then
echo 'Be careful not to fall off!'
fi
if [ "$score" -ge "0" ]&&[ "$score" -lt "60" ];then
echo "sorry,you are lost!"
elif [ "$score" -ge "60" ]&&[ "$score" -lt "85" ];then
echo "just soso!"
elif [ "$score" -le "100" ]&&[ "$score" -ge "85" ];then
echo "good job!"
else
echo "input score is wrong , the range is [0-100]!"
fi
for((integer = 1; integer <= 5; integer++))
do
echo "$integer"
done
#在命令行可以一次执行多个命令
#在命令行可以一次执行多个命令，有以下几种：
#1.每个命令之间用;隔开
#说明：各命令的执行结果，不会影响其它命令的执行。换句话说，各个命令都会执行，
#但不保证每个命令都执行成功。
cd /home/PyTest/src; python suning.py
#2.每个命令之间用&&隔开
#说明：若前面的命令执行成功，才会去执行后面的命令。这样可以保证所有的命令执行完毕后，执行过程都是成功的。
cd /home/PyTest/src&&python suning.py
#3.每个命令之间用||
#说明：||是或的意思，只有前面的命令执行失败后才去执行下一条命令，直到执行成功一条命令为止。
#管道 每个命令之间用|隔开
#管道可以将一个命令的输出导向另一个命令的输入，从而让两个(或者更多命令)像流水线一样连续工作，不断地处理文本流。在命令行中，我们用|表示管道
cd /home/PyTest/123 || echo "error234"
cd /home/PyTest/123 | echo "error234"
#循环
#While循环
#shell:读取文件的每一行内容并输出
#写法一：
while read line
do
echo $line
done < file #(待读取的文件)
#写法二：
cat file(待读取的文件) | while read line
do
echo $line
done
#for循环
#写法三：
for line in `cat file(待读取的文件)`
do
echo $line
done
#说明：
#for逐行读和while逐行读是有区别的,如:
$ cat file
aaaa
bbbb
cccc dddd
$ cat file | while read line; do echo $line; done
aaaa
bbbb
cccc dddd
$ for line in $(<file); do echo $line; done
aaaa
bbbb
cccc
dddd
#数组循环
#首先创建一个数组
array=( A B C D 1 2 3 4)
###1.标准的for循环
for(( i=0;i<${#array[@]};i++)) do
#${#array[@]}获取数组长度用于循环
echo ${array[i]};
done;
###2.for … in
#遍历（不带数组下标）：
for element in ${array[@]}
#也可以写成for element in ${array[*]}
do
echo $element
done
#遍历（带数组下标）：
for i in "${!arr[@]}";
do
printf "%s\t%s
" "$i" "${arr[$i]}"
done
###3.While循环法：
i=0
while [ $i -lt ${#array[@]} ]
#当变量（下标）小于数组长度时进入循环体
do
echo ${ array[$i] }
#按下标打印数组元素
let i++
done

#if条件判断的 用法
#s 1、基本语法:
#if [ command ]; then
#   符合该条件执行的语句
#fi
#2、扩展语法：
#if [ command ];then
#   符合该条件执行的语句
#elif [ command ];then
#   符合该条件执行的语句
#else
#   符合该条件执行的语句
#fi

#3、语法说明：
#bash shell会按顺序执行if语句，如果command执行后且它的返回状态是0，则会执行符合该条件执行的语句，否则后面的命令不执行，跳到下一条命令。
#当有多个嵌套时，只有第一个返回0退出状态的命令会导致符合该条件执行的语句部分被执行,如果所有的语句的执行状态都不为0，则执行else中语句。
#返回状态：最后一个命令的退出状态，或者当没有条件是真的话为0。
#注意：
#1、[  ]表示条件测试。注意这里的空格很重要。要注意在'['后面和']'前面都必须要有空格
#2、在shell中，then和fi是分开的语句。如果要在同一行里面输入，则需要用分号将他们隔开。
#3、注意if判断中对于变量的处理，需要加引号，以免一些不必要的错误。没有加双引号会在一些含空格等的字符串变量判断的时候产生错误。比如[ -n "$var" ]如果var为空会出错
#4、判断是不支持浮点值的
#5、如果只单独使用>或者<号，系统会认为是输出或者输入重定向，虽然结果显示正确，但是其实是错误的，因此要对这些符号进行转意
#6、在默认中，运行if语句中的命令所产生的错误信息仍然出现在脚本的输出结果中
#7、使用-z或者-n来检查长度的时候，没有定义的变量也为0
#8、空变量和没有初始化的变量可能会对shell脚本测试产生灾难性的影响，因此在不确定变量的内容的时候，在测试号前使用-n或者-z测试一下
#9、? 变量包含了之前执行命令的退出状态（最近完成的前台进程）（可以用于检测退出状态）

#常用参数：
#文件/目录判断：
#[ -a FILE ] 如果 FILE 存在则为真。
#[ -b FILE ] 如果 FILE 存在且是一个块文件则返回为真。
#[ -c FILE ] 如果 FILE 存在且是一个字符文件则返回为真。
#[ -d FILE ] 如果 FILE 存在且是一个目录则返回为真。
#[ -e FILE ] 如果 指定的文件或目录存在时返回为真。
#[ -f FILE ] 如果 FILE 存在且是一个普通文件则返回为真。
#[ -g FILE ] 如果 FILE 存在且设置了SGID则返回为真。
#[ -h FILE ] 如果 FILE 存在且是一个符号符号链接文件则返回为真。（该选项在一些老系统上无效）
#[ -k FILE ] 如果 FILE 存在且已经设置了冒险位则返回为真。
#[ -p FILE ] 如果 FILE 存并且是命令管道时返回为真。
#[ -r FILE ] 如果 FILE 存在且是可读的则返回为真。
#[ -s FILE ] 如果 FILE 存在且大小非0时为真则返回为真。
#[ -u FILE ] 如果 FILE 存在且设置了SUID位时返回为真。
#[ -w FILE ] 如果 FILE 存在且是可写的则返回为真。（一个目录为了它的内容被访问必然是可执行的）
#[ -x FILE ] 如果 FILE 存在且是可执行的则返回为真。
#[ -O FILE ] 如果 FILE 存在且属有效用户ID则返回为真。
#[ -G FILE ] 如果 FILE 存在且默认组为当前组则返回为真。（只检查系统默认组）
#[ -L FILE ] 如果 FILE 存在且是一个符号连接则返回为真。
#[ -N FILE ] 如果 FILE 存在 and has been mod如果ied since it was last read则返回为真。
#[ -S FILE ] 如果 FILE 存在且是一个套接字则返回为真。
#[ FILE1 -nt FILE2 ] 如果 FILE1 比 FILE2 新, 或者 FILE1 存在但是 FILE2 不存在则返回为真。
#[ FILE1 -ot FILE2 ] 如果 FILE1 比 FILE2 老, 或者 FILE2 存在但是 FILE1 不存在则返回为真。
#[ FILE1 -ef FILE2 ] 如果 FILE1 和 FILE2 指向相同的设备和节点号则返回为真。
#字符串判断
#[ -z STRING ]    如果STRING的长度为零则返回为真，即空是真
#[ -n STRING ]    如果STRING的长度非零则返回为真，即非空是真
#[ STRING1 ]    如果字符串不为空则返回为真,与-n类似
#[ STRING1 == STRING2 ]   如果两个字符串相同则返回为真
#[ STRING1 != STRING2 ]    如果字符串不相同则返回为真
#[ STRING1 < STRING2 ]     如果 “STRING1”字典排序在“STRING2”前面则返回为真。
#[ STRING1 > STRING2 ]     如果 “STRING1”字典排序在“STRING2”后面则返回为真。
#数值判断
#[ INT1 -eq INT2 ]          INT1和INT2两数相等返回为真 ,=
#[ INT1 -ne INT2 ]          INT1和INT2两数不等返回为真 ,<>
#[ INT1 -gt INT2 ]           INT1大于INT2返回为真 ,>
#[ INT1 -ge INT2 ]          INT1大于等于INT2返回为真,>=
#[ INT1 -lt INT2 ]            INT1小于INT2返回为真 ,<
#[ INT1 -le INT2 ]           INT1小于等于INT2返回为真,<=
#逻辑判断
#[ ! EXPR ]       逻辑非，如果 EXPR 是false则返回为真。
#[ EXPR1 -a EXPR2 ]      逻辑与，如果 EXPR1 and EXPR2 全真则返回为真。
#[ EXPR1 -o EXPR2 ]      逻辑或，如果 EXPR1 或者 EXPR2 为真则返回为真。
#[  ] || [  ]           用OR来合并两个条件
#[  ] && [  ]        用AND来合并两个条件
#其他判断
#[ -t FD ]  如果文件描述符 FD （默认值为1）打开且指向一个终端则返回为真
#[ -o optionname ]  如果shell选项optionname开启则返回为真
#算术:
#
#数算判断符
#
#-eq  等于
#
#-ne 不等于
#
#-gt 大于
#
#-ge 大于或等于
#
#-lt 小于
#
#-le 小于或等于
#
#送件判断符
#
#-d 判断文件是否是目录
#
#-f 判断文件是否是普通文件
#
#-p 判断文件是否是管道文件
#
#-r 判断文件是否有读权限
#
#-w 判断文件是否有写权限
#
#-x 判断文件是否有执行权限
#
#-z 如果文件长度为0, 则返回0(真)
#
#-n 如果文件长度为非0, 则返回0(真)
#
#-a 与  如[ -p pipe -a $var2 = "sadsa" ] pipe是管道并且字符串相等
#
#-o 或  如[ -p pipe -a $var2 = "sadsa" ] pipe是管道或者字符串相等
#
#\ 用于去除后面的单个字符的特殊意义(回车除外)

#IF高级特性：
#双圆括号((  ))：表示数学表达式
#    在判断命令中只允许在比较中进行简单的算术操作，而双圆括号提供更多的数学符号，而且在双圆括号里面的'>','<'号不需要转意。
#双方括号[[  ]]：表示高级字符串处理函数
#    双方括号中判断命令使用标准的字符串比较，还可以使用匹配模式，从而定义与字符串相匹配的正则表达式。
#双括号的作用：
#在shell中，[ $a != 1 || $b = 2 ]是不允许出，要用[ $a != 1 ] || [ $b = 2 ]，而双括号就可以解决这个问题的，[[ $a != 1 || $b = 2 ]]。又比如这个[ "$a" -lt "$b" ]，也可以改成双括号的形式(("$a" < "$b"))
#实例
#1：判断目录$doiido是否存在，若不存在，则新建一个
if [ ! -d "$doiido"]; then
    mkdir "$doiido"
fi
#2：判断普通文件$doiido是否存，若不存在，则新建一个
if [ ! -f "$doiido" ]; then
  touch "$doiido"
fi
#3：判断$doiido是否存在并且是否具有可执行权限
if [ ! -x "$doiido"]; then
  mkdir "$doiido"
    chmod +x "$doiido"
fi
#4：是判断变量$doiido是否有值
if [ ! -n "$doiido" ]; then
  echo "$doiido is empty"
  exit 0
fi
#5：两个变量判断是否相等
if [ "$var1" = "$var2" ]; then
  echo '$var1 eq $var2'
else
  echo '$var1 not eq $var2'
fi
#6：测试退出状态：
if [ $? -eq 0 ];then
    echo 'That is ok'
fi
#7：数值的比较：
if [ "$num" -gt "150" ]
    echo "$num is biger than 150"
fi
#8：a>b且a<c
(( a > b )) && (( a < c ))
[[ $a > $b ]] && [[ $a < $c ]]
[ $a -gt $b -a $a -lt $c ]
#9：a>b或a<c
(( a > b )) || (( a < c ))
[[ $a > $b ]] || [[ $a < $c ]]
[ $a -gt $b -o $a -lt $c ]
#10：检测执行脚本的用户
if [ "$(whoami)" != 'root' ]; then
    echo "You have no permission to run $0 as non-root user."
    exit 1;
fi
#上面的语句也可以使用以下的精简语句
[ "$(whoami)" != 'root' ] && ( echo "You have no permission to run $0 as non-root user."; exit 1 )
#11：正则表达式
doiido="hero"
if [[ "$doiido" == h* ]];then
    echo "hello，hero"
fi
#s if 语句通过关系运算符判断表达式的真假来决定执行哪个分支。Shell 有三种 if ... else 语句：
if ... fi 语句；
if ... else ... fi 语句；
if ... elif ... else ... fi 语句。
#1) if ... else 语句
#if ... else 语句的语法：
if [ expression ]
then
   Statement(s) to be executed if expression is true
fi
#如果 expression 返回 true，then 后边的语句将会被执行；如果返回 false，不会执行任何语句。
#最后必须以 fi 来结尾闭合 if，fi 就是 if 倒过来拼写，后面也会遇见。
#注意：expression 和方括号([ ])之间必须有空格，否则会有语法错误。
#举个例子：
#!/bin/sh
a=10
b=20
if [ $a == $b ]
then
   echo "a is equal to b"
fi
if [ $a != $b ]
then
   echo "a is not equal to b"
fi
#运行结果：
a is not equal to b
2) if ... else ... fi 语句
#if ... else ... fi 语句的语法：
if [ expression ]
then
   Statement(s) to be executed if expression is true
else
   Statement(s) to be executed if expression is not true
fi
#如果 expression 返回 true，那么 then 后边的语句将会被执行；否则，执行 else 后边的语句。

a=10
b=20
if [ $a == $b ]
then
   echo "a is equal to b"
else
   echo "a is not equal to b"
fi
#执行结果：
a is not equal to b
3) if ... elif ... fi 语句
if ... elif ... fi 语句可以对多个条件进行判断，语法为：
if [ expression 1 ]
then
   Statement(s) to be executed if expression 1 is true
elif [ expression 2 ]
then
   Statement(s) to be executed if expression 2 is true
elif [ expression 3 ]
then
   Statement(s) to be executed if expression 3 is true
else
   Statement(s) to be executed if no expression is true
fi
#哪一个 expression 的值为 true，就执行哪个 expression 后面的语句；如果都为 false，那么不执行任何语句。
a=10
b=20
if [ $a == $b ]
then
   echo "a is equal to b"
elif [ $a -gt $b ]
then
   echo "a is greater than b"
elif [ $a -lt $b ]
then
   echo "a is less than b"
else
   echo "None of the condition met"
fi
#运行结果：
a is less than b
if ... else 语句也可以写成一行，以命令的方式来运行，像这样：
if test $[2*3] -eq $[1+5]; then echo 'The two numbers are equal!'; fi;
if ... else 语句也经常与 test 命令结合使用，如下所示：
num1=$[2*3]
num2=$[1+5]
if test $[num1] -eq $[num2]
then
    echo 'The two numbers are equal!'
else
    echo 'The two numbers are not equal!'
fi
#输出：
The two numbers are equal!
#test 命令用于检查某个条件是否成立，与方括号([ ])类似。
#中括号 [ ]
#bash 的内部命令，[ 和 test 是等同的。if/test 结构中的左中括号是调用 test 的命令标识，右中括号是关闭条件判断的。这个命令把它的参数作为比较表达式或者作为文件测试，并且根据比较的结果来返回一个退出状态码。
#Test 和 [ ] 中可用的比较运算符只有 == 和 !=，两者都是用于字符串比较的，不可用于整数比较，整数比较只能使用 -eq，-gt 这种形式。无论是字符串比较还是整数比较都不支持大于号小于号。如果实在想用，对于字符串比较可以使用转义形式，如果比较 "ab" 和 "bc"[ ab \< bc ]，结果为真，也就是返回状态为0。
#[ ] 中的逻辑与和逻辑或使用 -a 和 -o 表示。
#双中括号 [[ ]]
#[[ 是 bash 程序语言的关键字。并不是一个命令，[[ ]] 结构比 [ ] 结构更加通用。在 [[ 和 ]]之间所有的字符都不会发生文件名扩展或者单词分割，但是会发生参数扩展和命令替换。
#支持字符串的模式匹配，使用 =~ 操作符时甚至支持 shell 的正则表达式。字符串比较时可以把右边的作为一个模式，而不仅仅是一个字符串，比如 [[ hello == hell? ]]，结果为真。[[ ]] 中匹配字符串或通配符，不需要引号。
#使用 [[ ... ]] 条件判断结构，而不是 [ ... ]，能够防止脚本中的许多逻辑错误。&&、||、< > 操作符能够正常存在于 [[ ]] 条件判断结构中，但是如果出现在 [ ] 结构中的话，会报错。可以直接使用 if [[ $a != 1 && $a != 2 ]], 如果不使用双括号, 则为 if [ $a -ne 1] && [ $a != 2 ] 或者 if [ $a -ne 1 -a $a != 2 ]。
#双圆括号 (( ))
#整数扩展。这种扩展计算是整数型的计算，不支持浮点型。
#只要括号中的运算符、表达式符合 C 语言运算规则，都可用在 $((exp)) 中，甚至是三目运算符。作不同进位 (如二进制、八进制、十六进制) 运算时，输出结果全都自动转化成了十进制。如：echo $((16#5f)) 结果为 95 (16进位转十进制)
#单纯用 (( )) 也可重定义变量值，比如 a=5; ((a++)) 可将 $a 重定义为6 。
#常用于算术运算比较，双括号中的变量可以不使用 $ 符号前缀。括号内支持多个表达式用逗号分开。只要括号中的表达式符合 C 语言运算规则。可以使用 for((i=0;i<5;i++))，如果不使用双括号, 则为 for i in `seq 0 4` 或者 for i in {0..4}；直接使用 if (($i<5))，如果不使用双括号, 则为 if [ $i -lt 5 ]。