#!/bin/bash
while getopts :a:b:c:d opts
do
    case "$opts" in
        a) aaaa=$OPTARG ;;
        b) b=$OPTARG ;;
        c) c=$OPTARG ;;
        d) d=$OPTARG ;;
        ?) ;;
    esac
done

echo "a=$aaaa"
echo "b=$b"
echo "c=$c"
echo "d=$d"

exit 0


#./getopts_sample.sh -a 1 -b 2 -c
# /bin/bash getopts_sample.sh -a /Users/jedigame/github/dockerBasicPlatform -b /Users/jedigame/github/shellScriptsUtils/loglist.txt -c /Users/jedigame/github/shellScriptsUtils/log_1.txt