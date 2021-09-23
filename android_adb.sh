adb install ~/Downloads/p.apk

adb install ~/Downloads/P21_googleplay_2.46.7.\[409091639\]_release.apk

adb shell setprop log.tag.FA VERBOSE
adb shell setprop log.tag.FA-SVC VERBOSE
adb logcat -v time -s FA FA-SVC

