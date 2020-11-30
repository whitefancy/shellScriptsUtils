list_file="/Users/jedigame/github/shellScriptsUtils/loglist.txt"
folder_path="/Users/jedigame/github/dockerBasicPlatform"

#使用函数调用
function echolines() {
  line=$1
  target_file=$2
  target_file1=$3
    echo $line >>$target_file
    echo "\n" >>$target_file
    tail $line >>$target_file
}

#判断变量是否赋值
if [ -n "$list_file" ];then
  # 将文件中每一行取出来，保存成数组
  echo "read file from filelist"
  while  read line ; do
    echo $line >>$target_file
    echo "\n" >>$target_file
    tail $line >>$target_file
  done < $list_file
else
  # 将ls的输出保存为数组
  index=0
  echo "find file from folder"
  for line in $(ls "$folder_path") ; do
    log_file_list[$index]="$line"
    ((index++))
  done
fi

echo $log_file_list

# 遍历数组
for ele in ${log_file_list[@]};
do
  echo $ele
done

