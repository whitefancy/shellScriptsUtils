export LANG=C.UTF-8
echo "从svn更新打包代码"
Uname=najinlong
Upassword=njlthd23
sourcePath="svn://192.168.0.220/project9/运维/【SAD】产品渠道支持开发/国内渠道接入/client/AndroidIntegration/${platformScmPath}"
if [ -d ${WORKSPACE}/${scmPath} ]; then
  svn cleanup .
  svn switch ${sourcePath} . --username ${Uname} --password ${Upassword} >> /dev/null 2>&1
else
  svn co ${sourcePath} . --username ${Uname} --password ${Upassword} >> /dev/null 2>&1
fi

#解压资源
rm -r ${WORKSPACE}/result
mkdir ${WORKSPACE}/result
unzip ${WORKSPACE}/../Jenkins/${assets_filename}.apk -d ${WORKSPACE}/result >> /dev/null 2>&1

package_filename="package_${project}_${platform}_${gameVersion}_${ts}"

# 调用 打包脚本
sh ${WORKSPACE}/package/ziruScript/androidBuild.sh ${project} ${channel} ${gameVersion} ${localSubversion} ${p31_source_version} ${isTest}
cp ${WORKSPACE}/package/release/*.apk ${WORKSPACE}/result
