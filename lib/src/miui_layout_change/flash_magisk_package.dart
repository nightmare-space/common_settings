// import 'package:event_bus/event_bus.dart';
// import 'package:flutter/material.dart';

// class Onemian extends StatefulWidget {
//   const Onemian({Key key, this.path}) : super(key: key);
//   final String path;

//   @override
//   _OnemianState createState() => _OnemianState();
// }

// class _OnemianState extends State<Onemian> {
//   EventBus eventBus = EventBus();
//   String _path;
//   String filepath;
//   @override
//   void initState() {
//     filepath ??= '';
//     _path = widget.path;
//     mg();
//     super.initState();
//   }

//   Future<void> mg() async {
//     filepath = await NiProcess.exec('''mount -o rw,remount /system
//             cp $_path /system/usr/Nightmare
//             chmod -R 0777 /system/usr/Nightmare/*.zip
//             rm -rf /system/usr/Nightmare/META-INF
//             busybox unzip /system/usr/Nightmare/*.zip META-INF/com/google/android/* -d /system/usr/Nightmare
//             busybox sh /system/usr/Nightmare/META-INF/com/google/android/update-binary dummy 1 /system/usr/Nightmare/*.zip''');
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         const Padding(
//           padding: EdgeInsets.only(bottom: 10),
//           child: Center(
//             child: Text(
//               '面具模块刷入',
//               style: TextStyle(
//                 color: Color(0xff000000),
//                 fontSize: 16.0,
//               ),
//             ),
//           ),
//         ),
//         SizedBox(
//           height: 360,
//           child: SingleChildScrollView(
//             child: Text(
//               filepath,
//               style: const TextStyle(
//                   color: Color(0xff000000),
//                   fontSize: 16.0,
//                   fontWeight: FontWeight.bold),
//             ),
//           ),
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: <Widget>[
//             Center(
//               child: Container(
//                 width: 120,
//                 height: 40,
//                 child: Card(
//                     color: Colors.green,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(
//                           25.0), //如果[borderRadius]被指定，那么[type]属性不能是 [MaterialType.circle]。
//                     ),
//                     elevation: 1,
//                     child: InkWell(
//                       borderRadius: BorderRadius.circular(25),
//                       onTap: () {
//                         eventBus.fire(
//                           const ExplosionWidget(),
//                         );
//                         Future<void>.delayed(const Duration(milliseconds: 1000),
//                             () {
//                           Navigator.of(context).pop();
//                         });
//                       },
//                       child: Container(
//                         height: 40,
//                         width: MediaQuery.of(context).size.width,
//                         child: const Center(
//                           child: Text(
//                             '关闭',
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
//         )
//       ],
//     );
//   }
// }
