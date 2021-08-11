yum用法（centOs） 和brew用法（mac）
安装
1、安装rpm包：
yum install RPM包
7、列出资源库中所有可以安装或更新的rpm包的信息：
yum info
8、列出资源库中特定的可以安装或更新以及已经安装的rpm包的信息：
yum info 包名
9、列出资源库中所有可以更新的rpm包的信息：
yum info updates
10、列出已经安装的所有的rpm包的信息：
yum info installed
11、列出已经安装的但是不包含在资源库中的rpm包信息：
yum info 包名
删除
2、删除rpm包，包括与该包有依赖性的包：
yum remove 包名
更新
3、检查可更新的rpm包：
yum check-update
4、更新所有的rpm包：
yum update
5、更新指定的rpm包：
yum update 包名
6、大规模的升级版本：
yum upgrade
查询
12、列出资源库中所有可以更新的rpm包：
yum list updates
13、列出已经安装的所有rpm包：
yum list installed
14、列出已经安装的但不包含在资源库中的rpm包：
yum list extras
15、列出资源库中所有可以安装或更新的rpm包：
yum list
16、列出资源库中特定的可以安装或更新以及已经安装的rpm包：
yum list 包名
17、搜索匹配特定字符的rpm包的详细信息：
yum search 包名
18、搜索包含特定文件名的rpm包：
yum provides 包名
清除
19、清除暂存的rpm包文件：
yum clean packages
20、清除暂存的rpm头文件：
yum clean headers
21、清除暂存中旧的rpm旧文件：
yum clean oldheaders
22、清除暂存中旧的rpm头文件和包文件：
yum clean或yum clean all
linux下杀死进程全权讲解
经过搜集和整理相关的linux杀死进程的材料，在这里本人给大家推荐本篇文章，希望大家看后会有不少收获。
1. kill
作用：根据进程号杀死进程
用法： kill ［信号代码］ 进程ID
举例：
[root@localhost ~]# ps auxf |grep httpd
注意：kill -9 来强制终止退出
举例 [root@localhost ~]# ps aux |grep gaim
或者 [root@localhost ~]# pgrep -l gaim 5031 gaim
5031 gaim
[root@localhost ~]# kill -9 5031
特殊用法：
kill -STOP [pid]
发送SIGSTOP (17,19,23)停止一个进程，而并不linux杀死进程。
kill -CONT [pid]
发送SIGCONT (19,18,25)重新开始一个停止的进程。
kill -KILL [pid]
发送SIGKILL (9)强迫进程立即停止，并且不实施清理操作。
kill -9 -1
终止你拥有的全部进程。
2. killall
作用：通过程序的名字，直接杀死所有进程
用法：killall 正在运行的程序名
举例：
[root@localhost beinan]# pgrep -l gaim 2979 gaim
[root@localhost beinan]# killall gaim
注意：该命令可以使用 -9 参数来强制杀死进程
3. pkill
作用：通过程序的名字，直接杀死所有进程
用法：#pkill 正在运行的程序名
举例：
[root@localhost beinan]# pgrep -l gaim 2979 gaim
[root@localhost beinan]# pkill gaim
4. xkill
作用：杀死桌面图形界面的程序。
应用情形实例：firefox出现崩溃不能退出时，点鼠标就能杀死firefox 。
当xkill运行时出来和个人脑骨的图标，哪个图形程序崩溃一点就OK了。
如果您想终止xkill ，就按右键取消；
调用方法：
[root@localhost ~]# xkill
◆注：
KILLALL
NAME (名称)
killall - 以名字方式来linux杀死进程
SYNOPSIS (总览)
killall [-egiqvw] [-signal] name ...
killall -l
killall -V
DESCRIPTION (描述)
killall 发送一条信号给所有运行任意指定命令的进程. 如果没有指定信号名, 则发送SIGTERM.。
信号可以以名字 (如 -HUP ) 或者数字 (如 -1 ) 的方式指定. 信号 0 (检查进程是否存在)只能以数字方式指定。
如果命令名包括斜杠 (/), 那么执行该特定文件的进程将被杀掉, 这与进程名无关。
如果对于所列命令无进程可杀, 那么 killall 会返回非零值. 如果对于每条命令至少杀死了一个进程, killall 返回 0。Killall 进程决不会杀死自己 (但是可以杀死其它 killall 进程)。
OPTIONS (选项)
-e对于很长的名字, 要求准确匹配. 如果一个命令名长于 15 个字符, 则可能不能用整个名字 (溢出了). 在这种情况下, killall 会杀死所有匹配名字前 15 个字符的所有进程. 有了 -e 选项,这样的记录将忽略. 如果同时指定了 -v 选项, killall 会针对每个忽略的记录打印一条消息。
-g杀死属于该进程组的进程. kill 信号给每个组只发送一次, 即使同一进程组中包含多个进程。
-i交互方式，在linux杀死进程之前征求确认信息。
-l列出所有已知的信号名。
-q如果没有进程杀死, 不会提出抱怨。
-v报告信号是否成功发送。
-V显示版本信息。
-w等待所有杀的进程死去. killall 会每秒检查一次是否任何被杀的进程仍然存在, 仅当都死光后才返回. 注意: 如果信号被忽略或没有起作用, 或者进程停留在僵尸状态, killall 可能会永久等待。
FILES(相关文件)
/proc proc文件系统的存在位置。
KNOWN bugS (已知 BUGS)
以文件方式杀死只对那些在执行时一直打开的可执行文件起作用, 也即, 混杂的可执行文件不能够通过这种方式杀死。
要警告的是输入 killall name 可能不会在非 Linux 系统上产生预期的效果, 特别是特权用户执行时要小心。
在两次扫描的间隙, 如果进程消失了而被代之以一个有同样 PID 的新进程, killall -w 侦测不到。
问题定位解决
AWS EC2 实例磁盘空间扩容
amazon-web-servicesec2
发布于 2019-01-02 约 3 分钟
AWS Linux 实例磁盘空间扩容
大致步骤：
调整卷大小
调整分区大小
调整文件系统大小
参考文章：通过给EBS类型的根设备扩容解决AWS磁盘容量已满
1. 调整EBS存储卷大小
进入控制台，选择 EBSVolumes -ActionModify Volume
调整EBS存储卷
调整大小
2. 登录实例调整分区
首先使用lsblk可以查看附加到实例上的所有存储卷的真实size以及分区情况
image
存储卷已经调整为25G
其上只有1个分区 【1】显示为 xvda1
并没有占用全部空间
下面调整分区【1】使其占用全部卷可用空间
sudo growpart /dev/xvda 1
image
分区大小跟EBS大小一样了
image
但文件系统空间还没有识别到这部分新增的空间
image
3. 调整实例的文件系统进行扩容：
sudo resize2fs /dev/xvda1
https://i.imgur.com/qXLBJ8q.png
Size变为25G，Done
注：
- 挂载在根目录上的是EBS存储卷上的分区而不是这个卷，而且卷被扩容但是分区大小不变依旧不能扩容
- xvda是一个存储卷，xvda1是存储卷上的一个分区，但是发现并不是一个存储卷被挂载到根而是存储卷上的一个分区被挂在跟上
- EBS 存储卷视为容器，则分区是卷中的另一个容器，并且数据位于分区上。
- EBS 相当于一块外部磁盘，如果实例损坏，无法启动可用挂载到别到实例上读取数据。
jps command not found已解决
根据当前版本安装devel 包
eg:
yum install java-1.8.0-openjdk-devel -y
