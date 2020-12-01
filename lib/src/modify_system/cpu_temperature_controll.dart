// import 'package:flutter/material.dart';
// import 'package:flutter_toolkit/utils/process.dart';
// import 'package:flutter_toolkit/widgets/material_cliprrect.dart';

// class CpuTemperatureControll extends StatefulWidget {
//   @override
//   _CpuTemperatureControllState createState() => _CpuTemperatureControllState();
// }

// class _CpuTemperatureControllState extends State<CpuTemperatureControll> {
//   bool bval0;
//   bool bval1;
//   bool bval2;

//   Future<void> touch() async {
//     Future<void>.delayed(Duration(milliseconds: 0), () async {
//       String a = await CustomProcess.exec("cat /sys/module/msm_thermal/core_control/enabled");

//       String b = await CustomProcess.exec("cat /sys/module/msm_thermal/vdd_restriction/enabled");
//       String c = await CustomProcess.exec("cat /sys/module/msm_thermal/parameters/enabled");
//       if (a == "0") {
//         bval0 = false;
//       } else {
//         bval0 = true;
//       }
//       b == "0" ? bval1 = false : bval1 = true;

//       c == "0" || c == "N" ? bval2 = false : bval2 = true;
//       if (context != null) setState(() {});
//     });
//   }

//   @override
//   void initState() {
//     bval0 = false;
//     bval1 = false;
//     bval2 = false;
//     touch();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         // Card(
//         //   elevation: 1,
//         //   child: InkWell(
//         //     borderRadius: BorderRadius.circular(4.0),
//         //     child: SizedBox(
//         //       width: MediaQuery.of(context).size.width,
//         //       child: Column(
//         //         crossAxisAlignment: CrossAxisAlignment.start,
//         //         children: <Widget>[
//         //           Padding(
//         //             padding: EdgeInsets.all(4),
//         //             child: Text(
//         //               "提示：内核的调度是非常复杂的，把所有需要修改的内容全部贴出来，反而会显得更加的复杂，单纯的开关CPU状态并不能达到" +
//         //                   "提升手机性能的效果，官方自带的CPU调度相对比较保守，事实上还会有一些不好的体验",
//         //               style: TextStyle(
//         //                   color: Colors.black54,
//         //                   fontWeight: FontWeight.bold,
//         //                   fontSize: 12),
//         //             ),
//         //           )
//         //         ],
//         //       ),
//         //     ),
//         //     onTap: () {
//         //       setState(() {});
//         //     },
//         //   ),
//         // ),
//         MaterialClipRRect(
//           child: InkWell(
//             borderRadius: BorderRadius.circular(4.0),
//             child: SizedBox(
//               width: MediaQuery.of(context).size.width,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Center(
//                     child: Text(
//                       "高通温控管理",
//                       style: TextStyle(
//                         color: Colors.black54,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 40,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
//                         Padding(
//                           padding:
//                               const EdgeInsets.fromLTRB(8.0, 4.0, 0.0, 8.0),
//                           child: Text(
//                             "核心温控状态",
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         Switch(
//                           value: bval0,
//                           onChanged: (bool val) {
//                             bval0 = !bval0;
//                             bval0
//                                 ? CustomProcess.exec(
//                                     "chmod -R 0644 /sys/module/msm_thermal/core_control/enabled\n" +
//                                         "echo 1 > /sys/module/msm_thermal/core_control/enabled\n" +
//                                         "chmod -R 0444 /sys/module/msm_thermal/core_control/enabled\n")
//                                 : CustomProcess.exec(
//                                     "chmod -R 0644 /sys/module/msm_thermal/core_control/enabled\n" +
//                                         "echo 0 > /sys/module/msm_thermal/core_control/enabled\n" +
//                                         "chmod -R 0444 /sys/module/msm_thermal/core_control/enabled\n");
//                             setState(() {});
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 40,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
//                         Padding(
//                           padding:
//                               const EdgeInsets.fromLTRB(8.0, 4.0, 0.0, 8.0),
//                           child: Text(
//                             "VDD温控状态",
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         Switch(
//                           value: bval1,
//                           onChanged: (bool val) {
//                             bval1 = !bval1;
//                             bval1
//                                 ? CustomProcess.exec(
//                                     "chmod -R 0644 /sys/module/msm_thermal/vdd_restriction/enabled\n" +
//                                         "echo 1 > /sys/module/msm_thermal/vdd_restriction/enabled\n" +
//                                         "chmod -R 0444 /sys/module/msm_thermal/vdd_restriction/enabled\n")
//                                 : CustomProcess.exec(
//                                     "chmod -R 0644 /sys/module/msm_thermal/vdd_restriction/enabled\n" +
//                                         "echo 0 > /sys/module/msm_thermal/vdd_restriction/enabled\n" +
//                                         "chmod -R 0444 /sys/module/msm_thermal/vdd_restriction/enabled\n");
//                             setState(() {});
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 40,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
//                         Padding(
//                           padding:
//                               const EdgeInsets.fromLTRB(8.0, 4.0, 0.0, 8.0),
//                           child: Text(
//                             "Soc温控状态",
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         Switch(
//                           value: bval2,
//                           onChanged: (bool val) {
//                             bval2 = !bval2;

//                             bval2
//                                 ? CustomProcess.exec(
//                                     "chmod -R 0644 /sys/module/msm_thermal/parameters/enabled\n" +
//                                         "echo Y > /sys/module/msm_thermal/parameters/enabled\n" +
//                                         "chmod -R 0444 /sys/module/msm_thermal/parameters/enabled\n")
//                                 : CustomProcess.exec(
//                                     "chmod -R 0644 /sys/module/msm_thermal/parameters/enabled\n" +
//                                         "echo N > /sys/module/msm_thermal/parameters/enabled\n" +
//                                         "chmod -R 0444 /sys/module/msm_thermal/parameters/enabled\n");
//                             setState(() {});
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                   Center(
//                     child: Padding(
//                       padding: EdgeInsets.all(4),
//                       child: Text(
//                         "关闭核心温控才能自由的设置CPU在线状态，",
//                         style: TextStyle(
//                             color: Colors.black54,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 12),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
