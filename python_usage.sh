Install packages with pip: -r requirements.txt
How to write configuration file requirements.txt
Export current environment configuration file: pip freeze

$ pip install -r requirements.txt

在后台运行 Python 脚本

在后台运行 Python 脚本
首先，您需要在 Python 脚本中添加如下所示的shebang行：

#!/usr/bin/env python3
如果您安装了多个版本的 Python，/usr/bin/env则此路径是必需的，并且将确保采用$$PATH环境变量中的第一个 Python 解释器。您还可以对 Python 解释器的路径进行硬编码（例如#!/usr/bin/python3），但这并不灵活，并且在其他机器上不可移植。接下来，您需要设置文件的权限以允许执行：

chmod +x test.py
现在您可以使用忽略挂断信号的nohup运行脚本。这意味着您可以在不停止执行的情况下关闭终端。另外，不要忘记添加&以便脚本在后台运行：

nohup /path/to/test.py &
如果您没有shebang在文件中添加 a ，则可以使用以下命令运行脚本：

nohup python /path/to/test.py &
输出将保存在nohup.out文件中，除非您在此处指定输出文件：

nohup /path/to/test.py > output.log &
nohup python /path/to/test.py > output.log &