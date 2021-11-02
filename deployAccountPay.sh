# todo 上传svn上最新下载的代码
cd ~
unzip accountpay.zip -d accountpay
cd accountpay
# 部署数据库文件 accountpay2.sql
mysql -h host -P port_number -u username -p password <accountpay2.sql
# 创建日志目录并给全部的权限，否则php无法正常读写
sudo mkdir /data/jedi_log/accountservice
sudo chmod 777 /data/jedi_log/accountservice
# todo  修改 配置
vim accountpay/config/config.php
# 1 修改 数据库地址、数据库用户名和数据库密码 2 修改平台名等

#部署到www下
sudo mkdir /www/accountpay
sudo mv accountpay/* /www/accountpay

#访问测试