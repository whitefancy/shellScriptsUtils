folder_path="/www/p16s/p16s_pay/log"
file_list="/home/buwenfeng/loglist.txt"
#ls $folder_path/*.yaml > $file_list
target_file="/home/buwenfeng/target_test1.txt"
cd $folder_path
while  read line ; do
    echo $line >>$target_file
    echo "\n" >>$target_file
    tail $line >>$target_file
done < $file_list