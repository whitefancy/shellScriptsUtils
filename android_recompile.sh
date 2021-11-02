apktool d -f -o baseSource p20_huchi.apk --only-main-classes
apktool d -f -o channelSource cabbagesdkmodule-oppo-20210922-渠道.apk

删除母包的channel相关的代码资源
rm -f baseSource/smali/channel/*
rm -f baseSource/smali/huchi/*
rm -f baseSource/res/huchi_*

modify baseSource/ 这些xml中与出包相关的元素，找到根结点，如果有子节点的名称能对的上，就把这个元素删除。
因为这些元素要么是白菜的母包sdk添加的，要么就是要按照渠道新增新的节点的。
元素如下：
res/values/attrs.xml
    'attr' => [
        'name' => 'name',
        'values' => [
        ],
    ]
res/values/colors.xml
    'color' => [
        'name' => 'name',
        'values' => [
//            'jd_black',
//            'jd_black1',
//            'jd_black2',
//            'jd_blue',
//            'jd_gray1',
//            'jd_gray2',
//            'jd_purple',
//            'jd_red',
//            'jd_transparent',
//            'jd_white',
//            'jd_white1',
            'mango_sdk_color_white_80',
        ],
    ]
res/values/dimens.xml
    'dimen' => [
        'name' => 'name',
        'values' => [
            'mango_sdk_dp_10',
            'mango_sdk_dp_15',
            'mango_sdk_dp_5',
        ],
    ],
res/values/ids.xml
 'item' => [
        'name' => 'name',
        'values' => [
            'huchi_*',
        ],
    ],
res/values/public.xml
public' => [
        'name' => 'name',
        'values' => [
//            'jd_style_webview_bg',
            'huchi_*',
                        'Theme.myTranslucent',
            'buttonBarStyle',
            'buttonBarButtonStyle',
            'icon',
            'mango_sdk_*',
            'tipTextView',
            'progressBar1',
            'btnQuickRegister',
            'btnLogin',
            'btnListAccount',
//            'jd_btnBack',
            'textViewRealVerify',
            'btnQuickLogin',
            'btnSignLogin',
            'imageView5',
            'textView10',
//            'jd_editTextPwd1',
//            'jd_editTextPwd2',
//            'jd_btnChangePwd',
//            'jd_web_view',
//            'jd_btnRegist',
//            'jd_agreement',
//            'jd_checkBoxUserAgree',
            'fullscreen_content',
            'btnStart',
            'btnLogout',
            'btnPay',
            'btnEnterGame',
            'btnPaySuccess',
            'btnAddLink',
//            'jd_list_settings',
//            'jd_textview_1',
//            'jd_editTextOldPwd',
            'imageView8',
            'relativeLayout1',
            'imageView1',
            'imageView2',
            'textView1',
            'scrollView1',
//            'jd_webView1',
//            'jd_btnClose',
            'imageView3',
            'imageView4',
//            'jd_product_name',
//            'jd_editTextPhoneNumber',
//            'jd_editTextVerifyCode',
            'textView3',
//            'jd_btnBindPhone',
            'textView4',
//            'jd_btnGetVerifyCode',
//            'jd_editTextAccount',
            'textViewForgetPwd',
            'textView5',
            'btnClose',
//            'jd_layout_account',
//            'jd_text_account',
//            'jd_text_gamename',
//            'jd_text_safelevel',
            'textView2',
            ]
            等等

res/values/strings.xml
    'string' => [
        'name' => 'name',
        'values' => []]

res/values/styles.xml
    'style' => [
        'name' => 'name',
        'values' => [
            'Theme.myTranslucent',
            'cbg_sdk_dialog',
//            'jd_bg_bg3',
//            'jd_bg_cbox',
//            'jd_bg_content',
//            'jd_bg_title',
//            'jd_bg_title_yellow',
//            'jd_font_gray1',
//            'jd_font_gray2',
//            'jd_font_hint_gray2',
//            'jd_loading_dialog',
//            'jd_style_btn1',
//            'jd_style_btn2',
//            'jd_style_btn3',
//            'jd_style_btn4',
//            'jd_style_btn5',
//            'jd_style_btn6',
//            'jd_style_btn7',
//            'jd_style_content',
//            'jd_style_label1',
//            'jd_style_label2',
//            'jd_style_title',
            'mango_sdk_dialog',
//            'jd_style_webview_bg',
//            'jd_dialog_anim',
            'huchi_dialog',
            'huchi_loading_dialog',
            'huchi_sdk_dialog',
            'huchi_style_webview_bg',
            'huchi_ui_doalog',
        ],
AndroidManifest.xml
    'activity' => [
        'name' => 'android:name',
        'values' => [
            'huchi.whitefancy.platform.HuChiStartActivity',
            'huchi.whitefancy.platform.HuChiActivityLogin',
            'huchi.whitefancy.platform.HuChiActivityRegist',
            'huchi.whitefancy.platform.HuChiActivityPreLogin',
            'huchi.whitefancy.platform.HuChiActivityBindPhone',
            'huchi.whitefancy.platform.HuChiActivityFindPwd',
            'huchi.whitefancy.platform.HuChiActivityNewPwd',
            'huchi.whitefancy.platform.HuChiActivityAgreement',
            'huchi.whitefancy.platform.HuChiActivityUserChangePwd',
            'huchi.whitefancy.platform.HuChiActivityUserUnbindPhone',
            'huchi.whitefancy.platform.HuChiActivityUserPayLog',
            'huchi.whitefancy.platform.HuChiActivityGmCenter',
            'huchi.whitefancy.platform.HuChiActivityGmQuestion',
            'huchi.whitefancy.platform.HuChiActivityGmFeedback',
            'huchi.whitefancy.platform.HuChiActivityGmMyQuestion',
            'huchi.whitefancy.platform.HuChiActivityUserForum',
            'huchi.whitefancy.platform.HuChiActivityRealVerify',
            'huchi.whitefancy.platform.HuChiWebView',
            'huchi.whitefancy.platform.HuChiActivityUserCenter',
            'huchi.whitefancy.platform.HuChiActivityWeb',
            'huchi.whitefancy.platform.HuChiActivityAgreement',
            'huchi.whitefancy.platform.HuChiWebView',
            'huchi.whitefancy.platform.HuChiActivityWeb',
            'huchi.whitefancy.platform.HuChiNotice',
            'com.unicom.xiaowo.account.shield.LoginActivity',
            'com.cmic.sso.sdk.activity.OAuthActivity',
            'com.cmic.sso.sdk.activity.LoginAuthActivity',
            'cn.com.chinatelecom.account.sdk.ui.AuthActivity',
            'cn.com.chinatelecom.account.sdk.ui.PrivacyWebviewActivity',
        ],
    ],
    'meta-data' => [
        'name' => 'android:name',
        'values' => [
            'TD_APP_ID',
            'HUCHI_PACKAGE_ID',
            'HUCHI_APPKEY',
            'HUCHI_GAME_ID',
        ],
    ]

cp -r channelSource/* baseSource

add nodes form channelSource to baseSource res

add channelSource的 manifest的appname和uses-permission 到 baseSource
对于 channelSource的 manifest 如果 指定标签中 有跟 baseSource相同的标签，则直接用它的值覆盖 baseSource中的内容。
替换AndroidManifest.xml中的包名 //因为现在的包里已经没有了applicationId之类的东西，所以都要自己替换

/smali/jedi/cabbagesdk/module 这里整个目录都要换掉，因为很多依赖冲突之类的解决，导致代码有很多细微差异
更改图标路径为@drawable/cabbage_app_icon
并且新增这个文件/res/drawable/cabbage_app_icon.png
闪屏要放在这个目录下，/res/raw 这样调用
根据 android:label 找到res下的string中的游戏名标签，修改游戏名

重新编译
apktool b baseSource -o newFile.apk

重新签名
jarsigner -verbose -keystore jedi.jks -storepass jedigame -signedjar newFile.apk signedNewFile.apk forever

重新对齐
zipalign -v 4 signedNewFile.apk alignedSignedNewFile.apk

unzip apk files
unzip xxx.apk -d xxx

A directory xxx will be generated to store unzipped files. Actually, .apk files are same as .zip files.
Execute command file XXX.apk to see that.

从 apk 获取可读的文本文件
如果您想要可读的文本文件，例如清单文件，我建议您使用apktool。我们可以使用Homebrew轻松安装 apktool ：

brew install apktool
然后获取可读的文本文件：

apktool d xxx.apk
在上一个命令之后，一个 xxx 目录包含可读的文本文件，其他文件将在那里。

