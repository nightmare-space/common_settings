// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_toolkit/main.dart';
// import 'package:flutter_toolkit/modules/file_manager/page/fm_page.dart';
// import 'package:flutter_toolkit/utils/platform_channel.dart';
// import 'package:flutter_toolkit/widgets/custom_dialog.dart';

// class CpuScriptExec extends StatefulWidget {
//   @override
//   _CpuScriptExecState createState() => _CpuScriptExecState();
// }

// class _CpuScriptExecState extends State<CpuScriptExec> {
//   List<Widget> list1 = [];
//   Future<Null> touch() async {
//     list1 = [
//       Center(
//         child: Text(
//           "性能配置",
//           style: TextStyle(
//             color: Colors.black54,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       Material(
//         color: Colors.white,
//         child: Ink(
//           child: InkWell(
//             onTap: () async {
//               String filepath = "";

//               showCustomDialog(
//                   context,
//                   const Duration(milliseconds: 300),
//                   600,
//                   FMPage(
//                     chooseFile: true,
//                     initpath: "$documentsDir/MTOOLKIT",
//                     callback: (str) async {
//                       filepath = str;
//                       Navigator.of(context).pop();
//                       if (filepath.contains(".sh")) {
//                         print(
//                             "cp $filepath /data/data/com.nightmare/files/Nightmare/CPU.sh\n");
//                         String a = await CustomProcess.exec(
//                             "",
//                             "cp $filepath /data/data/com.nightmare/files/Nightmare/CPU.sh\n" +
//                                 "chmod -R 0777 /data/data/com.nightmare/files/Nightmare/CPU.sh\n");
//                         print(a);
//                       } else {
//                         PlatformChannel.Toast.invokeMethod<void>("请选择正确的脚本文件");
//                       }
//                       await touch();
//                       setState(() {});
//                       // if (filepath == null) {
//                       //   PlatformChannel.Toast.invokeMethod<void>("你没有选择文件");
//                       // } else {}
//                     },
//                   ),
//                   true,
//                   false);
//             },
//             child: SizedBox(
//               height: 50,
//               child: Center(
//                 child: Text(
//                   "导入脚本（YC脚本）",
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     ];
//     Future<void>.delayed(Duration(milliseconds: 0), () async {
//       if (File("/data/data/com.nightmare/files/Nightmare/CPU.sh")
//           .existsSync()) {
//         list1.add(
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               SizedBox(
//                 width: 80,
//                 height: 40,
//                 child: YingYong(
//                   text: "省电",
//                   aa: "省电",
//                   method: () async {
//                     CustomProcess.exec(
//                         "true",
//                         "mount -o rw,remount /system\n" +
//                             "sh /data/data/com.nightmare/files/Nightmare/CPU.sh powersave\n");
//                     PlatformChannel.Toast.invokeMethod<void>("Ojbk");
//                   },
//                 ),
//               ),
//               SizedBox(
//                 width: 80,
//                 height: 40,
//                 child: YingYong(
//                   text: "均衡",
//                   aa: "均衡",
//                   method: () async {
//                     CustomProcess.exec(
//                         "true",
//                         "mount -o rw,remount /system\n" +
//                             "sh /data/data/com.nightmare/files/Nightmare/CPU.sh balance\n");

//                     PlatformChannel.Toast.invokeMethod<void>("Ojbk");
//                   },
//                 ),
//               ),
//               SizedBox(
//                 width: 80,
//                 height: 40,
//                 child: YingYong(
//                   text: "性能",
//                   aa: "性能",
//                   method: () async {
//                     CustomProcess.exec(
//                         "true",
//                         "mount -o rw,remount /system\n" +
//                             "sh /data/data/com.nightmare/files/Nightmare/CPU.sh performance\n");

//                     PlatformChannel.Toast.invokeMethod<void>("Ojbk");
//                   },
//                 ),
//               ),
//               SizedBox(
//                 width: 80,
//                 height: 40,
//                 child: YingYong(
//                   text: "极速",
//                   aa: "极速",
//                   method: () async {
//                     CustomProcess.exec(
//                         "true",
//                         "mount -o rw,remount /system\n" +
//                             "sh /data/data/com.nightmare/files/Nightmare/CPU.sh fast\n");
//                     PlatformChannel.Toast.invokeMethod<void>("Ojbk");
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//         list1.add(SizedBox(
//           height: 100,
//         ));
//         if (context != null) {
//           setState(() {});
//         }
//       }
//     });
//   }

//   @override
//   void initState() {
//     touch();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         Card(
//           elevation: 1,
//           child: InkWell(
//             borderRadius: BorderRadius.circular(4.0),
//             child: SizedBox(
//               width: MediaQuery.of(context).size.width,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: list1,
//               ),
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
