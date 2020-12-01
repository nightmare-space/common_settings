import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:common_settings/src/custom_route.dart';
import 'package:common_settings/src/public_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'wifi_password.dart';
import 'package:global_repository/global_repository.dart';

//实用工具页面，工具箱主页面的第一页
class PracticalTool extends StatefulWidget {
  @override
  _PracticalToolState createState() => _PracticalToolState();
}

class _PracticalToolState extends State<PracticalTool>
    with TickerProviderStateMixin {
  AnimationController opacityController; //透明度控制器
  Animation<double> opacity; //透明度动画补间值
  AnimationController paddingController; //边距动画控制器
  bool hasBackup = false;
  Animation<double> tweenPadding; //边距动画补间值
  String _deviceIp = ''; //设备IP地址
  bool breventExist = false; //是否开启黑域
  @override
  void initState() {
    super.initState();
    opacityAnimationInit();
    paddingAniamtionInit();
    adbAndBreventStatCheck();
    getWlanIp();
    checkBackup();
  }

  void opacityAnimationInit() {
    //透明度动画的一系列初始化
    opacityController = AnimationController(
        duration: const Duration(milliseconds: 1600),
        vsync: this); //初始化AnimationController
    final Animation<double> curvedAnimationrve =
        CurvedAnimation(parent: opacityController, curve: Curves.ease); //减速曲线动画
    opacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curvedAnimationrve);
    opacity.addListener(() {
      setState(() {});
    });
    opacityController.forward();
  }

  void paddingAniamtionInit() {
    //边距动画
    paddingController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    final Animation<double> curvedAnimation =
        CurvedAnimation(parent: paddingController, curve: Curves.ease);
    tweenPadding = Tween<double>(
      begin: 0,
      end: -600.0 * 2.75 / window.devicePixelRatio,
    ).animate(curvedAnimation);
    tweenPadding.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    //动画控制器需要回收内存
    opacityController.dispose();
    paddingController.dispose();
    super.dispose();
  }

  void updateWidget() {
    //刷新widget的快捷方法
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> adbAndBreventStatCheck() async {
    //检查设备是否开启ADB调试
    if (File('/system/app/Brevent/Brevent.apk').existsSync()) {
      breventExist = true;
    }

    updateWidget();
  }

  Future<void> getWlanIp() async {
    //获取wifi的ip地址
    final RegExp _regexp =
        RegExp('inet addr:.*[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}');
    final String str = await NiProcess.exec('ifconfig wlan0');
    // print('str====>$str');
    if (str.isNotEmpty) {
      if (_regexp.hasMatch(str)) {
        _deviceIp = _regexp
            .allMatches(str)
            .elementAt(0)
            .group(0)
            .replaceAll(RegExp('inet addr:| .*'), '');
      }
    }
    if (_deviceIp == '') {
      final String str = await NiProcess.exec('ifconfig wlan1');
      // print('str====>$str');
      if (str.isNotEmpty) {
        if (_regexp.hasMatch(str)) {
          _deviceIp = _regexp
              .allMatches(str)
              .elementAt(0)
              .group(0)
              .replaceAll(RegExp('inet addr:| .*'), '');
        }
      }
    }
    updateWidget();
  }

  Future<void> checkBackup() async {
    //检测是否存在动画的备份
    // if (File(
    //         '${PlatformUtil.documentsDir}/${Config.backupPath}/bootanimation.zip')
    //     .existsSync()) {
    //   hasBackup = true;
    // }
    // setState(() {});
  }

  Matrix4 matrix4;
  Widget three;
  @override
  Widget build(BuildContext contex) {
    matrix4 = Matrix4.identity()..translate(0.0, tweenPadding.value);
    three = Transform(
      alignment: FractionalOffset.center,
      transform: matrix4,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          // Padding(
          //   padding: movement.value - EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 0.0),
          //   child: Text(
          //     '声音',
          //     style: TextStyle(
          //       color: Color(0x90303030),
          //       fontSize: 14.0,
          //     ),
          //   ),
          // ),
          // Card(
          //   elevation: 1,
          //   child: InkWell(
          //     borderRadius: BorderRadius.circular(4.0),
          //     child: SizedBox(
          //       width: MediaQuery.of(context).size.width,
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: <Widget>[
          //           Padding(
          //             padding: movement.value,
          //             child: Text(
          //               '蝰蛇音效',
          //               style: TextStyle(
          //                 fontSize: 14.0,
          //                 fontWeight: FontWeight.bold,
          //               ),
          //             ),
          //           ),
          //           Padding(
          //             padding: const EdgeInsets.fromLTRB(8.0, 4.0, 0.0, 8.0),
          //             child: Text(
          //               '进入蝰蛇音效设置',
          //               style: TextStyle(
          //                 color: Color(0xff696666),
          //                 fontSize: 12.0,
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //     onTap: () => PlatformChannel.invokeMethod<void>('KuiShe'),
          //   ),
          // ),
          // Card(
          //   elevation: 1,
          //   child: InkWell(
          //     borderRadius: BorderRadius.circular(4.0),
          //     child: SizedBox(
          //       width: MediaQuery.of(context).size.width,
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: <Widget>[
          //           Padding(
          //             padding: movement.value,
          //             child: Text(
          //               '杜比音效',
          //               style: TextStyle(
          //                 fontSize: 14.0,
          //                 fontWeight: FontWeight.bold,
          //               ),
          //             ),
          //           ),
          //           Padding(
          //             padding: const EdgeInsets.fromLTRB(8.0, 4.0, 0.0, 8.0),
          //             child: Text(
          //               '进入杜比音效设置',
          //               style: TextStyle(
          //                 color: Color(0xff696666),
          //                 fontSize: 12.0,
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //     onTap: () => PlatformChannel.invokeMethod<void>('DuBi'),
          //   ),
          // ),

          // Text(
          //   '其他',
          //   style: TextStyle(
          //     color: Color(0x90303030),
          //     fontSize: screen(14),
          //   ),
          // ),

          CardWidget(
            title: 'WIFI密码查看',
            subtitle: '查看已连接的WIFI密码',
            onTap: () async {
              Navigator.of(context).push(CustomRoute(WifiPassword()));
              // if (ToolkitInfo.isRoot) {
              //   await paddingController.forward();
              //   paddingController.reset();
              //   fourthPage = 3;
              // } else {
              //   // showNeedRootToast();
              // }
            },
          ),

          // Card(
          //   elevation: 1,
          //   child: InkWell(
          //     borderRadius: BorderRadius.circular(4.0),
          //     child: SizedBox(
          //       width: MediaQuery.of(context).size.width,
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: <Widget>[
          //           Padding(
          //             padding: movement.value,
          //             child: Text(
          //               '刺激战场修改',
          //               style: TextStyle(
          //                 fontSize: 14.0,
          //                 fontWeight: FontWeight.bold,
          //               ),
          //             ),
          //           ),
          //           Padding(
          //             padding: const EdgeInsets.fromLTRB(8.0, 4.0, 0.0, 8.0),
          //             child: Text(
          //               '修改刺激战场的帧率',
          //               style: TextStyle(
          //                 color: Color(0xff696666),
          //                 fontSize: 12.0,
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //     onTap: () {
          //       setState(() {
          //         fourthPage = 2;
          //       });
          //     },
          //   ),
          // ),
          CardWidget(
            title: '开机动画编辑器',
            subtitle: '可预览的方式替换开机动画',
            onTap: () async {
              // if (ToolkitInfo.isRoot) {
              // Navigator.of(context).push<void>(RippleRoute(
              //     AnimaModify(), RouteConfig.fromContext(context)));
              // } else {
              //   showNeedRootToast();
              // }
            },
          ),

          CardWidget(
            title: '快捷替换开机动画',
            subtitle: '开机第二屏动画',
            subhead: hasBackup ? '已备份至YanTool/Backup' : '使用后自动备份',
            onTap: () async {
              //   if (ToolkitInfo.isRoot) {
              //     final String filePath = await showCustomDialog2<String>(
              //       isPadding: false,
              //       height: 600.0,
              //       child: FMPage(
              //         chooseFile: true,
              //         initpath: '${Global.documentsDir}/YanTool/ROM',
              //         callback: (String str) {
              //           // Navigator.of(globalContext).pop(str);
              //           // fun(str);
              //         },
              //       ),
              //     );
              //     if (filePath == null) {
              //       PlatformChannel.Toast.invokeMethod<void>('你没有选择文件');
              //     } else {
              //       showCustomDialog2<void>(
              //         child: FullHeightListView(
              //           child: ChangeBootAnimation(
              //             filepath: filePath,
              //           ),
              //         ),
              //       );
              //     }
              //   } else {
              //     // showNeedRootToast();
              //   }
            },
          ),

          // CardButton(
          //   relyroot: true,
          //   height: MToolKit.cardheight,
          //   text0: '刷入面具模块',
          //   text1: '供测试',
          //   onTap: () async {
          //     if (toolInfo.isRoot) {
          //       String filepath;

          //       showCustomDialog(
          //           context,
          //           const Duration(milliseconds: 300),
          //           600,
          //           FileManager(
          //             initpath: '/ROM',
          //             callback: (str) {
          //               filepath = str;
          //               Navigator.of(context).pop();
          //               if (filepath != null) {
          //                 showCustomDialog(
          //                     context,
          //                     const Duration(milliseconds: 400),
          //                     500,
          //                     Onemian(
          //                       path: filepath,
          //                     ),
          //                     true);
          //               }
          //             },
          //           ),
          //           true,
          //           false);

          //       // filepath = await FilePicker.getFilePath(
          //       //     type: FileType.CUSTOM, fileExtension: 'zip');

          //     } else {
          //       showNeedRootToast();
          //     }
          //   },
          // ),

          CardWidget(
            title: '打开开发者选项',
            subtitle: '进入开发者选项（无需点击三次系统版本）',
            onTap: () async {
              await NiProcess.exec(
                'settings put global development_settings_enabled 1',
              );
              // TODO跳转到开发者模式
            },
          ),

          CardWidget(
            title: '打开测试模式',
            subtitle: '拨号盘*#*#4636#*#*',
            onTap: () async {
              // TODO跳转到测试模式
            },
          ),

          CardWidget(
            title: '文本自动输入',
            subtitle: '跟粘贴原理不一样，用于一些禁止粘贴的地方',
            onTap: () async {
              final String isexist = await NiProcess.exec(
                  'pm list packages |grep -o com.android.adbkeyboard\$\n'); //检查是否还能找到这个包名
              if (isexist == 'com.android.adbkeyboard') {
                // showCustomDialog2<void>(
                //     context: context,
                //     child: FullHeightListView(
                //       child: TextAutoInput(),
                //     ));
                // showCustomDialog(context, const Duration(milliseconds: 400),
                //     420, TextAutoInput(), true);
              } else {
                // await Clipboard.setData(const ClipboardData(
                //     text:
                //         'https://raw.githubusercontent.com/Nightmare-MYS/master/ADBKeyboard.apk'));
                // PlatformChannel.Toast.invokeMethod<void>(
                //     '未找到辅助软件,已复制下载链接,请下载辅助输入法后像其他输入法一样启用后使用改功能',
                //     <String, dynamic>{'time': ' '});
              }
            },
          ),

          CardWidget(
            title: '任意进制转换',
            subtitle: '实现任意进制的转换',
            onTap: () async {
              updateWidget();
            },
          ),
        ],
      ),
    );

    // if (fourthPage == 1) {
    //   three = WillPopScope(
    //       child: WIFI(),
    //       onWillPop: () async {
    //         setState(() {
    //           fourthPage = 0;
    //         });
    //         return false;
    //       });
    // }
    // if (fourthPage == 2) {
    //   three = WillPopScope(
    //       child: Game(),
    //       onWillPop: () async {
    //         if (game != 0) {
    //           game = 0;
    //         } else {
    //           fourthPage = 0;
    //         }

    //         setState(() {});

    //         return false;
    //       });
    // }

    return FadeTransition(
      opacity: opacity,
      child: three,
    );
  }
}
