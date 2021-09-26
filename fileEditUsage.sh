#三,文件管理与编辑
touch -a daemon.json #新建一个修改时间为系统当前时间的文件。
vi +daemon.json #打开文件,光标位于最后一行开头。
esc #从文本编辑返回到命令行模式。
#cp,mv,rm 文件的复制,移动与删除命令
#-d:直接把欲删除的目录的硬连接数据删除成0,删除该目录； -f:强制删除文件或目录； -i:删除已有文件或目录之前先询问用户； -r或-R:递归处理,将指定目录下的所有文件与子目录一并处理； --preserve-root:不对根目录进行递归操作； -v:显示指令的详细执行过程。
wget #通过url下载
unzip cased_L-12_H-768_A-12.zip -d bert #解压zip
$tar -zxvf java.tar.gz -C /usr/java #解压tar.gz文件
Tree . #列出目录结构
#windows下tree命令列出文件目录树
#tree [path] /f
#tree D:AR_C_Team /f
#可以将D:AR_C_Team目录下所有目录及子目录下的文件都打印出来
#tree D:AR_C_Team /f > %HOMEPATH%\file_tree.txt
#将D:AR_C_Team目录下所有目录及子目录下的文件都打印出来并重定向到一个文件中
#tree命令的中文意思为“树”,功能是以树形结构列出指定目录下的所有内容,包括所有文件,子目录及子目录里的目录和文件。
#命令格式
#tree [option] [directory]
#tree [选项] [目录]
#说明:
#1）注意tree命令以及后面的选项和目录,每个元素之间都至少要有一个空格
#2）tree命令后若不接选项和目录就会默认显示当前所在路径目录的目录结构
#tree命令的参数选项及说明,图片来源于 【跟老男孩学Linux运维:核心系统命令】
#-I:命令允许你使用正则匹配来排除掉你不想看到的文件夹
rpm -qa tree #<==查询tree命令是否安装。
tree-1.5.3-2.el6.x86_64 #<==如果没有显示就执行下面的命令
yum -y install tree #<==安装tree命令的yum命令
 临时解决树结构乱码的方法 
LANG=en_US.UTF-8
#不带任何参数执行tree命令
[root@king etc]# cd ~
[root@king ~]# tree   #<==显示当前目录的结构。
. #<==“.”以当前目录为起点。
├── anaconda-ks.cfg
├── install.log
└── install.log.syslog
0 directories, 3 files
例子二:以树形结构显示目录下的所有内容（-a的功能）
 [root@king ~]# tree -a #<==带-a参数显示所有文件（包括隐藏文件）。
.
├── anaconda-ks.cfg
├── .bash_history  #<==在Linux系统中,以“.”点号开头的文件为隐藏文件,默认不显示。
├── .bash_logout
├── .bash_profile
├── .bashrc
├── .cshrc
├── install.log
...省略若干行...
例子三:只列出根目录下第一层目录的结构（-L功能）
 [root@king ~]# tree -L 1 / #<==-L参数后接数字,表示查看目录的层数,不带-L选项默
认显示所有层数。
/
├── bin
├── boot
...省略若干行...
├── sys
├── tmp
├── usr
└── var
20 directories, 0 files
例子四:只显示所有的目录（但不显示文件）
 [root@king ~]# tree -d /etc/ #<==-d参数表示只显示目录。
/etc/
|-- ConsoleKit
| |-- run-seat.d
| |-- run-session.d
| '-- seats.d
|-- NetworkManager
| '-- dispatcher.d
……省略若干行
[root@oldboy ~]# tree -dL 1 /etc/ #<==-d参数只显示目录,-L参数显示层数,这里是1层。
/etc/
|-- ConsoleKit
|-- NetworkManager
|-- X11
……省略若干行
例子五:用tree命令来区分目录和文件的方法
[root@king ~]# tree -L 1 -F /boot/ #<==使用-F参数会在目录后面添加“/”,方便区分目录
/boot/
├── config-2.6.32-504.el6.x86_64
├── efi/
├── grub/
├── initramfs-2.6.32-504.el6.x86_64.img
├── lost+found/
├── symvers-2.6.32-504.el6.x86_64.gz
├── System.map-2.6.32-504.el6.x86_64
└── vmlinuz-2.6.32-504.el6.x86_64*
[root@king ~]# tree -L 1 -F /boot/|grep /$ #<==过滤以斜线结尾的所有内容
/boot/
|-- efi/
|-- grub/
|-- lost+found/
3 directories, 5 files
[root@king ~]# tree -L 1 -d /boot/ #<==使用-d参数只显示目录树,这样可轻松过滤内容中的目录<br>/boot/<br>|-- efi<br>|-- grub<br>'-- lost+found<br>3 directories
 说明:$在Linux正则表达式中标识以什么什么结尾,^表示以什么什么开头,^$表示空行,此处只做简要说明
例子六:忽略某个文件夹的内容
-I命令允许你使用正则匹配来排除掉你不想看到的文件夹,例如:
tree -I "node_modules"
也可以使用|同时排除掉多个文件夹:
tree -I "node_modules|cache|test_*"
最后一个使用到正则匹配,这样以test_开头的文件夹都不会被显示出来。
文件查找
$find / -name 'cd' 按文件名查找文件
$locate curl 使用locate搜索linux系统中的文件,它比find命令快。因为它查询的是数据库(/var/lib/locatedb),数据库包含本地所有的文件信息。
$whereis grep 使用”whereis“命令可以搜索linux系统中的所有可执行文件即二进制文件。
$ which java 使用which命令查看系统命令是否存在,并返回系统命令所在的位置。
$ grep fsd 根据文件内容查找字符串
$ zipgrep在zip文件中根据文件内容查找字符串
1. mkdir命令
创建目录
mkdir [选项] 目录名
选项	说明
-m	对新建目录设置存取权限
-p	递归创建不存在目录,一次创建多个

2. more cat less 命令
查看文件内容
cat可以把内容输出到标准输出,也可用于连接合并文件
cat 文件1 文件2 >文件3
选项	说明
-A	制表符显示为^I,同时行尾显示一个$
-b	非空号按顺序编号,从1开始

3. diff命令
逐行比较文件差异,如果比较的是目录,则比较相同文件名的文件,但不会比较子目录
diff [选项] 文件1 文件2
选项	说明
-c	显示全部内容,并标出不同
-b	忽略行尾空格,字符串中一个或多个空格视为相同
-r	当比较目录时会比较子目录文件
-s	当两个文件相同,显示文件相同信息

4. grep命令
文本过滤工具,根据指定字符串对文件每一行进行搜索,找到了,则输出
grep [选项] 需要查找的字符串文件名
选项	说明
-A NUM	除了列出符合条件的行外,同时列出每个符合条件行的后NUM行
-B NUM	与-A相反,列前NUM行
-c	只显示行数,不列出具体信息
-f file	事先将要搜索样式写入一个文件,每行一个样式,根据文件搜索
-i	忽略大小写
-n	显示行号
 grep 'word' filename
关键词出现次数
模糊匹配
grep -o "keyword" filename |wc -l
精确匹配
grep -wo "keyword" filename |wc -l
包含关键字的行数（一行存在多个关键字,计数1）
grep -c "keyword" filename
grep获取文件中的最后一次匹配项
grep '查找的内容' -A 1文件名 | tail -n 2
grep只返回第一个匹配
grep -o -a -m 1 -h -r "Pulsanti Operietur" /path/to/dir | head -1
linux 命令行 grep 反向匹配 怎么写？ grep –P 你的这个应该属于正则零宽断言,grep本身不支持零宽断言,但是加参数 -P 或 --perl-regexp 可以实现,哈哈哈,我也学会了。
fgrep 'word-to-search' file.txt
grep 'word' file1 file2 file3
grep 'string1 string2' filename
cat otherfile | grep 'something'
command | grep 'something'
command option1 | grep 'data'
grep --color 'data' fileName
grep [-options] pattern filename
fgrep [-options] words file
Just use the --include parameter, like this:
grep -inr --include \*.h --include \*.cpp CP_Image ~/path[12345] | mailx -s GREP email@domain.com
that should do what you want.
#To take the explanation from HoldOffHunger's answer below:
grep: command
-r: recursively
-i: ignore-case
-n: each output line is preceded by its relative line number in the file
--include \*.cpp: all *.cpp: C++ files (escape with \ just in case you have a directory with asterisks in the filenames)
./: Start at current directory.
grep -r -i --include \*.php _doPayUser ./
function _doPayUser
grep -r -i --include \*.php 'function _doPayUser' ./
5. rm命令
删除文件/目录
rm [选项] 文件/目录
选项	说明
-r	递归删除,如果没有-r rm命令不能删除目录
-f	忽略不存在的问题
-i	交互式删除,删除前确认

6. touch命令
改变指定文件访问时间和修改时间,如果不存在则创建此文件,如果没有指定时间使用当前时间
touch [选项] 设定的时间文件
选项	说明
-a	改变文件访问时间为系统当前时间,无须设置时间选项
-m	改变文件修改时间为系统当前时间,无须设置时间选项
-c	如果文件不存在,不创建也不提示
-d或-t	使用指定日期或时间
-r<参考文件或目录>	把指定文件或目录的日期,时间设成与参考文件或目录相同

7. ln命令
在文件或目录之间创建链接
硬链接: 通过文件inode号进行链接,多个文件指向同一个inode号,
只有所有链接都删除后文件才会真的被删除
软链接: 符号链接,类似于快捷方式
ln [选项] 源文件 目标链接名
选项	说明
-f	在目标位置存在与链接名相同文件,这个文件将删除
-s	软链接
-d	允许系统管理员硬链接自己目录
-b	对将在链接时会覆盖或删除的文件进行备份

8. file命令
显示文件类型,长度为0的文件识别为空文件,符号连接文件默认显示引用的真实文件路径
file [选项] 文件名
选项	说明
-b	显示文件类型结果,不显示对应文件名称
-L	直接显示符号链接指向文件类型
-z	显示压缩文件信息
-i	如果文件不是常规信息,则不进一步对文件类型进行分类

9. cp命令
复制
cp [选项] 源文件或目录 目标文件或目录
选项	说明
-a	复制目录时保罗所有信息,包含文件链接,文件属性,递归复制目录
-r	给出源文件是个目录,则递归复制所有子目录与文件,目标文件必须为目录名
-d	复制时保留链接
-p	保留文件修改时间和存取权限
-i	如果已有相同目标文件,提示用户是否覆盖

10. find命令
指定路径查找指定文件
find 路径名[-options] [-print -exec -ok 命令 {} \;]
-options	说明
-name '字符串'	查找文件名匹配的文件
-lname '字符串'	查找文件名匹配的符号链接文件
-gid n	查找属于ID号为n的用户组的文件
-uid n	查找属于ID号为n的用户文件
-empty	查找大小为0的文件或目录
-path '字符串'	查找路径名匹配的文件
-group '字符串'	查找匹配用户组的文件
-depth	搜索目录深度
-prune 目录	指出搜索时忽略的目录
-size n	查找文件长度为n的文件,带有c时表示文件长度以字节计
-user '字符串'	查找匹配用户的字符串
-mtime +n/-n	按时间搜索,+n是n天之前,-n是今天到n天之前的
-type 文件类型	按文件类型搜索 b:块设备文件, c:字符设备文件,
f:普通文件, l:符号文件, d:目录, p:管道,
s:socket文件
 -print: 将搜索结果输出到标准输出
-exec: 对符合条件文件执行所给Linux命令
-ok:  对符合条件文件执行所给Linux铭刻,会询问用户是否执行
11. split命令
分割文件
split [选项] [输入文件] [输出文件]
选项	说明
-b size	指定分割出来文件大小,size可加入单位,b代表512字节,k代表1KB,m代表1MB
-n	指定分割每个文件长度,默认1000行
-d	生成文件序列以数字形式命名
-a	指定生成文件序列长度,默认长度为2

12. mv命令
对文件或目录执行改名或剪切操作
mv [选项] 源文件或目录 目标文件或目录
选项	说明
-i	对已存在文件或目录,会询问是否覆盖
-f	默认覆盖,无交互
 sudo cp minikube /usr/local/bin && rm minikube
四,压缩与解压
1. zip/unzip命令
生成后缀名为 .zip 的压缩包
zip [选项] 压缩文件名 需要压缩的文档列表unzip [选项] 压缩文件吗
zip命令选项:
选项	说明
-r	递归压缩,包括目录,子目录,文件
-d	从压缩文件内删除指定文件
-i "文件列表"	只压缩文件列表内文件
-x "文件列表"	压缩时排除文件列表中指定的文件
-u	更新文件到压缩文件中
-m	压缩后删除原始文件
-F	尝试修复受损的压缩文件
-T	检查压缩文件内每个文件是否正确
- 压缩级别	1-9数字 9最高
压缩水平调节压缩速度,zip压缩级别的总数为10 – (0-9),其中-0表示无压缩（存储所有文件）,-1表示最快的压缩速度（压缩程度较低）,-9表示最慢的压缩速度（最佳压缩,忽略后缀列表）。
默认压缩级别为-6。
如果压缩级别越高,那么压缩速度就会越慢,但相应的压缩效果越好,压缩后的文件越小,反之,压缩级别越低,则压缩速度越快,相应的压缩效果越差,压缩后的文件越大。
如何找到zip文件的压缩级别？
唯一的方法是用不同级别重新压缩zip文件,直到找到与长度匹配的文件为止。假设整个zip文件使用同一级别,则可以重新压缩条目之一以找到级别。
即使仅在您知道该工具以及所使用工具的版本的情况下,它也才有效。例如7z,WinZip,Info-ZIP。
 unzip命令选项:
选项	说明
-x "文件列表"	解压文件,但不包括文件列表中指定的文件
-t	测试是否损坏,不解压
-v	查看压缩文件详细信息,不解压
-n	解压时不覆盖已经存在文件
-o	解压时覆盖已存在文件,无用户交互
-d 目录名	把解压文件解压到指定目录

2. gzip/gunzip命令
压缩文件预设扩展名为 .gz gunzip是gzip的硬链接,无论压缩还是解压都可以通过gzip实现
gzip只能压缩文件,不能压缩目录,即使指定目录也只能压缩目录内所有文件
gzip [选项] 压缩/解压文档名
选项	说明
-d	解压
-r	递归压缩目录下子目录所有文件
-t	检查压缩文档完整性
-v	对每个压缩和解压的文档,显示相应文件名和压缩比
-l	显示压缩文件的压缩信息
-num	指定压缩比例 -1/-fast为最低压缩比,-9/-best是最高压缩比,默认为6

3. bzip2/bunzip2命令
类似于gzip/gunzip,只能对文件进行压缩,默认后缀 .bz2
bunzip2是bzip2的符号链接,压缩解压都可以通过bzip2实现
bzip [选项] 压缩/解压的文件
选项	说明
-d	执行解压,此时选项后跟着解压缩文件
-v	压缩或解压时显示详细信息
-k	压缩或解压后默认删除原始文件,此选项保留原始文件
-f	bzip2压缩或解压后若输出文件与现文件同名,预设不会覆盖现有文件,该选项直接覆盖
-t	测试压缩文件完整性
- 压缩级别	1-9数字,数字越大,压缩率越高

4. tar命令
tar是归档工具,归档为一个文件,但是不会压缩
tar [主选项+辅助选项] 文件或目录
主选项:
主选项	说明
-c	新建文件
-r	要归档文件追加到档案文件末尾
-t	列出档案文件中已经归档的文件列表
-x	从打包的档案文件中还原文件
-u	更新档案文件,新建文件替换档案中的原始文件
 辅助选项:
辅助选项	说明
-z	调用gzip 在文件打包的过程中压缩/解压文件
-w	还原文件时,文件修改时间设为当前时间
-j	调用bzip2 在文件打包过程中压缩/解压文件
-Z	调用compress命令过滤档案
-f	后面紧跟档案文件存储设备,-f 必须是tar最后一个选项
-v	创建归档文件过程中,显示各个归档文件名称
-p	文件归档规程中,文件属性不变
-N "yyyy/mm/dd"	指定日期后的文件才会被打包
--exclude file	打包过程中,忽略file文件
tar -zcvf [目录]/压缩包文件名.tar.gz 源文件 // 调用gzip压缩tar -zxvf [压缩包文件名.tar.gz] -C [路径]/ // 解压到指定路径
tar -zcvf login.tar.gz login
tar -jcvf [目录]/压缩包文件名.tar.bz2 源文件 // 调用bzip2压缩tar -jxvf [压缩包文件名.tar.bz2] -C [路径]/ // 解压到制定路径
5. dd命令
转换或复制文件,同时对设备进行 备份
dd if="input_file" of="output_file" bs="block_size" count="number"
选项	说明
if	输入文件,可以是设备,比如磁盘某分区或整个磁盘
of	输出文件,可以使输出设备,比如磁盘,磁带等
bs	指定一个block大小,默认512字节
count	bs的数量
dd if=/dev/sda2 of=/opt/sda2.back // 备份/dev/sda2分区
6. cpio命令
以重定向方式打包,备份,还原,回复文件的工具,可以解压以 .cpio 或 .tar 结尾的文件
cpio [选项] > 文件名或设备名
cpio [选项] < 文件名或设备名
选项	说明
-o	文件复制,打包成文件或把文件输出到设备
-i	文件解压或把设备上的备份还原到系统
-t	查看cpio打包的文件内容与输出到设备上的文件内容
-v	显示打包过程中的文件名
-d	在cpio还原文件过程中,自动建立相应目录
-c	一种较新的存储方式
-B	默认块增大到5120字节,默认块为512字节,可以加快存取速度


对1.sh文件赋予可执行权限:
chmod u+x 1.sh
1
对文件夹下所有shell文件赋予可执行权限:
chmod u+x *.sh
同步文件夹 rsync
rsync是可以实现增量备份的工具。配合任务计划,rsync能实现定时或间隔同步,配合inotify或sersync,可以实现触发式的实时同步。
-r 参数
本机使用 rsync 命令时,可以作为cp和mv命令的替代方法,将源目录同步到目标目录。
$ rsync -r source destination
上面命令中,-r表示递归,即包含子目录。注意,-r是必须的,否则 rsync 运行不会成功。source目录表示源目录,destination表示目标目录。
如果有多个文件或目录需要同步,可以写成下面这样。
$ rsync -r source1 source2 destination
上面命令中,source1,source2都会被同步到destination目录。
-a 参数
-a参数可以替代-r,除了可以递归同步以外,还可以同步元信息（比如修改时间,权限等）。由于 rsync 默认使用文件大小和修改时间决定文件是否需要更新,所以-a比-r更有用。下面的用法才是常见的写法。
$ rsync -a source destination
目标目录destination如果不存在,rsync 会自动创建。执行上面的命令后,源目录source被完整地复制到了目标目录destination下面,即形成了destination/source的目录结构。
如果只想同步源目录source里面的内容到目标目录destination,则需要在源目录后面加上斜杠。
$ rsync -a source/ destination
上面命令执行后,source目录里面的内容,就都被复制到了destination目录里面,并不会在destination下面创建一个source子目录。
-n 参数
如果不确定 rsync 执行后会产生什么结果,可以先用-n或--dry-run参数模拟执行的结果。
$ rsync -anv source/ destination
上面命令中,-n参数模拟命令执行的结果,并不真的执行命令。-v参数则是将结果输出到终端,这样就可以看到哪些内容会被同步。
--delete 参数
默认情况下,rsync 只确保源目录的所有内容（明确排除的文件除外）都复制到目标目录。它不会使两个目录保持相同,并且不会删除文件。如果要使得目标目录成为源目录的镜像副本,则必须使用--delete参数,这将删除只存在于目标目录,不存在于源目录的文件。
$ rsync -av --delete source/ destination
上面命令中,--delete参数会使得destination成为source的一个镜像。
四,排除文件
4.1 --exclude 参数
有时,我们希望同步时排除某些文件或目录,这时可以用--exclude参数指定排除模式。
$ rsync -av --exclude='*.txt' source/ destination
# 或者
$ rsync -av --exclude '*.txt' source/ destination
上面命令排除了所有 TXT 文件。
注意,rsync 会同步以"点"开头的隐藏文件,如果要排除隐藏文件,可以这样写--exclude=".*"。
如果要排除某个目录里面的所有文件,但不希望排除目录本身,可以写成下面这样。
$ rsync -av --exclude 'dir1/*' source/ destination
多个排除模式,可以用多个--exclude参数。
$ rsync -av --exclude 'file1.txt' --exclude 'dir1/*' source/ destination
多个排除模式也可以利用 Bash 的大扩号的扩展功能,只用一个--exclude参数。
$ rsync -av --exclude={'file1.txt','dir1/*'} source/ destination
如果排除模式很多,可以将它们写入一个文件,每个模式一行,然后用--exclude-from参数指定这个文件。
$ rsync -av --exclude-from='exclude-file.txt' source/ destination
4.2 --include 参数
--include参数用来指定必须同步的文件模式,往往与--exclude结合使用。
$ rsync -av --include="*.txt" --exclude='*' source/ destination
上面命令指定同步时,排除所有文件,但是会包括 TXT 文件。
远程同步
5.1 SSH 协议
rsync 除了支持本地两个目录之间的同步,也支持远程同步。它可以将本地内容,同步到远程服务器。
$ rsync -av source/ username@remote_host:destination
也可以将远程内容同步到本地。
$ rsync -av username@remote_host:source/ destination
rsync 默认使用 SSH 进行远程登录和数据传输。
由于早期 rsync 不使用 SSH 协议,需要用-e参数指定协议,后来才改的。所以,下面-e ssh可以省略。
$ rsync -av -e ssh source/ user@remote_host:/destination
但是,如果 ssh 命令有附加的参数,则必须使用-e参数指定所要执行的 SSH 命令。
$ rsync -av -e 'ssh -p 2234' source/ user@remote_host:/destination
上面命令中,-e参数指定 SSH 使用2234端口。
5.2 rsync 协议
除了使用 SSH,如果另一台服务器安装并运行了 rsync 守护程序,则也可以用rsync://协议（默认端口873）进行传输。具体写法是服务器与目标目录之间使用双冒号分隔::。
$ rsync -av source/ 192.168.122.32::module/destination
注意,上面地址中的module并不是实际路径名,而是 rsync 守护程序指定的一个资源名,由管理员分配。
如果想知道 rsync 守护程序分配的所有 module 列表,可以执行下面命令。
$ rsync rsync://192.168.122.32
rsync 协议除了使用双冒号,也可以直接用rsync://协议指定地址。
$ rsync -av source/ rsync://192.168.122.32/module/destination
rsync可以实现scp的远程拷贝(rsync不支持远程到远程的拷贝,但scp支持),cp的本地拷贝,rm删除和"ls -l"显示文件列表等功能。但需要注意的是,rsync的最终目的或者说其原始目的是实现两端主机的文件同步,因此实现的scp/cp/rm等功能仅仅只是同步的辅助手段,且rsync实现这些功能的方式和这些命令是不一样的。事实上,rsync有一套自己的算法,其算法原理以及rsync对算法实现的机制可能比想象中要复杂一些。
想要看懂rsync命令的man文档,使用"-vvvv"分析rsync执行过程,以及实现rsync更强大更完整的功能,没有这些理论知识的支持是绝对不可能实现的。
-I 显示档案变动资讯
执行rsync时加入-i参数可以个别档案变动的资讯:
rsync -avhi myfolder/ backup/
sending incremental file list
.d..t...... ./
.f...p..... find_edimax.c
>f..t...... myfile.gz
>f+++++++++ new.file
>f.st...... pack.c
sent 14.34M bytes received 79 bytes 3.19M bytes/sec
total size is 15.99M speedup is 1.12
#加入-i之后,每个档案项目之前会多出一个标示字串,而这个标示字串的栏位有11个,分别为YXcstpoguax,其意义如下:
#Y:<代表档案传送至远端,>代表档案传送至本地端,c代表本地端变动（建立目录等）,h代表硬式连结（hard link）,.代表没有变动,*代表其余栏位有包含讯息（例如deleting）。
#X:档案类型,f为一般档案,d为目录,L为连结档,D为设备档（device）,S为特殊档案（如sockets或fifo）。
#c:代表档案内容有变动。
#s:代表档案大小有变动。
#t:代表档案时间戳记有变动。
#p:代表档案权限有变动。
#o:代表档案拥有者有变动。
#g:代表档案群组有变动。
#u:保留栏位。
#a:代表档案ACL 资讯有变动。
#x:代表档案扩充属性（extended attribute）有变动。
#限定备份档案大小
#rsync也可以依照档案的大小来选择备份的档案,假设在myfolder目录中有以下这些档案:
ls -l myfolder/
total 15632
-rw-r--r-- 1 pi pi 1658348 Feb 5 09:09 bluez-5.43.tar.xz
-rw-r--r-- 1 pi pi 94 Feb 5 07:57 chinese.py
-rw-r--r-- 1 pi pi 2736 Feb 5 07:57 find_edimax.c
-rw-r--r-- 1 pi pi 14332601 Feb 5 09:09 myfile.gz
-rw-r--r-- 1 pi pi 763 Feb 5 08:02 pack.c
--min-size 可以指定备份档案的大小下限,例如只备份1MB 以上的档案:
rsync -avh --min-size=1M myfolder/ backup/
sending incremental file list
./
bluez-5.43.tar.xz
myfile.gz
sent 16.00M bytes received 57 bytes 31.99M bytes/sec
total size is 15.99M speedup is 1.00
而--max-size可以指定备份档案的大小上限,例如只备份4KB以下的档案:
rsync -avh --max-size=4K myfolder/ backup/
sending incremental file list
./
chinese.py
find_edimax.c
pack.c
sent 3.91K bytes received 76 bytes 7.97K bytes/sec
total size is 15.99M speedup is 4,012.68
--min-size与--max-size也可以同时使用,例如只备份1KB到2MB之间的档案:
rsync -avh --min-size=1K --max-size=2M myfolder/ backup/
sending incremental file list
./
bluez-5.43.tar.xz
find_edimax.c
sent 1.66M bytes received 57 bytes 3.32M bytes/sec
total size is 15.99M speedup is 9.62

#修改文件权限与另一个文件一致
chmod 'stat -c %a ~/svn/AndroidIntegration/clientproject/import-summary.txt' ~/svn/p21_AS