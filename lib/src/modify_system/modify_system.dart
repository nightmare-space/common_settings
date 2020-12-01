import 'dart:io';
import 'dart:ui';
import 'package:common_settings/src/public_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:global_repository/global_repository.dart';

import 'battery_pretend.dart';
import 'model/devices_info.dart';

class ModifySystem extends StatefulWidget {
  @override
  _ModifySystemState createState() => _ModifySystemState();
}

class _ModifySystemState extends State<ModifySystem>
    with TickerProviderStateMixin {
  AnimationController opacityController; //透明度东南规划控制器
  Animation<double> opacityTween; //透明度动画补间值
  AnimationController paddingController; //边距动画控制器
  Animation<double> tweenPadding; //边距动画补间值
  String batteryNumber = ''; //电量的大小
  String batteryState = '当前未充电'; //充电的状态
  String _selinuxState = ''; //Selinux的状态
  String macAddress = ''; //MAC地址

  @override
  void initState() {
    super.initState();
    opacityAnimationInit();
    paddingAniamtionInit();
    getBatteryState();
    getSelinuxState();
    getMacAddress();
    getDeviceDpiSize();
  }

  void paddingAniamtionInit() {
    //边距动画
    paddingController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    final Animation<double> curve =
        CurvedAnimation(parent: paddingController, curve: Curves.ease);
    tweenPadding = Tween<double>(
      begin: 0,
      end: -600.0 * 2.75 / window.devicePixelRatio,
    ).animate(curve);
    tweenPadding.addListener(() {
      setState(() {});
    });
  }

  void opacityAnimationInit() {
    //透明度动画的一系列初始化
    opacityController = AnimationController(
        duration: const Duration(milliseconds: 1600), vsync: this);
    final Animation<double> curve =
        CurvedAnimation(parent: opacityController, curve: Curves.ease);
    opacityTween = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curve);
    opacityTween.addListener(() {
      setState(() {});
    });
    opacityController.forward();
  }

  Future<void> getMacAddress() async {
    //获取Mac地址
    macAddress = await NiProcess.exec('cat /sys/class/net/wlan0/address');
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> getBatteryState() async {
    //获取电池的状态
    final String a = await NiProcess.exec('dumpsys battery');
    for (final String _str in a.split('\n')) {
      if (_str.contains('level'))
        batteryNumber = _str.replaceAll(RegExp(r'.*level:\s{0,}'), '');
      if (_str.contains('AC powered: true') && !a.contains('status: 1'))
        batteryState = '正在进行交流电源充电';
      if (_str.contains('USB powered: true') && !a.contains('status: 1'))
        batteryState = '正在进行USB充电';
      if (_str.contains('Wireless powered: true') && !a.contains('status: 1'))
        batteryState = '正在进行无线充电';
      if (a.contains('status: 1')) {
        batteryState = '当前未充电';
      }
    }
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> getSelinuxState() async {
    //获取Selinux的状态
    _selinuxState = await NiProcess.exec('getenforce');
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    opacityController.dispose();
    super.dispose();
  }

  Future<void> getDeviceDpiSize() async {
    if (!Platform.isAndroid) {
      return;
    }
    final DevicesInfo devicesInfo = DevicesInfo();
    String wmSize = await NiProcess.exec('wm size');
    String wmDensity = await NiProcess.exec('wm density');
    wmDensity = wmDensity.contains('Override')
        ? wmDensity.replaceAll(
            RegExp('Physical density.*|Override density: '), '')
        : wmDensity.replaceAll(RegExp('Physical density: '), '');
    wmSize = wmSize.contains('Override')
        ? wmSize.replaceAll(RegExp('Physical size.*|Override size: '), '')
        : wmSize.replaceAll(RegExp('Physical size: '), '');
    if (wmSize.isNotEmpty) {
      devicesInfo.physicalSize = Size(double.parse(wmSize.split('x')[0]),
          double.parse(wmSize.split('x')[1]));
    }
    devicesInfo.deviceDPI = int.parse(wmDensity);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(0.0),
      physics: const BouncingScrollPhysics(),
      children: <Widget>[
        // CardWidget(
        //   title: '自定义DPI，屏幕分辨率',
        //   subtitle: '当前DPI为：${mToolKitNotifier.devicesInfo.deviceDPI}'
        //       '    当前分辨率为：${mToolKitNotifier.devicesInfo.physicalSize.width}x${mToolKitNotifier.devicesInfo.physicalSize.height}',
        //   onTap: () {
        //     // ToolkitInfo.isRoot
        //     //     ? showCustomDialog2<void>(
        //     //         child: FullHeightListView(
        //     //           child: DpiEdit(
        //     //             dpi: mToolKitNotifier.devicesInfo.deviceDPI,
        //     //             width: mToolKitNotifier.devicesInfo.physicalSize.width
        //     //                 .toInt(),
        //     //             height: mToolKitNotifier.devicesInfo.physicalSize.height
        //     //                 .toInt(),
        //     //             callback: () async {
        //     //               await getDeviceDpiSize();
        //     //               setState(() {});
        //     //             },
        //     //           ),
        //     //         ),
        //     //       )
        //     // : showNeedRootToast();
        //   },
        // ),
        CardWidget(
          title: '电量伪装',
          subtitle: '当前电量为：$batteryNumber' '   $batteryState',
          onTap: () {
            showCustomDialog(
              context: context,
              child: BatteryPretend(),
            );
            // ToolkitInfo.isRoot
            //     ? showCustomDialog(
            //         context, const Duration(milliseconds: 300), 200,
            //         BatteryPretend(
            //         callback: () {
            //           getBatteryState();
            //         },
            //       ), true)
            // : showNeedRootToast();
          },
        ),
        CardWidget(
          title: 'MAC地址更改',
          subtitle: '默认MAC为：' + macAddress,
          onTap: () {
            // ToolkitInfo.isRoot
            //     ? showCustomDialog(
            //         context,
            //         const Duration(milliseconds: 300),
            //         150,
            //         MacAdressEdit(
            //           callback: () {},
            //         ),
            //         true)
            // : showNeedRootToast();
          },
        ),
        // CardWidget(
        //   title: '机型修改',
        //   subtitle: '修改手机型号',
        //   onTap: () {
        //     ToolkitInfo.isRoot
        //         ? Navigator.pushNamed(context, 'ModelChange')
        //         : showNeedRootToast();
        //     setState(() {});
        //   },
        // ),
        CardWidget(
          title: 'Build.prop修改',
          subtitle: '修改位于/system/build.prop',
          onTap: () {
            // ToolkitInfo.isRoot
            //     ? Navigator.pushNamed(context, 'BuildPropEdit')
            //     : showNeedRootToast();
            setState(() {});
          },
        ),
        CardWidget(
          title: '删除电池使用记录',
          subtitle: '清空系统的电池使用记录，需要重启系统',
          onTap: () {
            // showCustomDialog2<void>(
            //   child: FullHeightListView(
            //     child: Column(
            //       children: <Widget>[
            //         const Text(
            //           '删除电池使用记录',
            //           style: TextStyle(fontWeight: FontWeight.bold),
            //         ),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.end,
            //           children: <Widget>[
            //             FlatButton(
            //               child: const Text(
            //                 '取消',
            //                 style: TextStyle(
            //                   fontSize: 14.0,
            //                   fontWeight: FontWeight.bold,
            //                 ),
            //               ),
            //               onPressed: () {
            //                 // Navigator.of(globalContext).pop();
            //               },
            //             ),
            //             FlatButton(
            //               child: const Text(
            //                 '确认',
            //                 style: TextStyle(
            //                   fontSize: 14.0,
            //                   fontWeight: FontWeight.bold,
            //                 ),
            //               ),
            //               onPressed: () {
            //                 NiProcess.exec(
            //                     'rm -f /data/system/batterystats-checkin.bin'
            //                     'rm -f /data/system/batterystats-daily.xml'
            //                     'rm -f /data/system/batterystats.bin'
            //                     'sleep 1');
            //                 NiToast.showToast('手动重启系统生效');
            //                 // Navigator.of(globalContext).pop();
            //               },
            //             ),
            //           ],
            //         )
            //       ],
            //     ),
            //   ),
            // );
            // return showDialog<Null>(
            //   context: context,
            //   barrierDismissible: true, // user must tap button!
            //   builder: (BuildContext context) {
            //     return AlertDialog(
            //       title: Text(
            //         '确认删除吗',
            //         style: TextStyle(
            //           fontSize: 20.0,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //       actions: <Widget>[
            //         FlatButton(
            //           child: Text(
            //             '取消',
            //             style: TextStyle(
            //               fontSize: 14.0,
            //               fontWeight: FontWeight.bold,
            //             ),
            //           ),
            //           onPressed: () {
            //             Navigator.of(context).pop();
            //           },
            //         ),
            //         FlatButton(
            //           child: Text(
            //             '确认',
            //             style: TextStyle(
            //               fontSize: 14.0,
            //               fontWeight: FontWeight.bold,
            //             ),
            //           ),
            //           onPressed: () {
            //             CustomProcess.exec(
            //                 'true',
            //                 'rm -f /data/system/batterystats-checkin.bin' +
            //                     'rm -f /data/system/batterystats-daily.xml' +
            //                     'rm -f /data/system/batterystats.bin' +
            //                     'sleep 1');
            //             PlatformChannel.Toast.invokeMethod<void>('手动重启系统生效');
            //             Navigator.of(context).pop();
            //           },
            //         ),
            //       ],
            //     );
            //   },
            // );
          },
        ),
        CardWidget(
          title: 'RAM内存清理',
          subtitle: '清理RAM',
          onTap: () {
            NiProcess.exec('echo 3 > /proc/sys/vm/drop_caches');
            NiToast.showToast('已清理');
          },
        ),
        CardWidget(
          title: 'Selinux临时开关(当前状态：$_selinuxState)',
          subtitle: '谨慎操作！',
          onTap: () async {
            if (_selinuxState == 'Permissive')
              await NiProcess.exec('setenforce 1');
            else
              await NiProcess.exec('setenforce 0');
            await getSelinuxState();
            setState(() {});
          },
          suffix: Switch(
            value: _selinuxState != 'Permissive',
            onChanged: (bool a) async {
              if (_selinuxState == 'Permissive')
                await NiProcess.exec('setenforce 1');
              else
                await NiProcess.exec('setenforce 0');
              await getSelinuxState();
              setState(() {});
            },
          ),
        ),
        CardWidget(
          title: '过度动画速度修改',
          subtitle: '窗口动画缩放，过度动画缩放，Animator时常速度修改',
          onTap: () async {
            // ToolkitInfo.isRoot
            //     ? showCustomDialog(context, const Duration(milliseconds: 400),
            //         240, SystemTransitionDuration(), true)
            //     : PlatformChannel.Toast.invokeMethod<void>('需要root权限');
          },
        ),
      ],
    );
  }
}
