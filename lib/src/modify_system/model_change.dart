// import 'dart:async';
// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:flutter_toolkit/main.dart';
// import 'package:flutter_toolkit/modules/common/public_widget.dart';
// import 'package:flutter_toolkit/utils/global_function.dart';
// import 'package:flutter_toolkit/utils/platform_channel.dart';
// import 'package:flutter_toolkit/utils/process.dart';
// import 'package:flutter_toolkit/widgets/public_widgets.dart';

// class ModelChange extends StatefulWidget {
//   @override
//   _ModelChangeState createState() => _ModelChangeState();
// }

// class _ModelChangeState extends State<ModelChange>
//     with SingleTickerProviderStateMixin {
//   AnimationController animationController; //动画控制器，List自下向上那个
//   Animation<EdgeInsets> movement; //边距补间值
//   String _model = ''; //型号
//   String _manufacturer = ''; //厂商
//   String _brand = ''; //品牌
//   String _name = ''; //设备名称
//   String _device = ''; //设备标记
//   final TextEditingController _textcontroller = TextEditingController();
//   @override
//   void initState() {
//     animationController = AnimationController(
//         duration: const Duration(milliseconds: 800), vsync: this);
//     final Animation<double> curve =
//         CurvedAnimation(parent: animationController, curve: Curves.ease);
//     movement = EdgeInsetsTween(
//       begin: const EdgeInsets.fromLTRB(8.0, 1000, 0.0, 0.0),
//       end: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 0.0),
//     ).animate(curve);
//     movement.addListener(() {
//       setState(() {});
//     });
//     animationController.forward();
//     getmessage();
//     super.initState();
//   }

//   Future<void> getmessage() async {
//     //获取手机机型
//     final String build = await CustomProcess.exec('cat /system/build.prop');
//     print(build);
//     _model = RegExp('ro.product.*.model.*')
//         .firstMatch(build)
//         .group(0)
//         .replaceAll(RegExp('.*='), '');
//     _manufacturer = RegExp('ro.product.*manufacturer.*')
//         .firstMatch(build)
//         .group(0)
//         .replaceAll(RegExp('.*='), '');
//     _brand = RegExp('ro.product.*brand.*')
//         .firstMatch(build)
//         .group(0)
//         .replaceAll(RegExp('.*='), '');
//     _name = RegExp('ro.product.*name.*')
//         .firstMatch(build)
//         .group(0)
//         .replaceAll(RegExp('.*='), '');
//     _device = RegExp('ro.product.*device.*')
//         .firstMatch(build)
//         .group(0)
//         .replaceAll(RegExp('.*='), '');
//     setState(() {});
//   }

//   Future<void> setxinghao(String a, String b, String c, String d, String e) async {
//     //修改机型的方法
//     if (a != '')
//       await CustomProcess.exec('mount -o rw,remount /system\n' +
//           "busybox sed -i 's/ro.product.model=$_model/ro.product.model=$a/g' /system/build.prop\n");

//     if (b != '')
//       await CustomProcess.exec('mount -o rw,remount /system\n' +
//           "busybox sed -i 's/ro.product.brand=$_brand/ro.product.brand=$b/g' /system/build.prop\n");
//     if (c != '')
//       await CustomProcess.exec('mount -o rw,remount /system\n' +
//           "busybox sed -i 's/ro.product.manufacturer=$_manufacturer/ro.product.manufacturer=$c/g' /system/build.prop\n");
//     if (d != '')
//       await CustomProcess.exec('mount -o rw,remount /system\n' +
//           "busybox sed -i 's/ro.product.name=$_name/ro.product.name=$d/g' /system/build.prop\n");
//     if (e != '')
//       await CustomProcess.exec('mount -o rw,remount /system\n' +
//           "busybox sed -i 's/ro.product.device=$_device/ro.product.device=$e/g' /system/build.prop\n");
//     getmessage();
//     setState(() {});
//   }

//   @override
//   void dispose() {
//     animationController.dispose();
//     super.dispose();
//   }

//   Future<void> _dialog(String title, Widget flatButton) async {
//     showCustomDialog2<void>(
//         child: FullHeightListView(
//       child: SizedBox(
//         height: 146,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <Widget>[
//             Column(
//               children: <Widget>[
//                 Padding(
//                   padding: EdgeInsets.only(bottom: 20),
//                   child: Text(
//                     title,
//                     style: TextStyle(
//                       fontSize: 20.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 TextField(
//                   controller: _textcontroller,
//                   keyboardType: TextInputType.text,
//                   decoration: InputDecoration(
//                     contentPadding:
//                         const EdgeInsets.only(top: 10.0, bottom: 10),
//                   ),
//                   autofocus: true,
//                 ),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: <Widget>[
//                 FlatButton(
//                   child: Text(
//                     '取消',
//                     style: TextStyle(
//                       fontSize: 14.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   onPressed: () {
//                     Navigator.of(globalContext).pop();
//                   },
//                 ),
//                 flatButton,
//               ],
//             )
//           ],
//         ),
//       ),
//     ));
//   }

//   String a = '';
//   String b = '';
//   String c = '';
//   String d = '';
//   String e = '';
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       padding: EdgeInsets.all(0.0),
//       children: <Widget>[
//         Padding(
//           padding: movement.value - EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 0.0),
//           child: Text(
//             '机型设置',
//             style: TextStyle(
//               color: Color(0x90303030),
//               fontSize: 14.0,
//             ),
//           ),
//         ),
//         CardButton(
//           title: '修改型号',
//           subtitle: a != '' ? '当前为：$a' : '当前为：$_model',
//           subhead: '(ro.product.model)',
//           onTap: () {
//             _textcontroller.text = _model;
//             _dialog(
//               '修改你的手机型号',
//               FlatButton(
//                   child: Text(
//                     '确认修改',
//                     style: TextStyle(
//                       fontSize: 14.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                     setxinghao(_textcontroller.text, '', '', '', '');
//                   }),
//             );
//           },
//         ),
//         CardButton(
//           title: '修改品牌',
//           subtitle: b != '' ? '当前为：$b' : '当前为：$_brand',
//           subhead: '(ro.product.brand)',
//           onTap: () {
//             _textcontroller.text = _brand;
//             _dialog(
//               '修改你的品牌名称',
//               FlatButton(
//                   child: Text(
//                     '确认修改',
//                     style: TextStyle(
//                       fontSize: 14.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                     setxinghao('', _textcontroller.text, '', '', '');
//                   }),
//             );
//           },
//         ),
//         CardButton(
//           title: '修改厂商名称',
//           subtitle: c != '' ? '当前为：$c' : '当前为：$_manufacturer',
//           subhead: '(ro.product.manufacturer)',
//           onTap: () {
//             _textcontroller.text = _manufacturer;
//             _dialog(
//               '修改你的厂商名称',
//               FlatButton(
//                   child: Text(
//                     '确认修改',
//                     style: TextStyle(
//                       fontSize: 14.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                     setxinghao('', '', _textcontroller.text, '', '');
//                   }),
//             );
//           },
//         ),
//         CardButton(
//           title: '修改设备名称',
//           subtitle: d != '' ? '当前为：$d' : '当前为：$_name',
//           subhead: '(ro.product.name)',
//           onTap: () {
//             _textcontroller.text = _name;
//             _dialog(
//               '修改你的设备名称',
//               FlatButton(
//                   child: Text(
//                     '确认修改',
//                     style: TextStyle(
//                       fontSize: 14.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                     setxinghao('', '', '', _textcontroller.text, '');
//                   }),
//             );
//           },
//         ),
//         CardButton(
//           title: '修改设备标记',
//           subtitle: e != '' ? '当前为：$e' : '当前为：$_device',
//           subhead: '(ro.product.device)',
//           onTap: () {
//             _textcontroller.text = _device;
//             _dialog(
//               '修改你的设备标记',
//               FlatButton(
//                   child: Text(
//                     '确认修改',
//                     style: TextStyle(
//                       fontSize: 14.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                     setxinghao('', '', '', '', _textcontroller.text);
//                   }),
//             );
//           },
//         ),
//         Padding(
//           padding: movement.value - EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 0.0),
//           child: Text(
//             '模板',
//             style: TextStyle(
//               color: Color(0x90303030),
//               fontSize: 14.0,
//             ),
//           ),
//         ),
//         Container(
//             height: 40,
//             child: Scrollbar(
//               child: ListView(
//                 scrollDirection: Axis.horizontal,
//                 children: <Widget>[
//                   Card(
//                     elevation: 1,
//                     child: InkWell(
//                       borderRadius: BorderRadius.circular(4.0),
//                       child: Container(
//                         alignment: Alignment.centerRight,
//                         child: Padding(
//                           padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
//                           child: Text(
//                             'R11+',
//                             style: TextStyle(
//                               fontSize: 14.0,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                       onTap: () {
//                         a = 'OPPO R11 Plus';
//                         b = 'OPPO';
//                         c = 'OPPO';
//                         d = 'R11 Plus';
//                         e = 'R11 Plus';
//                         setState(() {});
//                       },
//                     ),
//                   ),
//                   Card(
//                     elevation: 1,
//                     child: InkWell(
//                       borderRadius: BorderRadius.circular(4.0),
//                       child: Container(
//                         alignment: Alignment.centerRight,
//                         child: Padding(
//                           padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
//                           child: Text(
//                             'R15',
//                             style: TextStyle(
//                               fontSize: 14.0,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                       onTap: () {
//                         a = 'PAAM00';
//                         b = 'OPPO';
//                         c = 'OPPO';
//                         d = 'OPPO R15';
//                         e = 'PAAM00';
//                         setState(() {});
//                       },
//                     ),
//                   ),
//                   Card(
//                     elevation: 1,
//                     child: InkWell(
//                       borderRadius: BorderRadius.circular(4.0),
//                       child: Container(
//                         alignment: Alignment.centerRight,
//                         child: Padding(
//                           padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
//                           child: Text(
//                             'X20',
//                             style: TextStyle(
//                               fontSize: 14.0,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                       onTap: () {
//                         a = 'vivo X20';
//                         b = 'vivo';
//                         c = 'vivo';
//                         d = 'X20';
//                         e = 'X20';
//                         setState(() {});
//                       },
//                     ),
//                   ),
//                   Card(
//                     elevation: 1,
//                     child: InkWell(
//                       borderRadius: BorderRadius.circular(4.0),
//                       child: Container(
//                         alignment: Alignment.centerRight,
//                         child: Padding(
//                           padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
//                           child: Text(
//                             'S9+',
//                             style: TextStyle(
//                               fontSize: 14.0,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                       onTap: () {
//                         a = 'SM-G9650';
//                         b = 'samsung';
//                         c = 'samsung';
//                         d = 'star2qltezc';
//                         e = 'star2qltechn';
//                         setState(() {});
//                       },
//                     ),
//                   ),
//                   Card(
//                     elevation: 1,
//                     child: InkWell(
//                       borderRadius: BorderRadius.circular(4.0),
//                       child: Container(
//                         alignment: Alignment.centerRight,
//                         child: Padding(
//                           padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
//                           child: Text(
//                             '8848',
//                             style: TextStyle(
//                               fontSize: 14.0,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                       onTap: () {
//                         a = 'EBEN M2';
//                         b = 'ERENEBEN';
//                         c = 'ERENEBEN';
//                         d = 'EBEN M2';
//                         e = 'EBEN M2';
//                         setState(() {});
//                       },
//                     ),
//                   ),
//                   Card(
//                     elevation: 1,
//                     child: InkWell(
//                       borderRadius: BorderRadius.circular(4.0),
//                       child: Container(
//                         width: 80,
//                         alignment: Alignment.center,
//                         child: Padding(
//                           padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
//                           child: Text(
//                             '默认',
//                             style: TextStyle(
//                               fontSize: 14.0,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                       onTap: () {
//                         a = '';
//                         b = '';
//                         c = '';
//                         d = '';
//                         e = '';
//                         getmessage();
//                       },
//                     ),
//                   ),
//                   Card(
//                     elevation: 1,
//                     child: InkWell(
//                       borderRadius: BorderRadius.circular(4.0),
//                       child: Container(
//                         width: 80,
//                         alignment: Alignment.center,
//                         child: Padding(
//                           padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
//                           child: Text(
//                             '保存',
//                             style: TextStyle(
//                               fontSize: 14.0,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                       onTap: () async {
//                         setxinghao(a, b, c, d, e);
//                         PlatformChannel.Toast.invokeMethod<void>('保存成功');
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             )),
//         Padding(
//           padding: movement.value - EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 0.0),
//           child: Text(
//             '其他',
//             style: TextStyle(
//               color: Color(0x90303030),
//               fontSize: 14.0,
//             ),
//           ),
//         ),
//         Card(
//           elevation: 1,
//           child: InkWell(
//             borderRadius: BorderRadius.circular(4.0),
//             child: SizedBox(
//               width: MediaQuery.of(context).size.width,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Padding(
//                     padding: movement.value,
//                     child: Text(
//                       '开启王者录像',
//                       style: TextStyle(
//                         fontSize: 14.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(8.0, 4.0, 0.0, 8.0),
//                     child: Text(
//                       '点击修改为小米8Lite',
//                       style: TextStyle(
//                         color: Color(0xff696666),
//                         fontSize: 12.0,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             onTap: () {
//               // PlatformChannel.Third.invokeMethod<void>('Model', 'MI 8 Lite');
//               // PlatformChannel.Third.invokeMethod<void>('Brand', 'Xiaomi');
//               // PlatformChannel.Third.invokeMethod<void>('Manufacturer', 'Xiaomi');
//               // PlatformChannel.Third.invokeMethod<void>('Name', 'platina');
//               // PlatformChannel.Third.invokeMethod<void>('Device', 'platina');
//               PlatformChannel.Toast.invokeMethod<void>('重启刷新整个系统的值');
//               Future<void>.delayed(Duration(milliseconds: 1000), () {});
//             },
//           ),
//         ),
//         Card(
//           elevation: 1,
//           child: InkWell(
//             borderRadius: BorderRadius.circular(4.0),
//             child: SizedBox(
//               height: 52,
//               width: MediaQuery.of(context).size.width,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
//                     child: Text(
//                       '恢复默认值',
//                       style: TextStyle(
//                         fontSize: 14.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             onTap: () async {
//               a = '';
//               b = '';
//               c = '';
//               d = '';
//               e = '';
//               await CustomProcess.exec('mount -o rw,remount /system\n' +
//                   'cp -r -f /system/build.bak /system/build.prop');
//               getmessage();
//               PlatformChannel.Toast.invokeMethod<void>('恢复完成');
//             },
//           ),
//         ),
//         Align(
//           alignment: Alignment.bottomCenter,
//           child: Center(
//             child: Text(
//               '提示：已生成的系统信息单刷备份包位于Sdcard/Nightmare ',
//               style: TextStyle(
//                 color: Color(0xff000000),
//                 fontSize: 14.0,
//               ),
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
