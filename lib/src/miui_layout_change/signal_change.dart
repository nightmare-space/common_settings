// import 'package:flutter/material.dart';
// import 'package:flutter_toolkit/utils/platform_channel.dart';
// import 'package:flutter_toolkit/widgets/Button_YingYong.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class OneZhuangTai extends StatefulWidget {
//   @override
//   _OneZhuangTaiState createState() => _OneZhuangTaiState();
// }

// class _OneZhuangTaiState extends State<OneZhuangTai>
//     with SingleTickerProviderStateMixin {
//   final List<Image> caoNiMa = [
//     Image.asset("lib/images/stat_sys_signal_0.png"),
//     Image.asset("lib/images/stat_sys_signal_1.png"),
//     Image.asset("lib/images/stat_sys_signal_2.png"),
//     Image.asset("lib/images/stat_sys_signal_3.png"),
//     Image.asset("lib/images/stat_sys_signal_4.png"),
//     Image.asset("lib/images/stat_sys_signal_null.png"),
//   ];
//   final List<Image> guanfang = [
//     Image.asset("lib/images/stat_sys_signal_0_darkmode.png"),
//     Image.asset("lib/images/stat_sys_signal_1_darkmode.png"),
//     Image.asset("lib/images/stat_sys_signal_2_darkmode.png"),
//     Image.asset("lib/images/stat_sys_signal_3_darkmode.png"),
//     Image.asset("lib/images/stat_sys_signal_4_darkmode.png"),
//     Image.asset("lib/images/stat_sys_signal_5_darkmode.png"),
//     Image.asset("lib/images/stat_sys_signal_null_darkmode.png"),
//   ];
//   String single; //信号图标值
//   String data; //数据图标值
//   int singlevalue;
//   int singledefault;
//   bool boom;

//   void handleSingleChanged(String value) {
//     setState(() {
//       single = value.toString();
//     });
//   }

//   void handleDataChanged(String value) {
//     setState(() {
//       data = value.toString();
//     });
//   }

//   @override
//   void initState() {
//     singledefault ??= 0;
//     singlevalue ??= 0;
//     set();
//     caonimachange();
//     guanfangchange();
//     beifen();
//     print(boom);
//     super.initState();
//   }

//   Future<Null> beifen() async {
//     CustomProcess.exec("true","mount -o rw,remount /system\n" +
//         "if [ ! -e /sdcard/Nightmare/SystemUI_Backup.zip ]; then\n" +
//         "cp /system/usr/Nightmare/Backup /system/usr/Nightmare/1.zip\n" +
//         "cd /system/priv-app/MiuiSystemUI/\$f/\n" +
//         "/system/usr/Nightmare/mengyan -r /system/usr/Nightmare/1.zip *.apk\n" +
//         "mkdir /sdcard/Nightmare\n" +
//         "mv /system/usr/Nightmare/1.zip /sdcard/Nightmare/SystemUI_Backup.zip\n" +
//         "fi\n");
//   }

//   Future<Null> set() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     if (prefs.getString("single") == null) {
//       prefs.setString('single', '$single');
//     }
//     if (prefs.getString("data") == null) {
//       prefs.setString('data', '$data');
//     }
//     single = prefs.getString("single");
//     data = prefs.getString("data");
//   }

//   Future<Null> guanfangchange() async {
//     for (singledefault = 0;
//         singledefault < 6;
//         await Future<void>.delayed(Duration(milliseconds: 400), () {
//       setState(() {
//         singledefault++;
//       });
//     })) {
//       if (singledefault == 5) {
//         await Future<void>.delayed(Duration(milliseconds: 400), () {
//           setState(() {
//             singledefault = 0;
//           });
//         });
//       }
//     }
//   }

//   Future<Null> caonimachange() async {
//     for (singlevalue = 0;
//         singlevalue < 6;
//         await Future<void>.delayed(Duration(milliseconds: 400), () {
//       setState(() {
//         singlevalue++;
//       });
//     })) {
//       if (singlevalue == 5) {
//         await Future<void>.delayed(Duration(milliseconds: 400), () {
//           setState(() {
//             singlevalue = 0;
//           });
//         });
//       }
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

// //  mx() {
// //    Future<void>.delayed(Duration(milliseconds: 1000), () {
// //      _controll.forward();
// //    });
// //  }
//   Future<Null> set1() async {
//     SharedPreferences prefs =
//     await SharedPreferences.getInstance();
//     if (prefs.get('data') == data &&
//         prefs.get("single") == single) {
//       PlatformChannel.Toast.invokeMethod<void>("你还没有更改任何选择");
//     } else {
//       if (single == 'Single_CaoNiMa') {
//         prefs.setString('single', single);
//         CustomProcess.exec("true","mount -o rw,remount /system\n" +
//             "if [ -f \"/system/priv-app/MiuiSystemUI/MiuiSystemUI.bak\" ]; then\n" +
//             "mount -o rw,remount /system\n" +
//             "else\n" +
//             "cp /system/priv-app/MiuiSystemUI/MiuiSystemUI.apk /system/priv-app/MiuiSystemUI/MiuiSystemUI.bak\n" +
//             "fi\n" +
//             "cp /system/priv-app/MiuiSystemUI/MiuiSystemUI.apk /system/priv-app/MiuiSystemUI/MiuiSystemUI.zip\n" +
//             "cd /system/usr/Nightmare/2/Nightmare/4/\$f/\n" +
//             "/system/usr/Nightmare/mengyan -r /system/priv-app/MiuiSystemUI/MiuiSystemUI.zip *\n" +
//             "mv /system/priv-app/MiuiSystemUI/MiuiSystemUI.zip /system/priv-app/MiuiSystemUI/MiuiSystemUI.bak1\n" +
//             "if [ -f \"/system/priv-app/MiuiSystemUI/MiuiSystemUI.bak1\" ]; then\n" +
//             "rm -rf /system/priv-app/MiuiSystemUI/MiuiSystemUI.apk\n" +
//             "mv /system/priv-app/MiuiSystemUI/MiuiSystemUI.bak1 /system/priv-app/MiuiSystemUI/MiuiSystemUI.apk\n" +
//             "else\n" +
//             "mount -o rw,remount /system\n" +
//             "fi\n" +
//             "chmod -R 0644 /system/priv-app/MiuiSystemUI/MiuiSystemUI.apk\n" +
//             "sleep 1\n");
//         PlatformChannel.Toast.invokeMethod<void>("正在重启状态栏");
//         await Future<void>.delayed(Duration(milliseconds: 2000),
//                 () {
//               CustomProcess.exec(
//                   "true","busybox killall com.android.systemui");
//             });
//       }
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: <Widget>[
//         SizedBox(
//           height: 580,
//           child: SingleChildScrollView(
//             physics: BouncingScrollPhysics(),
//             child: ListBody(
//               children: <Widget>[
//                 Padding(
//                     padding: const EdgeInsets.fromLTRB(2.0, 2.0, 0.0, 0.0),
//                     child: Center(
//                       child: Text(
//                         "提示：点击将会立即生效",
//                         style: TextStyle(
//                           color: Color(0xff000000),
//                           fontSize: 14.0,
//                         ),
//                       ),
//                     )),
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(2.0, 0.0, 0.0, 0.0),
//                   child: Text(
//                     "信号图标更改",
//                     style: TextStyle(
//                       color: Color(0xff000000),
//                       fontSize: 14.0,
//                     ),
//                   ),
//                 ),
//                 Container(
//                     height: 32,
//                     child: Scrollbar(
//                       child: ListView(
//                         scrollDirection: Axis.horizontal,
//                         children: <Widget>[
//                           Card(
//                               child: Stack(
//                             children: <Widget>[
//                               InkWell(
//                                 child: guanfang[singlevalue],
//                                 onTap: () {
//                                   handleSingleChanged("Single_Default");
//                                 },
//                               ),
//                               Offstage(
//                                 offstage: true,
//                                 child: guanfang[0],
//                               ),
//                               Offstage(
//                                 offstage: true,
//                                 child: guanfang[1],
//                               ),
//                               Offstage(
//                                 offstage: true,
//                                 child: guanfang[2],
//                               ),
//                               Offstage(
//                                 offstage: true,
//                                 child: guanfang[3],
//                               ),
//                               Offstage(
//                                 offstage: true,
//                                 child: guanfang[4],
//                               ),
//                               Offstage(
//                                 offstage: true,
//                                 child: guanfang[5],
//                               ),
//                               Offstage(
//                                 offstage: true,
//                                 child: guanfang[6],
//                               ),
//                             ],
//                           )),
//                           Radio<String>(
//                               value: "Single_Default",
//                               groupValue: single,
//                               onChanged: handleSingleChanged),
//                           Card(
//                               child: Stack(
//                             children: <Widget>[
//                               InkWell(
//                                 child: caoNiMa[singlevalue],
//                                 onTap: () {
//                                   handleSingleChanged("Single_CaoNiMa");
//                                 },
//                               ),
//                               Offstage(
//                                 offstage: true,
//                                 child: caoNiMa[0],
//                               ),
//                               Offstage(
//                                 offstage: true,
//                                 child: caoNiMa[1],
//                               ),
//                               Offstage(
//                                 offstage: true,
//                                 child: caoNiMa[2],
//                               ),
//                               Offstage(
//                                 offstage: true,
//                                 child: caoNiMa[3],
//                               ),
//                               Offstage(
//                                 offstage: true,
//                                 child: caoNiMa[4],
//                               ),
//                               Offstage(
//                                 offstage: true,
//                                 child: caoNiMa[5],
//                               ),
//                             ],
//                           )),
//                           Radio<String>(
//                               value: "Single_CaoNiMa",
//                               groupValue: single,
//                               onChanged: handleSingleChanged),
//                         ],
//                       ),
//                     )),
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(2.0, 0.0, 0.0, 0.0),
//                   child: Text(
//                     "数据图标更改",
//                     style: TextStyle(
//                       color: Color(0xff000000),
//                       fontSize: 14.0,
//                     ),
//                   ),
//                 ),
//                 Container(
//                     height: 30,
//                     child: Scrollbar(
//                       child: ListView(
//                         scrollDirection: Axis.horizontal,
//                         children: <Widget>[
//                           Card(child: Image.asset("lib/images/data.gif")),
//                           Radio<String>(
//                               value: "Single_Default",
//                               groupValue: data,
//                               onChanged: handleDataChanged),
//                           Card(
//                               child: Image.asset(
//                                   "lib/images/stat_sys_signal_0.png")),
//                           Radio<String>(
//                               value: "Single_CaoNiMa",
//                               groupValue: data,
//                               onChanged: handleDataChanged),
//                         ],
//                       ),
//                     )),
//               ],
//             ),
//           ),
//         ),
//         Padding(
//           padding: EdgeInsets.only(bottom: 20),
//           child: Align(
//             alignment: Alignment.center,
//             child: Column(
//               children: <Widget>[
//                 YingYong(
//                   method: (){

//                       set1();
//                       print("sdsd");
//                   },
//                 ),
//                 Text(
//                   "提示：已生成的状态栏单刷备份包位于Sdcard/Nightmare",
//                   style: TextStyle(
//                     color: Color(0xff000000),
//                     fontSize: 14.0,
//                   ),
//                 ),
//                 Text(
//                   "请勿手动删除MiuiSystem下后缀名为bak的文件",
//                   style: TextStyle(
//                     color: Color(0xff000000),
//                     fontSize: 14.0,
//                   ),
//                 ),
//                 Text(
//                   "xml脚本失效导致状态栏无法重启直接进入REC刷入单刷包",
//                   style: TextStyle(
//                     color: Color(0xff000000),
//                     fontSize: 14.0,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
