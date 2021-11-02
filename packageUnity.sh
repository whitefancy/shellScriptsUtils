export LANG=C.UTF-8


rm -r ${WORKSPACE}/result
mkdir ${WORKSPACE}/result
#touch ${WORKSPACE}/result/build.log
echo "打包的目标输出路径"
echo "使用的全部配置变量如下："
echo  "WORKSPACE=${WORKSPACE}"
echo  "scmPath=${scmPath}"
echo  "platform=${platform}"
echo  "channel=${channel}"
echo  "isHotpatch=${isHotpatch}"
echo  "gameVersion=${gameVersion}"
echo  "BUILD_NUMBER=${BUILD_NUMBER}"
echo "通过svn更新资源目录："
cd ${WORKSPACE}/${scmPath}
Uname=jenkins
Upassword=xgd5Xs9Q
if [ -d ${WORKSPACE}/${scmPath} ]; then
    echo "清理目录"
    svn cleanup .
    svn update . --username ${Uname} --password ${Upassword} >> /dev/null 2>&1
else
    svn co svn://192.168.0.220/projectx/d3/devel/${scmPath} --username ${Uname} --password ${Upassword} >> /dev/null 2>&1
fi


svnVersion=`svn info  ${WORKSPACE}/${scmPath} | grep "最后修改的版本" |grep -o '[0-9]\+'`
echo "显示当前svn版本信息：${svnVersion}"
log_path=${WORKSPACE}/result/${project}_Build${svnVersion}.log
echo "日志路径：${log_path}"

unitypath=/Applications/Unity/2020.3.11f1/Unity.app/Contents/MacOS/Unity
echo "unity版本和路径：${unitypath}"
echo "调用unity打包："
${unitypath}  \
-projectPath . \
-logFile ${log_path} \
-quit \
-batchmode \
-executeMethod \
JediEditor.JenkinsBuilder.BuildLocalJenkins \
Version-${gameVersion}_Android_R${svnVersion}_P${BUILD_NUMBER} \
OpenLog-${isTest} \
-buildTarget android

echo "提取资源"
if [ -f "Publish/android.apk" ]; then
  mv Publish/android.apk ${WORKSPACE}/result/
fi
if [ -d "PersistentDataSim/Hotfix" ]; then
  mv PersistentDataSim/Hotfix ${WORKSPACE}/result
fi

