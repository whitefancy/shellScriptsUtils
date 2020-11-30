folder_path="/Users/jedigame/github/dockerBasicPlatform"
file_list="/Users/jedigame/github/shellScriptsUtils/target_list.txt"
ls $folder_path/*.yaml > $file_list
target_file="/Users/jedigame/github/shellScriptsUtils/target_test1.txt"
cd $folder_path
while  read line ; do
    echo $line >>$target_file
    echo "\n" >>$target_file
    tail $line >>$target_file
done < $file_list