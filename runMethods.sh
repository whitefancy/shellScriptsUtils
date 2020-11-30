#bash script-name 或者 sh script-name
#path/script-name 或者 ./script-name(当前路径下执行)
#source script-name 或 . script-name（注意符号“.”与 script-name之间有空格）
#第一种方法是脚本文件本身没有可执行权限时，通常使用的方法；
#
#第二种方法需要先将脚本文件的权限改为可执行，然后通过脚本路径就可以直接执行；
#
#第三中方法是在当前shell环境中直接执行，而不是新创建一个子shell，当我们需要在一个脚本中使用另一个脚本中的变量的时候就使用第三种方法，