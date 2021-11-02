
adb install ~/Downloads/p.apk

adb install ~/Downloads/P21_googleplay_2.46.7.\[409091639\]_release.apk

adb shell setprop log.tag.FA VERBOSE
adb shell setprop log.tag.FA-SVC VERBOSE
adb logcat -v time -s FA FA-SVC


#gradlew使用 Git将我的项目文件从我的 Windows 机器提交到远程存储库后，gradlew在我的 Linux 服务器上调用失败并显示以下消息：
#
#/usr/bin/env: bash: 没有那个文件或目录
#这是因为 gradlew 文件具有 Windows 文件结尾。
#
#您可以dos2unix使用apt-get或yum运行以下命令进行安装：

sudo apt-get install dos2unix

sudo yum install -y dos2unix
#然后用于dos2unix转换行尾
#
#从 CRLFWindows CarriageReturn + LineFeed
#
#LF仅适用于Linux LineFeed：

dos2unix ./gradlew
#然后运行你gradlew的测试：

./gradlew clean -d


#我刚刚将 Android Studio 更新到了 4.2 版。我很惊讶在我的项目中没有看到 Gradle 任务。
#转到File -> Settings -> Experimental并取消选中Do not build Gradle task list during Gradle sync，
#然后同步项目File -> Sync Project with Gradle Files。
#如果问题仍然存在，只需重新启动 Android Studio。

apktool.bat d demo.apk		//demo.apk需要改成你的apk的名字
apktool b demo -o new_demo.apk
#由于这个新apk已经被你改过了，原作者的签名也就没了，所以无法安装到手机上，我们需要自己给个签名
#
#注意：接下来的操作需要以管理员身份运行cmd
#
#· 首先找到jdk中bin目录所在位置，默认位置为C:\Program Files\Java\jdk-9.0.4\bin
#
#我们将需要打签名的new_demo.apk放到该目录下，cmd中cd到该目录，
keytool -genkey -alias demo.keystore -keyalg RSA -validity 40000 -keystore demo.keystore

jarsigner -verbose -keystore demo.keystore demo.apk demo.keystore


创建应用程序代码时，apk 文件包含一个 .dex 文件，其中包含二进制 Dalvik 字节码。这是平台实际理解的格式。但是，读取或修改二进制代码并不容易，因此有一些工具可以在人类可读的表示形式之间进行转换。最常见的人类可读格式称为 Smali。这与您提到的反汇编程序基本相同。
Smali是用于Dalvik（Android虚拟机）的反汇编程序实现，汇编工具（将Smali代码汇编为dex文件）为smali.jar，与之对应的baksmali.jar则是反汇编程序（下载地址）

Smali文件结构
一个Smali文件对应的是一个Java的类，更准确的说是一个.class文件，如果有内部类，需要写成ClassName$InnerClassA、ClassName$InnerClassB…这样的形式
基本类型
类型关键字	对应Java中的类型说明
V	void，只能用于返回类型
Z	boolean
B	byte
S	short
C	char
I	int
J	long (64 bits)
F	float
D	double (64 bits)
对象
Object类型，即引用类型的对象，在引用时，使用L开头，后面紧接着的是完整的包名，比如：java.lang.String对应的Smali语法则是Ljava/lang/String

数组
数组定义比较有意思，一维数组在类型的左边加一个方括号，比如：[I等同于Java的int[]，每多一维就加一个方括号，最多可以设置255维。。。
方法声明及调用
官方Wiki中给出的Smali引用方法的模板如下：
Lpackage/name/ObjectName;->MethodName(III)Z
第一部分Lpackage/name/ObjectName;用于声明具体的类型，以便JVM寻找

第二部分MethodName(III)Z，其中MethodName为具体的方法名，()中的字符，表示了参数数量和类型，即3个int型参数，Z为返回值的类型，即返回Boolean类型

由于方法的参数列表没有使用逗号这样的分隔符进行划分，所以只能从左到右，根据类型定义来区分参数个数，这一点需要比较仔细来观察

如果需要调用构造方法，则MethodName为：<init>

寄存器声明及使用
在Smali中，如果需要存储变量，必须先声明足够数量的寄存器，1个寄存器可以存储32位长度的类型，比如Int，而两个寄存器可以存储64位长度类型的数据，比如Long或Double

声明可使用的寄存器数量的方式为：.registers N，N代表需要的寄存器的总个数，同时，还有一个关键字.locals，它用于声明非参数的寄存器个数（包含在registers声明的个数当中），也叫做本地寄存器，只在一个方法内有效，但不常用，一般使用registers即可
Dalvik指令集
如果需要使用Smali编写程序，还需要掌握常用的Dalvik虚拟机指令，其合集称为Dalvik指令集。这些指令有点类似x86汇编的指令，但指令更多，使用也非常简单方便。

虽然我们了解了Smali的基本语法，但一般不会直接编写Smali来进行功能开发，这样成本过高，而了解Smali的目的，是为了做Android的逆向工程，如：分析APP的原理、漏洞检测，当然，也可以对一些APP做一些小改动


AAPT2 支持通过启用增量编译实现更快的资源编译。这是通过将资源处理拆分为两个步骤来实现的：

编译：将资源文件编译为二进制格式。
链接：合并所有已编译的文件并将它们打包到一个软件包中。
这种拆分方式有助于提高增量编译的性能。例如，如果某个文件中有更改，您只需要重新编译该文件。
编译
AAPT2 支持编译所有 Android 资源类型，如可绘制对象和 XML 文件。调用 AAPT2 进行编译时，每次调用都应传递一个资源文件作为输入。然后，AAPT2 会解析该文件并生成一个扩展名为 .flat 的中间二进制文件。

虽然您可以使用 --dir 标记将包含多个资源文件的资源目录传递给 AAPT2，但如果这样做，您将无法获得增量资源编译的优势。也就是说，如果传递整个目录，即使只有一项资源发生了改变，AAPT2 也会重新编译目录中的所有文件。

输出文件的类型可能会因您为编译提供的输入而异。下表对此进行了说明：
AAPT2 输出的文件不是可执行文件，稍后您必须在链接阶段添加这些二进制文件作为输入来生成 APK。但是，所生成的 APK 文件不是可以立即部署在 Android 设备上的可执行文件，因为它不包含 DEX 文件（已编译的字节码）且未签名。

编译语法
使用 compile 的一般语法如下：


aapt2 compile path-to-input-files [options] -o output-directory/
编译选项
您可以将多个选项与 compile 命令搭配使用，如下表中所示：

选项	说明
-o path	指定已编译资源的输出路径。
这是一个必需的标记，因为您必须指定 AAPT2 可将已编译的资源输出并存储到其中的目录的路径。

--dir directory	指定要在其中搜索资源的目录。
虽然您可以使用此标记通过一个命令编译多个资源文件，但这样就无法获得增量编译的优势，因此不建议对大型项目使用。

--pseudo-localize	生成默认字符串的伪本地化版本，如 en-XA 和 en-XB。
--no-crunch	停用 PNG 处理。
如果您已处理 PNG 文件，或者要创建不需要减小文件大小的调试 build，则可使用此选项。启用此选项可以加快执行速度，但会增大输出文件大小。

--legacy	将使用早期版本的 AAPT 时允许的错误视为警告。
此标记应用于意外的编译时错误。如需解决在使用 AAPT2 时可能遇到的已知行为变化，请参阅 AAPT2 中的行为变化。

-v	启用详细日志记录。
链接
在链接阶段，AAPT2 会合并在编译阶段生成的所有中间文件（如资源表、二进制 XML 文件和处理过的 PNG 文件），并将它们打包成一个 APK。此外，在此阶段还会生成其他辅助文件，如 R.java 和 ProGuard 规则文件。不过，生成的 APK 不包含 DEX 字节码且未签名。也就是说，您无法将此 APK 部署到设备。如果您不使用 Android Gradle 插件从命令行构建应用，则可以使用其他命令行工具，如使用 d8 将 Java 字节码编译为 DEX 字节码，以及使用 apksigner 为 APK 签名。

链接语法
使用 link 的一般语法如下：


aapt2 link path-to-input-files [options] -o
outputdirectory/outputfilename.apk --manifest AndroidManifest.xml
在以下示例中，AAPT2 将两个中间文件（drawable_Image.flat 和 values_values.arsc.flat）与 AndroidManifest.xml 文件进行了合并。AAPT2 会根据 android.jar 文件链接结果，该文件中包含了 Android 软件包中定义的资源：


 aapt2 link -o output.apk
 -I android_sdk/platforms/android_version/android.jar
    compiled/res/values_values.arsc.flat
    compiled/res/drawable_Image.flat --manifest /path/to/AndroidManifest.xml -v
链接选项
您可以将以下选项与 link 命令搭配使用：

选项	说明
-o path	指定链接的资源 APK 的输出路径。
这是一个必需的标记，因为您必须指定可以存放链接资源的输出 APK 的路径。

--manifest file	指定要构建的 Android 清单文件的路径。
这是一个必需的标记，因为清单文件中包含有关您应用的基本信息（如软件包名称和应用 ID）。

-I	提供平台的 android.jar 或其他 APK（如 framework-res.apk）的路径，这在构建功能时可能很有用。
如果您要在资源文件中使用带有 android 命名空间（例如 android:id）的属性，则必须使用此标记。
-A directory	指定要包含在 APK 中的资产目录。
您可以使用此目录存储未处理的原始文件。如需了解详情，请参阅访问原始文件。

-R file	传递要链接的单个 .flat 文件，使用 overlay 语义，而不使用 <add-resource> 标记。
如果您提供与现有文件重叠（扩展或修改现有文件）的资源文件，系统会使用最后提供的冲突资源。

--package-id package-id	指定要用于应用的软件包 ID。
除非与 --allow-reserved-package-id 结合使用，否则您指定的软件包 ID 必须大于或等于 0x7f。

--allow-reserved-package-id	允许使用保留的软件包 ID。
保留的软件包 ID 是指通常分配给共享库的 ID，范围从 0x02 到 0x7e（包含端点值）。通过使用 --allow-reserved-package-id，您可以分配属于保留的软件包 ID 范围内的 ID。

此选项只能用于最低 SDK 版本为 26 或更低版本的软件包。

--java directory	指定要在其中生成 R.java 的目录。
--proguard proguard_options	为 ProGuard 规则生成输出文件。
--proguard-conditional-keep-rules	为主 dex 的 ProGuard 规则生成输出文件。
--no-auto-version	停用自动样式和布局 SDK 版本控制。
--no-version-vectors	停用矢量可绘制对象的自动版本控制。 仅当使用矢量可绘制对象库构建 APK 时，才能使用此选项。
--no-version-transitions	停用转换资源的自动版本控制。 仅当使用转换支持库构建 APK 时，才能使用此选项。
--no-resource-deduping	禁止在兼容配置中自动删除具有相同值的重复资源。
--enable-sparse-encoding	允许使用二进制搜索树对稀疏条目进行编码。 这有助于优化 APK 大小，但会降低资源检索性能。
-z	要求对标记为“建议”的字符串进行本地化。
-c config	提供以英文逗号分隔的配置列表。
例如，如果您依赖于支持库（该支持库包含多种语言的翻译），则可以仅针对给定的语言配置（如英语或西班牙语）过滤资源。

您必须使用两个字母的 ISO 639-1 语言代码定义语言配置，后面可选择性地添加两个字母的 ISO 3166-1-alpha-2 区域代码（在区域代码前加上小写的“r”，例如 en-rUS）。

--preferred-density density	允许 AAPT2 选择最相符的密度并移除其他所有密度。
您可以在应用中使用多种像素密度限定符，如 ldpi、hdpi 和 xhdpi。在您指定首选密度后，AAPT2 会选择最相符的密度并将其存储在资源表中，然后移除其他所有密度。

--output-to-dir	将 APK 内容输出到 -o 指定的目录中。
如果您在使用此标记时遇到任何错误，可以通过升级到 Android SDK Build Tools 28.0.0 或更高版本来解决这些问题。

--min-sdk-version min-sdk-version	设置要用于 AndroidManifest.xml 的默认最低 SDK 版本。
--target-sdk-version target-sdk-version	设置要用于 AndroidManifest.xml 的默认目标 SDK 版本。
--version-code version-code	指定没有版本代码时要注入 AndroidManifest.xml 中的版本代码（整数）。
--compile-sdk-version-name compile-sdk-version-name	指定没有版本名称时要注入 AndroidManifest.xml 中的版本名称。
--proto-format	以 Protobuf 格式生成已编译的资源。
适合作为 bundle tool 的输入，用于生成 Android App Bundle。

--non-final-ids	使用非最终资源 ID 生成 R.java（在 kotlinc/javac 编译期间，系统不会内嵌从应用的代码对这些 ID 的引用）。
--emit-ids path	在给定的路径下生成一个文件，该文件包含资源类型的名称及其 ID 映射的列表。它适合与 --stable-ids 搭配使用。
--stable-ids outputfilename.ext	使用通过 --emit-ids 生成的文件，该文件包含资源类型的名称以及为其分配的 ID 的列表。
此选项可以让已分配的 ID 保持稳定，即使您在链接时删除了资源或添加了新资源也是如此。

--custom-package package_name	指定要在其下生成 R.java 的自定义 Java 软件包。
--extra-packages package_name	生成相同的 R.java 文件，但软件包名称不同。
--add-javadoc-annotation annotation	向已生成的所有 Java 类添加 JavaDoc 注释。
--output-text-symbols path	生成包含指定文件中 R 类的资源符号的文本文件。
您必须指定输出文件的路径。

--auto-add-overlay	允许在叠加层中添加新资源，而不使用 <add-resource> 标记。
--rename-manifest-package manifest-package	重命名 AndroidManifest.xml 中的软件包。
--rename-instrumentation-target-package instrumentation- target-package	更改插桩的目标软件包的名称。
它应与 --rename-manifest-package 结合使用。

-0 extension
指定您不想压缩的文件的扩展名。

--split path:config[,config[..]]	根据一组配置拆分资源，以生成另一个版本的 APK。
您必须指定输出 APK 的路径和一组配置。

-v	可提高输出的详细程度。
转储
dump 用于输出有关您使用 link 命令生成的 APK 的信息。例如，以下命令的输出结果为所指定 APK 的资源表中的内容：


aapt2 dump resources output.apk
转储语法
使用 dump 的一般语法如下：


aapt2 dump sub-command filename.apk [options]
转储子命令
您需要使用 dump 命令指定以下子命令之一：

子命令	说明
apc	输出在编译期间生成的 AAPT2 容器（APC）的内容。
badging	输出从 APK 的清单中提取的信息。
configurations	输出 APK 中的资源使用的每项配置。
packagename	输出 APK 的软件包名称。
permissions	输出从 APK 的清单提取的权限。
strings	输出 APK 的资源表字符串池的内容。
styleparents	输出 APK 中使用的样式的父项。
resources	输出 APK 的资源表的内容。
xmlstrings	输出 APK 的已编译 xml 中的字符串。
xmltree	输出 APK 的已编译 xml 树。
转储选项
您可以将以下选项与 dump 搭配使用：

选项	说明
--no-values	禁止在显示资源时输出值。
--file file	将文件指定为要从 APK 转储的参数。
-v	提高输出的详细程度。

adb shell am start -n "com.jdgames.p20n.luobocn/org.cocos2dx.lua.AppActivity" -a android.intent.action.MAIN -c android.intent.category.LAUNCHER
