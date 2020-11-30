#!/bin/bash
# 声明文件到执行者 必须在文件到第一行，注释也不能在前面

# # 对日志文件夹所有的文件做遍历
# 找到所有的tail文本
# 在文本中找 2020 的关键字
# 如果找到了，就把文本和文件名都输出到文件里。
# 并另外把文件名输出一份
# 使用getopts 从输入参数中读取配置 参数list=【日志文件夹，目标日志list，目标文件list】
# -f -t -c
# /bin/bash 2020logFiles.sh -log_folder /www/p16s/p16s_pay/log -log_titles /home/buwenfeng/loglist.txt -log_contents /home/buwenfeng/target_test1.txt
# /bin/bash logFiles2ways.sh -f /Users/jedigame/github/dockerBasicPlatform -t /Users/jedigame/github/shellScriptsUtils/loglist.txt -c /Users/jedigame/github/shellScriptsUtils/log_1.txt
# # /bin/bash 2020logFiles.sh -f /www/p20gate/pay/log -t ~/loglist.txt -c ~/log_1.txt -l ~/loglist.txt
#/bin/bash logFiles2ways.sh -f /Users/jedigame/github/dockerBasicPlatform -t /Users/jedigame/github/shellScriptsUtils/loglist.txt -c /Users/jedigame/github/shellScriptsUtils/log_1.txt

#如果参数不存在，则会报错
while getopts ':f:t:c:l:' opts
do
  case "$opts" in
    f) folder_path=$OPTARG ;;
    t) target_file1=$OPTARG ;;
    c) target_file=$OPTARG ;;
    l) list_file=$OPTARG ;;
    ?) ;;#过滤未知参数
  esac
done
echo "$target_file"
echo "$target_file1"
echo "$folder_path"
# 判断文件是否存在，不存在则创建
if [ ! -f "$target_file1" ]; then
  touch "$target_file1"
fi

if [ ! -f "$target_file" ]; then
  touch "$target_file"
fi

#创建临时保存日志到数组 A 日志文件名  B 日志末尾几行
A=(none)
B=(none)
index=0;
# 使用带参数的函数来减少重复代码
function checklog() {
  line=$1
  strB="2020"
  A=$2
  B=$3
    #判断为文件而不是目录
  if [ -f $line ]
  then
    #将命令结果赋值给变量
    log=$(tail $line)
    #利用grep判断这段文本是否包含字符串2020
    result=$(echo $log | grep "${strB}")
    #if-else条件语句
    if [[ "$result" != "" ]]
    then
      title=$line
      #数组元素赋值
      A[$index]=$title
      B[$index]=$log
      index=$index+1
    fi
  fi
}
cd $folder_path
#判断变量是否赋值
if [ -n "$list_file" ];then
  # 遍历文件中每一行
  echo "read file from filelist"
  while  read line ; do
    checklog $line $A $B 
  done < $list_file
else
  echo "find file from folder"
  # for 遍历目录下所有文件名
  for line in $(ls "$folder_path") ; do
    checklog $line $A $B
  done
fi

#获取数组长度
len=${#A[*]}
echo $len
echo "$target_file"
#for循环 在条件中，引用变量一定要用双引号
for((j=0;j<"$len";j=j+1))
do
  #将内容以追加到方式输出到文件
  echo ${A[$j]}>>$target_file
  echo ${A[$j]}>>$target_file1
  echo ${B[$j]}>>$target_file
done