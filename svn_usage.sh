svn sw svn://192.168.0.220/project9/运维/【SAD】产品渠道支持开发/国内渠道接入/client/AndroidIntegration/trunk

svn commit -m "fix 编译 错误" clientproject/share_library_temp/src/a31/java/com/jedigames/ObtainDeviceidActivity.java clientproject/share_library_temp/src/a31/java/com/jedigames/ObtainDeviceIdActivity.java

大多数人创建一个 trunk 目录掌管开发的 "主
干"，一个 branches 目录存放分支副本，以及一个 tags 目录存放标记副本。如果一个版本库只掌管
一个项目，那么人们通常创建这些顶级目录:
/trunk
/branches
/tags


版本库备份
推荐的方法是运行
svnadmin hotcopy path/to/repository path/to/backup --clean-logs

常用的命令
将文件拉到本地目录
svn checkout 简写（svn co）
第一次用
svn checkout url --username=*** --password=*** path
其中url是服务器地址 path是将要拷贝的地址
或者svn checkout url　path 回车会提示输入用户名和密码
不是第一次，已经验证过用户名和密码
svn checkout url 就可以了
向版本库添加新的文件
svn add file
svn add path(某个文件或资源)
svn add *.path(添加当前目录下的所有的path文件)
将修改的文件提交
svn commit -m"提交信息"
svn ci(简写) -m""
提交部分文件修改
使用更改列表。与指定文件相比的优势在于，您可以在提交之前可视化并确认您想要的所有内容实际上已包含在内。

$ svn changelist fix-issue-237 foo.c 
Path 'foo.c' is now a member of changelist 'fix-issue-237'.
大功告成，svn 现在为你把事情分开了。当您处理多个更改时，这会有所帮助

$ svn status
A       bar.c
A       baz.c

--- Changelist 'fix-issue-237':
A       foo.c
最后，告诉它提交您想要更改的内容。
实际上更改列表不能与新目录一起使用......"Subversion 目前不支持对目录使用更改列表。"
$ svn commit --changelist fix-issue-237 -m "Issue 237"
只需列出文件:

$ svn ci -m "Fixed all those horrible crashes" foo bar baz graphics/logo.png
我不知道有什么方法可以告诉它忽略某些文件集。当然，如果你想提交的文件很容易被 shell 列出，你可以使用它:

$ svn ci -m "No longer sets printer on fire" printer-driver/*.c
您还可以让 svn 命令从文件中读取要提交的文件列表:

$ svn ci -m "Now works" --targets fix4711.txt
加锁/解锁
svn lock -m"LockMessage" [—force] path(某个文件)
svn lock -m "lock test file" lock.h
svn unlock path（表示某个文件）
更新到某个版本
svn update -r m path
svn update如果后面没有目录，默认将当前目录以及子目录下的所有文件都更新到最新版本。
svn update -r 100 test.m(将版本库中的文件test.m还原到版本100)
svn update test.m(更新，于版本库同步。如果在提交的时候提示过期的话，是因为冲突，需要先update，修改文件，然后清除svn resolved，最后再提交commit)
查看文件或者目录状态
svn status path（目录下的文件和子目录的状态，正常状态下不显示）
【?:不在svn的控制中；M:内容被修改；C:发生冲突；A:预定加入到版本库；K:被锁定】
svn status -v path(显示文件和子目录状态)
第一列保持相同，第二列显示工作版本号，第三和第四列显示最后一次修改的版本号和修改人。
注:svn status、svn diff和 svn revert这三条命令在没有网络的情况下也可以执行的，原因是svn在本地的.svn中保留了本地版本的原始拷贝。
简写:svn st
删除文件
svn delete path -m "delete test file"
例如:svn delete svn://192.168.1.1/pro/domain/test.txt -m "delete test file"
或者直接svn delete test.m 然后再svn ci -m 'delete test file'，推荐使用这种
简写:svn (del, remove, rm)
查看日志
svn log path
例如:svn log test.txt 显示这个文件的所有修改记录，及其版本号的变化
查看文件的详细信息
例如 :svn info test.m
比较差异
svn diff path(将修改的文件与基础版本比较)
例如:svn diff test.m
svn diff -r m:n path(对版本m和版本n比较差异)
例如:svn diff -r 200:201 test.m
简写:svn di
将两个版本之间的差异合并到当前文件
svn merge -r m:n path
例如:svn merge -r 200:205 test.m（将版本200与205之间的差异合并到当前文件，但是一般都会产生冲突，需要处理一下）
帮助
svn help
不常用的命令
版本库下的文件和目录列表
svn list path
显示path目录下的所有属于版本库的文件和目录
简写:svn ls
svn 创建纳入版本控制下的新目录
svn mkdir: 创建纳入版本控制下的新目录。
用法: 1、mkdir PATH...
2、mkdir URL...


恢复本地修改
svn revert: 恢复原始未改变的工作副本文件 (恢复大部份的本地修改)。revert:
用法: revert PATH...
注意: 本子命令不会存取网络，并且会解除冲突的状况。但是它不会恢复
被删除的目录
代码库URL变更
1、switch URL [PATH]
2、switch --relocate FROM TO [PATH...]
1、更新你的工作副本，映射到一个新的URL，其行为跟"svn update"很像，也会将
服务器上文件与本地文件合并。这是将工作副本对应到同一仓库中某个分支或者标记的
方法。
2、改写工作副本的URL元数据，以反映单纯的URL上的改变。当仓库的根URL变动 (比如方案名或是主机名称变动)，但是工作副本仍旧对映到同一仓库的同一目录时使用
这个命令更新工作副本与仓库的对应关系。

解决冲突
svn resolved:移除工作副本的目录或文件的"冲突"状态。
用法: resolved PATH...
注意: 本子命令不会依语法来解决冲突或是移除冲突标记；它只是移除冲突的
相关文件，然后让 PATH 可以再次提交。
输出指定文件或者URL的内容
svn cat 目标[@版本]...如果指定了版本，将从指定的版本开始查找。
svn cat -r PREV filename > filename (PREV 是上一版本,也可以写具体版本号,这样输出结果是可以提交的)
svn cat -- 显示特定版本的某文件内容。
cat示例:
svn cat -r 4 test.c #查看版本4中的文件test.c的内容,不进行比较。
svn list -- 显示一个目录或某一版本存在的文件列表。
list示例:
svn list svn://47.92.113.117/paodekuai
svn list -v http://svn.test.com/svn #查看详细的目录的信息(修订人,版本号,文件大小等)。
svn list -v svn://47.92.113.117/paodekuai
svn list [-v] #查看当前当前工作拷贝的版本库URL。
svn diff -- 显示特定修改的行级详细信息。
diff示例:
svn diff #什么都不加，会坚持本地代码和缓存在本地.svn目录下的信息的不同;信息太多，没啥用处。
svn diff -r 3 #比较你的本地代码和版本号为3的所有文件的不同。
svn diff -r 3 text.c #比较你的本地代码和版本号为3的text.c文件的不同。
svn diff -r 5:6 #比较版本5和版本6之间所有文件的不同。
svn diff -r 5:6 text.c #比较版本5和版本6之间的text.c文件的变化。
svn diff -c 6 test.c #比较版本5和版本6之间的text.c文件的变化。
svn log -- 显示svn 的版本log，含作者、日期、路径等。
log示例:
svn log #什么都不加会显示所有版本commit的日志信息:版本、作者、日期、comment。
svn log -r 4:20 #只看版本4到版本20的日志信息，顺序显示。
svn log -r 20:5 #显示版本20到4之间的日志信息，逆序显示。
svn log test.c #查看文件test.c的日志修改信息。
svn log -r 8 -v #显示版本8的详细修改日志，包括修改的所有文件列表信息。
svn log -r 8 -v -q #显示版本8的详细提交日志，不包括comment。
svn log -v -r 88:866 #显示从版本88到版本866之间，当前代码目录下所有变更的详细信息 。
svn log -v dir #查看目录的日志修改信息,需要加v。
svn log http://foo.com/svn/trunk/code/ #显示代码目录的日志信息。
常用命令
svn add file|dir -- 添加文件或整个目录
svn checkout -- 获取svn代码
svn commit -- 提交本地修改代码
svn status -- 查看本地修改代码情况:修改的或本地独有的文件详细信息
svn merge -- 合并svn和本地代码
svn revert -- 撤销本地修改代码
svn resolve -- 合并冲突代码
svn help [command] -- 查看svn帮助，或特定命令帮助
svn diff个性化定制
svn配置文件: ~/.subversion/config
修改~/.subversion/config，找到如下配置行:
# diff-cmd = diff_program (diff, gdiff, etc.)
将上面那个脚本的路径添加进去就行，修改为
diff-cmd = /usr/local/bin/diffwrap.sh #绝对路径
这样svn diff命令就会默认使用vimdiff比较文件。
diffwrap.sh文件
#! /bin/bash
# for svn diff: 修改~/.subversion/config，找到如下配置行:
# diff-cmd = diff_program (diff, gdiff, etc.)
# diff-cmd = ~/bin/diffwrap.sh
# 参数大于5时，去掉前5个参数；参数小于5，失败，什么也不做
shift 5
# 使用vimdiff比较
vimdiff "$@"
分支管理
a切换分支(svn sw)

svn sw
svn sw https://mysvn.cn/svn/repo/project/branches/version-xxx
1. 切换资源库（svn sw --relocate)

svn sw --relocate <from_url> <to_url> [PATH]
例子:
svn sw --relocate https://mysvn.cn/svn/old https://mysvn.cn/svn/new .
2. 切换分支（svn sw）

svn sw <branch_full_url>
例子:
svn sw https://mysvn.cn/svn/repo/project/branches/version-xxx
创建分支
svn cp -m "create branch" http://svn_server/xxx_repository/trunk http://svn_server/xxx_repository/branches/br_feature001

获得分支
svn co http://svn_server/xxx_repository/branches/br_feature001

合并主干上的最新代码到分支上
cd br_feature001
svn merge http://svn_server/xxx_repository/trunk
如果需要预览该刷新操作，可以使用svn mergeinfo命令，如:
svn mergeinfo http://svn_server/xxx_repository/trunk --show-revs eligible
或使用svn merge --dry-run选项以获取更为详尽的信息。
分支合并到主干
一旦分支上的开发结束，分支上的代码需要合并到主干。SVN中执行该操作需要在trunk的工作目录下进行。命令如下:
cd trunk
svn merge --reintegrate http://svn_server/xxx_repository/branches/br_feature001
分支合并到主干中完成后应当删该分支，因为在SVN中该分支已经不能进行刷新也不能合并到主干。

合并版本并将合并后的结果应用到现有的分支上
svn -r 148:149 merge http://svn_server/xxx_repository/trunk

建立tags
产品开发已经基本完成，并且通过很严格的测试，这时候我们就想发布给客户使用，发布我们的1.0版本
svn copy http://svn_server/xxx_repository/trunk http://svn_server/xxx_repository/tags/release-1.0 -m "1.0 released"

删除分支或tags
svn rm http://svn_server/xxx_repository/branches/br_feature001
svn rm http://svn_server/xxx_repository/tags/release-1.0
创建分支
创建一个分支
1
svn copy svn://xx.com/repo/trunk svn://xx.com/repo/branches/TRY-something -m 'make branches TRY-something'
把工作目录转到分支
1
svn switch svn://xx.com/repo/branches/TRY-something
当然，也可以再转到主干: svn switch svn://xx.com/repo/trunk
创建分支 svn cp -m "create branch" http://svn_server/xxx_repository/trunk http://svn_server/xxx_repository/branches/br_feature001 
获得分支 svn co http://svn_server/xxx_repository/branches/br_feature001 合并主干上的最新代码到分支上 cd br_feature001 svn merge http://sv…
