// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_toolkit/utils/platform_channel.dart';
// import 'package:flutter_toolkit/utils/process.dart';
// import 'package:flutter_toolkit/widgets/anvil_effect/anvil_effect.dart';

// class SystemTransition extends StatefulWidget {
//   @override
//   _SystemTransitionState createState() => _SystemTransitionState();
// }

// class _SystemTransitionState extends State<SystemTransition> {
//   String donghua;
//   String donghuapre;
//   void handleSingleChanged(String value) {
//     setState(() {
//       donghua = value.toString();
//     });
//   }

//   Future<void> frameworkbak() async {
//     if (!File('/system/framework/framework-res.bak').existsSync()) {
//       await File('/system/framework/framework-res.apk')
//           .copy('/system/framework/framework-res.bak');
//     }
//   }

//   // String magisk = "mount -o rw,remount /system\n" +
//   //     "mv -f /system/framework/framework-res.tmp /system/framework/framework-res.apk\n" +
//   //     "chmod -R 0644 /system/framework/framework-res.apk\n";
//   // String magisk0 = "mount -o rw,remount /system\n" +
//   //     "mkdir /sbin/.core/img/Nightmare/system\n" +
//   //     "mkdir /sbin/.core/img/Nightmare/system/framework\n" +
//   //     "rm -rf /sbin/.core/img/Nightmare/system/framework/framework-res.apk\n" +
//   //     "mv /system/usr/Nightmare/framework-res.bak1 /sbin/.core/img/Nightmare/system/framework/framework-res.apk\n" +
//   //     "chmod -R 0644 /sbin/.core/img/Nightmare/system/framework/framework-res.apk\n";
//   // Future<Null> set(String shi) async {
//     // SharedPreferences prefs = await SharedPreferences.getInstance();
//     // if (prefs.getString("donghua") == null) {
//     //   prefs.setString('donghua', 'default');
//     // } else {
//     //   if (shi == "a") {
//     //     donghua = prefs.getString("donghua");
//     //   } else {
//     //     prefs.setString('donghua', shi);
//     //     donghua = prefs.getString("donghua");
//     //   }
//     // }
//     // donghuapre = prefs.getString("donghua");
//     // print(prefs.getString("donghua"));
//   //   setState(() {});
//   // }

//   @override
//   void initState() {
//     donghua ??= "default";
//     // set("a");
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   Future setanima(String str) async {
//     // set(str);
//     // if (usemagisk) {
//     //   CustomProcess.exec(
//     //       "true",
//     //       "mount -o rw,remount /system\n"
//     //           "cp /system/framework/framework-res.apk /system/framework/framework-res.zip\n" +
//     //           "cd /data/data/com.nightmare/files/Nightmare/Animation/Framework/$str/\$f/\n" +
//     //           "/system/usr/Nightmare/mengyan -r /system/framework/framework-res.zip *\n" +
//     //           "mv /system/framework/framework-res.zip /system/usr/Nightmare/framework-res.bak1\n" +
//     //           magisk0 +
//     //           "sleep 1\n");
//     // } else {
//     await frameworkbak();
//     await CustomProcess.exec(
//         "mount -o rw,remount /system\n" +
//             "cp /system/framework/framework-res.apk /system/framework/framework-res.tmp\n" +
//             "cd /data/data/com.nightmare/files/Nightmare/Animation/Framework/$str/\$f/\n" +
//             "/data/data/com.nightmare/files/usr/bin/zip -r /system/framework/framework-res.tmp *\n" +
//             magisk +
//             "sleep 1\n");
//     // }
//     Future<void>.delayed(const Duration(milliseconds: 1000), () {
//       PlatformChannel.Toast.invokeMethod<void>('手动重启后生效');
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox.expand(
//       child: SingleChildScrollView(
//         physics: BouncingScrollPhysics(),
//         child: ListBody(
//           children: <Widget>[
//             Padding(
//                 padding: const EdgeInsets.fromLTRB(2.0, 2.0, 0.0, 0.0),
//                 child: Center(
//                   child: Text(
//                     "提示：手动重启后生效",
//                     style: TextStyle(
//                       color: Color(0xff000000),
//                       fontSize: 14.0,
//                     ),
//                   ),
//                 )),
//             Material(
//               color: Colors.white,
//               child: Ink(
//                 child: InkWell(
//                   onTap: () {
//                     handleSingleChanged("default");
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Padding(
//                         padding: const EdgeInsets.fromLTRB(2.0, 0.0, 0.0, 0.0),
//                         child: Text(
//                           "官方默认",
//                           style: TextStyle(
//                             color: Color(0xff000000),
//                             fontSize: 14.0,
//                           ),
//                         ),
//                       ),
//                       Radio<String>(
//                           value: "default",
//                           groupValue: donghua,
//                           onChanged: handleSingleChanged),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Material(
//               color: Colors.white,
//               child: Ink(
//                 child: InkWell(
//                   onTap: () {
//                     handleSingleChanged("IOS");
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Padding(
//                         padding: const EdgeInsets.fromLTRB(2.0, 0.0, 0.0, 0.0),
//                         child: Text(
//                           "IOS动画",
//                           style: TextStyle(
//                             color: Color(0xff000000),
//                             fontSize: 14.0,
//                           ),
//                         ),
//                       ),
//                       Radio<String>(
//                           value: "IOS",
//                           groupValue: donghua,
//                           onChanged: handleSingleChanged),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Material(
//               color: Colors.white,
//               child: Ink(
//                 child: InkWell(
//                   onTap: () {
//                     handleSingleChanged("DX8");
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Padding(
//                         padding: const EdgeInsets.fromLTRB(2.0, 0.0, 0.0, 0.0),
//                         child: Text(
//                           "DX8动画",
//                           style: TextStyle(
//                             color: Color(0xff000000),
//                             fontSize: 14.0,
//                           ),
//                         ),
//                       ),
//                       Radio<String>(
//                           value: "DX8",
//                           groupValue: donghua,
//                           onChanged: handleSingleChanged),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Material(
//               color: Colors.white,
//               child: Ink(
//                 child: InkWell(
//                   onTap: () {
//                     handleSingleChanged("IUNI");
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Padding(
//                         padding: const EdgeInsets.fromLTRB(2.0, 0.0, 0.0, 0.0),
//                         child: Text(
//                           "IUNI动画",
//                           style: TextStyle(
//                             color: Color(0xff000000),
//                             fontSize: 14.0,
//                           ),
//                         ),
//                       ),
//                       Radio<String>(
//                           value: "IUNI",
//                           groupValue: donghua,
//                           onChanged: handleSingleChanged),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Material(
//               color: Colors.white,
//               child: Ink(
//                 child: InkWell(
//                   onTap: () {
//                     handleSingleChanged("NINE");
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Padding(
//                         padding: const EdgeInsets.fromLTRB(2.0, 0.0, 0.0, 0.0),
//                         child: Text(
//                           "NINE动画",
//                           style: TextStyle(
//                             color: Color(0xff000000),
//                             fontSize: 14.0,
//                           ),
//                         ),
//                       ),
//                       Radio<String>(
//                           value: "NINE",
//                           groupValue: donghua,
//                           onChanged: handleSingleChanged),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Material(
//               color: Colors.white,
//               child: Ink(
//                 child: InkWell(
//                   onTap: () {
//                     handleSingleChanged("BLUR");
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Padding(
//                         padding: const EdgeInsets.fromLTRB(2.0, 0.0, 0.0, 0.0),
//                         child: Text(
//                           "BLUR动画",
//                           style: TextStyle(
//                             color: Color(0xff000000),
//                             fontSize: 14.0,
//                           ),
//                         ),
//                       ),
//                       Radio<String>(
//                           value: "BLUR",
//                           groupValue: donghua,
//                           onChanged: handleSingleChanged),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Material(
//               color: Colors.white,
//               child: Ink(
//                 child: InkWell(
//                   onTap: () {
//                     handleSingleChanged("JiuWei");
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Padding(
//                         padding: const EdgeInsets.fromLTRB(2.0, 0.0, 0.0, 0.0),
//                         child: Text(
//                           "九尾动画",
//                           style: TextStyle(
//                             color: Color(0xff000000),
//                             fontSize: 14.0,
//                           ),
//                         ),
//                       ),
//                       Radio<String>(
//                           value: "JiuWei",
//                           groupValue: donghua,
//                           onChanged: handleSingleChanged),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Material(
//               color: Colors.white,
//               child: Ink(
//                 child: InkWell(
//                   onTap: () {
//                     handleSingleChanged("3D");
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Padding(
//                         padding: const EdgeInsets.fromLTRB(2.0, 0.0, 0.0, 0.0),
//                         child: Text(
//                           "3D动画",
//                           style: TextStyle(
//                             color: Color(0xff000000),
//                             fontSize: 14.0,
//                           ),
//                         ),
//                       ),
//                       Radio<String>(
//                           value: "3D",
//                           groupValue: donghua,
//                           onChanged: handleSingleChanged),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Center(
//               child: Container(
//                 width: 160,
//                 height: 40,
//                 child: Card(
//                     color: Colors.green,
//                     shape: new RoundedRectangleBorder(
//                       borderRadius: new BorderRadius.circular(
//                           25.0), //如果[borderRadius]被指定，那么[type]属性不能是 [MaterialType.circle]。
//                     ),
//                     elevation: 1,
//                     child: InkWell(
//                       borderRadius: BorderRadius.circular(25),
//                       onTap: () {
//                         if (donghua == donghuapre) {
//                           final Map<String,int> map={'Emoji': 0x1F624};
//                           PlatformChannel.Toast.invokeMethod<void>(
//                               '更改一下啊喂！', map);
//                         } else {
//                           switch (donghua) {
//                             case 'default':
//                               CustomProcess.exec(
//                                   'mount -o rw,remount /system\n'
//                                           'mount -o rw,remount /system\n' +
//                                       'if [ -f /system/framework/framework-res.bak ]; then\n' +
//                                       'rm -rf /system/framework/framework-res.apk\n' +
//                                       'cp /system/framework/framework-res.bak /system/framework/framework-res.apk\n' +
//                                       'chmod -R 0644 /system/framework/framework-res.apk\n' +
//                                       'fi\n' +
//                                       'chmod -R 0755 /sbin/.core/img/Nightmare/post-fs-data.sh\n' +
//                                       'sleep 1\n');
//                               Future<void>.delayed(const Duration(milliseconds: 1000), () {
//                                 PlatformChannel.Toast.invokeMethod<void>("手动重启后生效");
//                               });
//                               break;
//                             case "IOS":
//                               setanima("IOS");
//                               break;
//                             case "DX8":
//                               setanima("DX8");
//                               break;
//                             case "IUNI":
//                               setanima("IUNI");
//                               break;
//                             case "NINE":
//                               setanima("NINE");
//                               break;
//                             case "BLUR":
//                               setanima("BLUR");
//                               break;
//                             case "JiuWei":
//                               setanima("JiuWei");
//                               break;
//                             case "3D":
//                               setanima("3D");
//                               break;
//                           }
//                           explosionEvent.fire(
//                             ExplosionWidget(),
//                           );
//                         }
//                       },
//                       child: Container(
//                         height: 40,
//                         width: MediaQuery.of(context).size.width,
//                         child: Center(
//                           child: Text(
//                             "应用",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 14.0,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     )),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
