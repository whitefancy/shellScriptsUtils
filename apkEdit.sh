cd /Users/jedigame/Documents/stories/d0928huchiPackage/retry
apktool d -o baseSource vivo-a20-release.apk --only-main-classes
apktool d -o preSource "育龙_huawei(3).apk" --only-main-classes
apktool d -o channelSource xiaomi-a20-release.apk --only-main-classes
python3 /Users/jedigame/PycharmProjects/NLPDemos/AndroidRecompile/xmlRead.py
zip -1 -r -q base.zip baseSource
zip -1 -r -q channel.zip channelSource

#todo 文件处理

unzip modifySource.zip -d modifySource
#重新编译
apktool b apks/untar_source -o newAPP.apk

#重新签名
jarsigner -verbose -keystore keys/jedi.jks -storepass jedigame -signedjar signedAPP.apk newAPP.apk forever
#重新对齐
zipalign -v 4 signedAPP.apk alignedAPP.apk

adb install alignedAPP.apk

#解包
apktool d -o baseSource vivo-a20-release.apk --only-main-classes
#todo 替换 assets目录和 libs下的内容
#重新编译
apktool b modifySource -o newAPP.apk

#重新签名
jarsigner -verbose \
-keystore /Users/jedigame/Documents/stories/d0928huchiPackage/compare_channel/jedi.jks \
-storepass jedigame \
-signedjar signedAPP.apk \
/Users/jedigame/Documents/stories/d0928huchiPackage/compare_channel/newFile.apk forever

#重新对齐
zipalign -v 4 signedAPP.apk alignedAPP.apk
#安装测试
adb install alignedAPP.apk