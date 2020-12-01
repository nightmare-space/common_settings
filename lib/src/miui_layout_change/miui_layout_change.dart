import 'package:common_settings/src/public_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:global_repository/global_repository.dart';
import 'global_function.dart';
import 'hide_systemui_icon.dart';

class MiuiLayoutChange extends StatefulWidget {
  const MiuiLayoutChange({Key key, this.root}) : super(key: key);
  final String root;

  @override
  _MiuiLayoutChangeState createState() => _MiuiLayoutChangeState();
}

class _MiuiLayoutChangeState extends State<MiuiLayoutChange>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController; //动画控制器
  Animation<double> _fadeValue; //透明度渐变的值
  bool _showWeather = false; //是否打开天气开关
  bool _showShortcut = false; //是否打开快捷开关
  bool _showCharge = false; //是否打开电流显示
  bool _showtemperature = false; //是否打开电池温度显示
  bool _showSecond = false;
  @override
  void initState() {
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    final Animation<double> curve =
        CurvedAnimation(parent: _animationController, curve: Curves.ease);
    _fadeValue = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(curve);
    _fadeValue.addListener(() {
      setState(() {});
    });
    _animationController.forward();
    initStat();
    super.initState();
  }

  final List<String> _listKey = <String>[
    'nos_show_status_weather',
    'nos_show_status_shortcut',
    'nos_show_status_battery_charge',
    'nos_show_status_battery_temp',
    'nos_status_show_time_second',
  ];
  Future<void> initStat() async {
    _showWeather = await changeState(_listKey[0]);
    setState(() {});
    _showShortcut = await changeState(_listKey[1]);
    setState(() {});
    _showCharge = await changeState(_listKey[2]);
    setState(() {});
    _showtemperature = await changeState(_listKey[3]);
    setState(() {});
    _showSecond = await changeState(_listKey[4]);
    setState(() {});
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeValue,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          const SizedBox(
            height: 10.0,
          ),
          // MToolKit.userom
          //     ? CardButton(
          //         height: MToolKit.cardheight,
          //         margin: EdgeInsets.all(4.0 * 2.75 / window.devicePixelRatio),
          //         text0: '状态栏图标修改',
          //         relyroot: true,
          //         text1: '信号电池图标自定义（还在测试中）',
          //         onTap: () {
          //           setState(() {
          //             //if (MToolKit.romer != 'sda') {
          //             PlatformChannel.Toast.invokeMethod<void>('该功能还在测试中');
          //             // } else {
          //             //   firstPage = 1;
          //             // }
          //           });
          //         },
          //       )
          //     : SizedBox(
          //         height: 0,
          //       ),
          // MToolKit.userom
          //     ? CardButton(
          //         height: MToolKit.cardheight,
          //         text0: '状态栏时间风格',
          //         relyroot: true,
          //         text1: '显示秒数,星期,日期,月份,年份',
          //         onTap: () {
          //           showCustomDialog(context, const Duration(milliseconds: 400), 310,
          //               Oneshijian(), true);
          //         },
          //       )
          //     : SizedBox(
          //         height: 0,
          //       ),
          // MToolKit.userom
          //     ? CardButton(
          //         height: MToolKit.cardheight,
          //         text0: '状态栏网速',
          //         relyroot: true,
          //         text1: '显示上传速度,下载速度,同时显示',
          //         onTap: () {
          //           showCustomDialog(context, const Duration(milliseconds: 300),
          //               210, ChangeTrafficState(), true);
          //         },
          //       )
          //     : SizedBox(
          //         height: 0,
          //       ),
          CardWidget(
            title: '下拉栏天气显示',
            subtitle: _showWeather ? '当前已显示天气' : '当前未显示天气',
            onTap: () async {
              _showWeather = await changeState(_listKey[0], true);
              setState(() {});
            },
            suffix: Switch(
              value: _showWeather,
              onChanged: (bool val) async {
                _showWeather = await changeState(_listKey[0], true);
                setState(() {});
              },
            ),
          ),
          CardWidget(
            title: '下拉显示快捷进入',
            subtitle: _showShortcut ? '当前已显示' : '当前未显示',
            onTap: () async {
              _showShortcut = await changeState(_listKey[1], true);
              setState(() {});
            },
            suffix: Switch(
              value: _showShortcut,
              onChanged: (bool val) async {
                _showShortcut = await changeState(_listKey[1], true);
                setState(() {});
              },
            ),
          ),
          CardWidget(
            title: '下拉显示电池温度',
            subtitle: _showtemperature ? '当前已显示' : '当前未显示',
            onTap: () async {
              _showtemperature = await changeState(_listKey[3], true);
              setState(() {});
            },
            suffix: Switch(
              value: _showtemperature,
              onChanged: (bool val) async {
                _showtemperature = await changeState(_listKey[3], true);
                setState(() {});
              },
            ),
          ),
          CardWidget(
            title: '下拉显示充电电流',
            subtitle: _showCharge ? '当前已显示' : '当前未显示',
            onTap: () async {
              _showCharge = await changeState(_listKey[2], true);
              setState(() {});
            },
            suffix: Switch(
              value: _showCharge,
              onChanged: (bool val) async {
                _showCharge = await changeState(_listKey[2], true);
                setState(() {});
              },
            ),
          ),
          CardWidget(
            title: '时间显秒',
            subtitle: _showSecond ? '当前已显示' : '当前未显示',
            onTap: () async {
              _showSecond = await changeState(_listKey[4], true);
              setState(() {});
            },
            suffix: Switch(
              value: _showSecond,
              onChanged: (bool val) async {
                _showSecond = await changeState(_listKey[4], true);
                setState(() {});
              },
            ),
          ),

          CardWidget(
            title: '桌面图标布局',
            subtitle: '支持4x5,4x6,4x7,5x5,5x6,5x7,6x5,6x6,6x7切换',
            onTap: () async {},
          ),
          // CardWidget(
          //   title: '过渡动画切换',
          //   subtitle: '多种手机过度动画自由选择',
          //   onTap: () async {
          //     if (ToolkitInfo.isRoot) {
          //       if (Directory(
          //               '/data/data/com.nightmare/files/Nightmare/Animation')
          //           .existsSync()) {
          //         showCustomDialog(context, const Duration(milliseconds: 400),
          //             480, SystemTransition(), true);
          //       } else {
          //         PlatformChannel.Toast.invokeMethod<void>('缺少动画资源');
          //       }
          //     } else {
          //       showNeedRootToast();
          //     }
          //   },
          // ),
          CardWidget(
            title: '电池风格修改',
            subtitle: '选择官方没有的电池风格',
            onTap: () async {
              // ToolkitInfo.isRoot
              //     ? showCustomDialog(context, const Duration(milliseconds: 300),
              //         210, ChangeBatteryStyle(), true)
              //     : showNeedRootToast();
            },
          ),
          CardWidget(
            title: '状态栏图标隐藏',
            subtitle: '选择隐藏某个状态栏图标(不是所有都能生效)',
            onTap: () async {
              showCustomDialog(
                context: context,
                child: HideSystemUiIcon(),
                height: 400,
              );
              // ToolkitInfo.isRoot
              //     ? showCustomDialog(
              //         context,
              //         const Duration(milliseconds: 400),
              //         350 * 2.75 / window.devicePixelRatio,
              //         HideSystemUiIcon(),
              //         true)
              //     : showNeedRootToast();
            },
          ),
        ],
      ),
    );
  }
}
