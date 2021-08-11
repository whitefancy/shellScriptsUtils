网络设置与维护
Ping -c 3 IP地址
Ip -r 查看host上的路由表
1. ifconfig命令
配置网络或显示当前网络接口状态
ifconfig [选项] [interface] [inet|up|down|netmask|adr|broadcast]
// interface：网络接口名 eth0，添加后仅显示指定网卡信息// up：激活一个网络接口// down：关闭一个网络接口// netmask：为一个指定的网络接口指定子网掩码// addr：网络接口指定的IP地址// broadcast： 为指定的接口设置广播地址

选项	说明
-a	显示所有网络接口信息，包括活动与非活动
-s	仅显示每个活动接口摘要信息
-v	如果某个网络接口出现错误，返回错误信息

2. scp命令
secure copy，用于把目录或文件从一个Linux复制到另一个Linux，传输数据采用SSH协议
// 远程复制到本地scp 远程用户名@ip地址:文件绝对路径 本地Linux系统路径// 本地复制到远程scp 本地Linux系统路径 远程用户名@ip地址:远程文件绝对路径名
Windows不能使用scp命令传文件到linux。
3. netstat命令
显示本机网络连接、运行端口和路由表信息
netstat [选项]

选项	说明
-a	显示本机所有连接和监听接口
-n	以网络IP地址形式显示当前建立的有效连接和端口
-r	显示路由表信息
-s	显示按协议的统计信息
-v	显示当前有效连接
-t	显示所有TCP连接
-u	显示所有UDP连接
-c 秒数	每隔几秒刷新一次
-i	显示自动配置接口状态
-l	仅显示连接状态为LISTEN的服务的网络状态
-p	显示连接对应的PID与程序名

4. traceroute命令
显示网络数据包传输到指定主机的路径信息，追踪数据传输路由状况，预设数据包大小为38字节
traceroute [选项] [远程主机名或IP地址] [数据包大小]

选项	说明
-i 网络接口	使用指定的网络接口发送数据包
-n	直接使用IP地址而不是用主机名
-v	详细显示命令的执行过程
-w 超时描述	设置等待远程主机回应的时间
-x	开启或关闭对数据包的正确检验
-s 源IP	设置本地主机发送数据包的IP地址
-g 网关地址	设置来源的路由王冠，最多8个

5. telnet命令
通过telnet协议与远程主机通信或获得远程主机对应端口信息
telnet 主机名或IP地址 端口
6. wget命令
下载
wget [要下载软件网址]
curl
不带有任何参数时，curl 就是发出 GET 请求。
$ curl https://www.example.com
上面命令向www.example.com发出 GET 请求，服务器返回的内容会在命令行输出。
-A
-A参数指定客户端的用户代理标头，即User-Agent。curl 的默认用户代理字符串是curl/[version]。
$ curl -A 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.100 Safari/537.36' https://google.com
上面命令将User-Agent改成 Chrome 浏览器。
$ curl -A '' https://google.com
上面命令会移除User-Agent标头。
也可以通过-H参数直接指定标头，更改User-Agent。
$ curl -H 'User-Agent: php/1.0' https://google.com
-b
-b参数用来向服务器发送 Cookie。
$ curl -b 'foo=bar' https://google.com
上面命令会生成一个标头Cookie: foo=bar，向服务器发送一个名为foo、值为bar的 Cookie。
$ curl -b 'foo1=bar;foo2=bar2' https://google.com
上面命令发送两个 Cookie。
$ curl -b cookies.txt https://www.google.com
上面命令读取本地文件cookies.txt，里面是服务器设置的 Cookie（参见-c参数），将其发送到服务器。
-c
-c参数将服务器设置的 Cookie 写入一个文件。
$ curl -c cookies.txt https://www.google.com
上面命令将服务器的 HTTP 回应所设置 Cookie 写入文本文件cookies.txt。
-d
-d参数用于发送 POST 请求的数据体。
$ curl -d'login=emma＆password=123'-X POST https://google.com/login
# 或者
$ curl -d 'login=emma' -d 'password=123' -X POST https://google.com/login
使用-d参数以后，HTTP 请求会自动加上标头Content-Type : application/x-www-form-urlencoded。并且会自动将请求转为 POST 方法，因此可以省略-X POST。
-d参数可以读取本地文本文件的数据，向服务器发送。
$ curl -d '@data.txt' https://google.com/login
上面命令读取data.txt文件的内容，作为数据体向服务器发送。
--data-urlencode
--data-urlencode参数等同于-d，发送 POST 请求的数据体，区别在于会自动将发送的数据进行 URL 编码。
$ curl --data-urlencode 'comment=hello world' https://google.com/login
上面代码中，发送的数据hello world之间有一个空格，需要进行 URL 编码。
-e
-e参数用来设置 HTTP 的标头Referer，表示请求的来源。
curl -e 'https://google.com?q=example' https://www.example.com
上面命令将Referer标头设为https://google.com?q=example。
-H参数可以通过直接添加标头Referer，达到同样效果。
curl -H 'Referer: https://google.com?q=example' https://www.example.com
-F
-F参数用来向服务器上传二进制文件。
$ curl -F 'file=@photo.png' https://google.com/profile
上面命令会给 HTTP 请求加上标头Content-Type: multipart/form-data，然后将文件photo.png作为file字段上传。
-F参数可以指定 MIME 类型。
$ curl -F 'file=@photo.png;type=image/png' https://google.com/profile
上面命令指定 MIME 类型为image/png，否则 curl 会把 MIME 类型设为application/octet-stream。
-F参数也可以指定文件名。
$ curl -F 'file=@photo.png;filename=me.png' https://google.com/profile
上面命令中，原始文件名为photo.png，但是服务器接收到的文件名为me.png。
-G
-G参数用来构造 URL 的查询字符串。
$ curl -G -d 'q=kitties' -d 'count=20' https://google.com/search
上面命令会发出一个 GET 请求，实际请求的 URL 为https://google.com/search?q=kitties&count=20。如果省略--G，会发出一个 POST 请求。
如果数据需要 URL 编码，可以结合--data--urlencode参数。
$ curl -G --data-urlencode 'comment=hello world' https://www.example.com
-H
-H参数添加 HTTP 请求的标头。
$ curl -H 'Accept-Language: en-US' https://google.com
上面命令添加 HTTP 标头Accept-Language: en-US。
$ curl -H 'Accept-Language: en-US' -H 'Secret-Message: xyzzy' https://google.com
上面命令添加两个 HTTP 标头。
$ curl -d '{"login": "emma", "pass": "123"}' -H 'Content-Type: application/json' https://google.com/login
上面命令添加 HTTP 请求的标头是Content-Type: application/json，然后用-d参数发送 JSON 数据。
-i
-i参数打印出服务器回应的 HTTP 标头。
$ curl -i https://www.example.com
上面命令收到服务器回应后，先输出服务器回应的标头，然后空一行，再输出网页的源码。
-I
-I参数向服务器发出 HEAD 请求，然会将服务器返回的 HTTP 标头打印出来。
$ curl -I https://www.example.com
上面命令输出服务器对 HEAD 请求的回应。
--head参数等同于-I。
$ curl --head https://www.example.com
-k
-k参数指定跳过 SSL 检测。
$ curl -k https://www.example.com
上面命令不会检查服务器的 SSL 证书是否正确。
-L
-L参数会让 HTTP 请求跟随服务器的重定向。curl 默认不跟随重定向。
$ curl -L -d 'tweet=hi' https://api.twitter.com/tweet
--limit-rate
--limit-rate用来限制 HTTP 请求和回应的带宽，模拟慢网速的环境。
$ curl --limit-rate 200k https://google.com
上面命令将带宽限制在每秒 200K 字节。
-o
-o参数将服务器的回应保存成文件，等同于wget命令。
$ curl -o example.html https://www.example.com
上面命令将www.example.com保存成example.html。
-O
-O参数将服务器回应保存成文件，并将 URL 的最后部分当作文件名。
$ curl -O https://www.example.com/foo/bar.html
上面命令将服务器回应保存成文件，文件名为bar.html。
-s
-s参数将不输出错误和进度信息。
$ curl -s https://www.example.com
上面命令一旦发生错误，不会显示错误信息。不发生错误的话，会正常显示运行结果。
如果想让 curl 不产生任何输出，可以使用下面的命令。
$ curl -s -o /dev/null https://google.com
-S
-S参数指定只输出错误信息，通常与-s一起使用。
$ curl -s -o /dev/null https://google.com
上面命令没有任何输出，除非发生错误。
-u
-u参数用来设置服务器认证的用户名和密码。
$ curl -u 'bob:12345' https://google.com/login
上面命令设置用户名为bob，密码为12345，然后将其转为 HTTP 标头Authorization: Basic Ym9iOjEyMzQ1。
curl 能够识别 URL 里面的用户名和密码。
$ curl https://bob:12345@google.com/login
上面命令能够识别 URL 里面的用户名和密码，将其转为上个例子里面的 HTTP 标头。
$ curl -u 'bob' https://google.com/login
上面命令只设置了用户名，执行后，curl 会提示用户输入密码。
-v
-v参数输出通信的整个过程，用于调试。
$ curl -v https://www.example.com
--trace参数也可以用于调试，还会输出原始的二进制数据。
$ curl --trace - https://www.example.com
-x
-x参数指定 HTTP 请求的代理。
$ curl -x socks5://james:cats@myproxy.com:8080 https://www.example.com
上面命令指定 HTTP 请求通过myproxy.com:8080的 socks5 代理发出。
如果没有指定代理协议，默认为 HTTP。
$ curl -x james:cats@myproxy.com:8080 https://www.example.com
上面命令中，请求的代理使用 HTTP 协议。
-X
-X参数指定 HTTP 请求的方法。
$ curl -X POST https://www.example.com
上面命令对https://www.example.com发出 POST 请求。
-A/--user-agent <string> 设置用户代理发送给服务器
-b/--cookie <name=string/file> cookie字符串或文件读取位置
-c/--cookie-jar <file> 操作结束后把cookie写入到这个文件中
-C/--continue-at <offset> 断点续转
-D/--dump-header <file> 把header信息写入到该文件中
-e/--referer 来源网址
-f/--fail 连接失败时不显示http错误
-o/--output 把输出写到该文件中
-O/--remote-name 把输出写到该文件中，保留远程文件的文件名
-r/--range <range> 检索来自HTTP/1.1或FTP服务器字节范围
-s/--silent 静音模式。不输出任何东西
-T/--upload-file <file> 上传文件
-u/--user <user[:password]> 设置服务器的用户和密码
-w/--write-out [format] 什么输出完成后
-x/--proxy <host[:port]> 在给定的端口上使用HTTP代理
-#/--progress-bar 进度条显示当前的传送状态
-a/--append 上传文件时，附加到目标文件
--anyauth 可以使用“任何”身份验证方法
--basic 使用HTTP基本验证
-B/--use-ascii 使用ASCII文本传输
-d/--data <data> HTTP POST方式传送数据
--data-ascii <data> 以ascii的方式post数据
--data-binary <data> 以二进制的方式post数据
--negotiate 使用HTTP身份验证
--digest 使用数字身份验证
--disable-eprt 禁止使用EPRT或LPRT
--disable-epsv 禁止使用EPSV
--egd-file <file> 为随机数据(SSL)设置EGD socket路径
--tcp-nodelay 使用TCP_NODELAY选项
-E/--cert <cert[:passwd]> 客户端证书文件和密码 (SSL)
--cert-type <type> 证书文件类型 (DER/PEM/ENG) (SSL)
--key <key> 私钥文件名 (SSL)
--key-type <type> 私钥文件类型 (DER/PEM/ENG) (SSL)
--pass <pass> 私钥密码 (SSL)
--engine <eng> 加密引擎使用 (SSL). "--engine list" for list
--cacert <file> CA证书 (SSL)
--capath <directory> CA目 (made using c_rehash) to verify peer against (SSL)
--ciphers <list> SSL密码
--compressed 要求返回是压缩的形势 (using deflate or gzip)
--connect-timeout <seconds> 设置最大请求时间
--create-dirs 建立本地目录的目录层次结构
--crlf 上传是把LF转变成CRLF
--ftp-create-dirs 如果远程目录不存在，创建远程目录
--ftp-method [multicwd/nocwd/singlecwd] 控制CWD的使用
--ftp-pasv 使用 PASV/EPSV 代替端口
--ftp-skip-pasv-ip 使用PASV的时候,忽略该IP地址
--ftp-ssl 尝试用 SSL/TLS 来进行ftp数据传输
--ftp-ssl-reqd 要求用 SSL/TLS 来进行ftp数据传输
-F/--form <name=content> 模拟http表单提交数据
-form-string <name=string> 模拟http表单提交数据
-g/--globoff 禁用网址序列和范围使用{}和[]
-G/--get 以get的方式来发送数据
-h/--help 帮助
-H/--header <line> 自定义头信息传递给服务器
--ignore-content-length 忽略的HTTP头信息的长度
-i/--include 输出时包括protocol头信息
-I/--head 只显示文档信息
-j/--junk-session-cookies 读取文件时忽略session cookie
--interface <interface> 使用指定网络接口/地址
--krb4 <level> 使用指定安全级别的krb4
-k/--insecure 允许不使用证书到SSL站点
-K/--config 指定的配置文件读取
-l/--list-only 列出ftp目录下的文件名称
--limit-rate <rate> 设置传输速度
--local-port<NUM> 强制使用本地端口号
-m/--max-time <seconds> 设置最大传输时间
--max-redirs <num> 设置最大读取的目录数
--max-filesize <bytes> 设置最大下载的文件总量
-M/--manual 显示全手动
-n/--netrc 从netrc文件中读取用户名和密码
--netrc-optional 使用 .netrc 或者 URL来覆盖-n
--ntlm 使用 HTTP NTLM 身份验证
-N/--no-buffer 禁用缓冲输出
-p/--proxytunnel 使用HTTP代理
--proxy-anyauth 选择任一代理身份验证方法
--proxy-basic 在代理上使用基本身份验证
--proxy-digest 在代理上使用数字身份验证
--proxy-ntlm 在代理上使用ntlm身份验证
-P/--ftp-port <address> 使用端口地址，而不是使用PASV
-Q/--quote <cmd> 文件传输前，发送命令到服务器
--range-file 读取（SSL）的随机文件
-R/--remote-time 在本地生成文件时，保留远程文件时间
--retry <num> 传输出现问题时，重试的次数
--retry-delay <seconds> 传输出现问题时，设置重试间隔时间
--retry-max-time <seconds> 传输出现问题时，设置最大重试时间
-S/--show-error 显示错误
--socks4 <host[:port]> 用socks4代理给定主机和端口
--socks5 <host[:port]> 用socks5代理给定主机和端口
-t/--telnet-option <OPT=val> Telnet选项设置
--trace <file> 对指定文件进行debug
--trace-ascii <file> Like --跟踪但没有hex输出
--trace-time 跟踪/详细输出时，添加时间戳
--url <URL> Spet URL to work with
-U/--proxy-user <user[:password]> 设置代理用户名和密码
-V/--version 显示版本信息
-X/--request <command> 指定什么命令
-y/--speed-time 放弃限速所要的时间。默认为30
-Y/--speed-limit 停止传输速度的限制，速度时间'秒
-z/--time-cond 传送时间设置
-0/--http1.0 使用HTTP 1.0
-1/--tlsv1 使用TLSv1（SSL）
-2/--sslv2 使用SSLv2的（SSL）
-3/--sslv3 使用的SSLv3（SSL）
--3p-quote like -Q for the source URL for 3rd party transfer
--3p-url 使用url，进行第三方传送
--3p-user 使用用户名和密码，进行第三方传送
-4/--ipv4 使用IP4
-6/--ipv6 使用IP6