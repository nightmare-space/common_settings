// import 'dart:async';
// import 'package:event_bus/event_bus.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_toolkit/utils/process.dart';
// import 'package:flutter_toolkit/widgets/material_cliprrect.dart';
// import 'package:flutter_toolkit/widgets/my_canvas.dart';

// import 'cpu_temperature_controll.dart';

// class CpuControll extends StatefulWidget {
//   @override
//   _CpuControllState createState() => _CpuControllState();
// }

// EventBus cpuevent;
// List<String> cpuinfo = [];

// class _CpuControllState extends State<CpuControll>
//     with SingleTickerProviderStateMixin {
//   int _count = 0;
//   final List<Widget> _list1 = <Widget>[];
//   final List<Widget> _list2 = <Widget>[];

//   List<bool> _bool = [];
//   Future<Null> getmess() async {
//     _count = 8; //8核心
//     for (int i = 1; i <= _count; i++) {
//       _bool.add(false);
//       if (i % 2 != 0) {
//         _list1.add(But(
//           index: i,
//           bool: _bool,
//         ));

//         if (i == 3) {
//           _list1.add(
//             Divider(
//               height: 8,
//             ),
//           );
//         }
//       } else {
//         _list2.add(But(
//           index: i,
//           bool: _bool,
//         ));

//         if (i == 4) {
//           _list2.add(
//             Divider(
//               height: 8,
//             ),
//           );
//         }
//       }
//     }

//     if (context != null) setState(() {});
//   }

//   @override
//   void initState() {
//     super.initState();
//     cpuevent = EventBus();
//     cpuinfo.clear();
//     getcpumes();
//     getmess();
//   }

//   // Future<dynamic> handler(MethodCall call) async {
//   //   if (call?.method == 'Console') {
//   //     cpuinfo = call.arguments.toString().split("\n");
//   //     cpuevent.fire(But());
//   //     //print(call.arguments);
//   //     // if (call.arguments != "")
//   //     //   _list.add(Text(
//   //     //     call.arguments,
//   //     //     style: TextStyle(color: Colors.white, fontSize: 16),
//   //     //   ));
//   //     setState(() {});
//   //   }
//   // }

//   Future getcpumes() async {
//     await sendcmd();
//     setState(() {});
//     while (true) {
//       if (context != null)
//         await Future<void>.delayed(Duration(milliseconds: 1000), () {
//           sendcmd();
//         });
//       else
//         break;
//     }
//   }

//   Future sendcmd() async {
//     String result = await CustomProcess.exec(
//         "cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq\n" +
//             "cat /sys/devices/system/cpu/cpu1/cpufreq/scaling_cur_freq\n" +
//             "cat /sys/devices/system/cpu/cpu2/cpufreq/scaling_cur_freq\n" +
//             "cat /sys/devices/system/cpu/cpu3/cpufreq/scaling_cur_freq\n" +
//             "cat /sys/devices/system/cpu/cpu4/cpufreq/scaling_cur_freq\n" +
//             "cat /sys/devices/system/cpu/cpu5/cpufreq/scaling_cur_freq\n" +
//             "cat /sys/devices/system/cpu/cpu6/cpufreq/scaling_cur_freq\n" +
//             "cat /sys/devices/system/cpu/cpu7/cpufreq/scaling_cur_freq\n" +
//             "cat /sys/devices/system/cpu/cpu0/core_ctl/global_state | busybox grep \"Busy\" | busybox sed 's/Busy%: //g'");
//     cpuinfo = result.split("\n");
//     if (context != null) cpuevent.fire(But());
//   }

//   @override
//   void dispose() {
//     cpuevent.destroy();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       physics: NeverScrollableScrollPhysics(),
//       padding: EdgeInsets.all(0.0),
//       children: <Widget>[
//         MaterialClipRRect(
//           child: SizedBox(
//             height: MediaQuery.of(context).size.width * 0.9,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width * 0.5 - 8,
//                   child: ListView(
//                     padding: EdgeInsets.all(0.0),
//                     physics: NeverScrollableScrollPhysics(),
//                     children: _list1,
//                   ),
//                 ),
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width * 0.5 - 8,
//                   child: ListView(
//                     physics: NeverScrollableScrollPhysics(),
//                     padding: EdgeInsets.all(0.0),
//                     children: _list2,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         CpuTemperatureControll(),
//         // CpuScriptExec(),
//       ],
//     );
//   }
// }

// class But extends StatefulWidget {
//   final List bool;
//   final int index;

//   const But({
//     Key key,
//     this.bool,
//     this.index,
//   }) : super(key: key);
//   @override
//   _ButState createState() => _ButState();
// }

// class _ButState extends State<But> with TickerProviderStateMixin {
//   String _freqMin = "";
//   String _freqMax = "";
//   String _freqCur = "";
//   //String _valuepre;
//   String _dutyRatio = "0"; //cpu占空比
//   List _bool;

//   AnimationController _logo;

//   Animation<double> _dialog;

//   Color _color = Colors.green;
//   initAnima() {
//     _logo =
//         AnimationController(duration: Duration(milliseconds: 600), vsync: this);
//     _dialog = Tween<double>(
//       begin: 0,
//       end: 100,
//     ).animate(_logo);
//     _dialog.addListener(() {
//       setState(() {});
//     });
//   }

//   @override
//   void initState() {
//     _bool = widget.bool;
//     _color = Colors.green;
//     initAnima();
//     cpuevent.on<But>().listen((event) {
//       //print(cpuinfo);
//       // _valuepre = _valuecur;
//       _freqCur = cpuinfo[widget.index - 1];
//       String _oncpupre = _dutyRatio;
//       _dutyRatio = cpuinfo[widget.index + 7];
//       setState(() {});

//       _dialog = Tween<double>(
//         begin: double.parse(_oncpupre),
//         end: double.parse(_dutyRatio),
//       ).animate(_logo);

//       anima();
//       // //set();
//       // // setState(() {

//       // // });
//     });
//     set();

//     super.initState();
//   }

//   void anima() {
//     _logo.reset();
//     _logo.forward();
//   }

//   Future set() async {
//     String a = await CustomProcess.exec(
//         "cat /sys/devices/system/cpu/cpu${widget.index - 1}/online\n");
//     a == "1" ? _bool[widget.index - 1] = true : _bool[widget.index - 1] = false;

//     _freqMin = await CustomProcess.exec(
//         "cat /sys/devices/system/cpu/cpu${widget.index - 1}/cpufreq/scaling_min_freq\n");
//     _freqMax = await CustomProcess.exec(
//         "cat /sys/devices/system/cpu/cpu${widget.index - 1}//cpufreq/scaling_max_freq\n");

//     //_value = await CustomProcess.exec("",
//     //    "cat /sys/devices/system/cpu/cpu${widget.a - 1}/cpufreq/scaling_cur_freq");
//     if (context != null) {
//       setState(() {});
//     }
//   }

//   @override
//   void dispose() {
//     _logo.dispose();
//     super.dispose();
//   }

//   double waterHeight = 0.0;
//   @override
//   Widget build(BuildContext context) {
//     _dialog.value < 50
//         ? _color =
//             Color.fromRGBO((255 * (_dialog.value / 50)).toInt(), 255, 0, 1)
//         : _color = Color.fromRGBO(
//             255, 255 - (255 * (_dialog.value / 50)).toInt(), 0, 1);
//     return SizedBox(
//       height: MediaQuery.of(context).size.width * 0.2,
//       child: InkWell(
//         onTap: () {},
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Checkbox(
//                   value: _bool[widget.index - 1],
//                   activeColor: Color(0xff213349),
//                   onChanged: (bool val) {
//                     _bool[widget.index - 1] = !_bool[widget.index - 1];
//                     val
//                         ? CustomProcess.exec(
//                             "chmod -R 0644 /sys/devices/system/cpu/cpu${widget.index - 1}/online\n" +
//                                 "echo 1 > /sys/devices/system/cpu/cpu${widget.index - 1}/online\n" +
//                                 "chmod -R 0444 /sys/devices/system/cpu/cpu${widget.index - 1}/online\n")
//                         : CustomProcess.exec(
//                             "chmod -R 0644 /sys/devices/system/cpu/cpu${widget.index - 1}/online\n" +
//                                 "echo 0 > /sys/devices/system/cpu/cpu${widget.index - 1}/online\n" +
//                                 "chmod -R 0444 /sys/devices/system/cpu/cpu${widget.index - 1}/online\n");
//                     setState(() {});
//                   },
//                 ),
//                 Text("CPU${widget.index}"),
//               ],
//             ),
//             CustomPaint(
//               child: SizedBox(
//                 width: 45,
//                 height: 45,
//                 child: Center(
//                   child: Text(
//                     "${_dialog.value.toInt()}",
//                     style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//               painter: CircleProgressBarPainter(
//                 (_dialog.value / 100 * 360).toInt(),
//                 3.0,
//                 _color,
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(left: 5),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Text(_freqCur),
//                   _freqMax != ""
//                       ? Text(
//                           (int.parse(_freqMin) / 1000).floor().toString() +
//                               "~" +
//                               (int.parse(_freqMax) / 1000).floor().toString() +
//                               " Mhz",
//                           style: TextStyle(
//                             color: Colors.black54,
//                             fontSize: 10.0,
//                           ),
//                         )
//                       : Text("")
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
