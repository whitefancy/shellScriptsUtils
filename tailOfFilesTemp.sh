folder_path="/Users/jedigame/github/dockerBasicPlatform"
file_list="/Users/jedigame/github/shellScriptsUtils/target_list.txt"
ls $folder_path/*.yaml > $file_list
target_file="/Users/jedigame/github/shellScriptsUtils/target_test1.txt"
cd $folder_path
# while 循环 对文件到每一行循环
while  read line ; do
  #将内容以追加到方式输出到文件
    echo $line >>$target_file
    echo "\n" >>$target_file
    tail $line >>$target_file
done < $file_list