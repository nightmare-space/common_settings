// import 'dart:io';

// import 'package:flutter/material.dart';

// class AnimaModify extends StatefulWidget {
//   @override
//   _AnimaModifyState createState() => _AnimaModifyState();
// }

// class _AnimaModifyState extends State<AnimaModify> {
//   // String tmpPath = '${Config.filesPath}/PracticalTool';
//   String animaPath = '/system/media/bootanimation.zip';
//   Size animaSize;
//   int fps = 0;
//   String curFramePath;
//   List<String> desc = <String>[];
//   Duration duration;
//   DateTime dateTime;
//   @override
//   void initState() {
//     super.initState();
//     previewAnimation();
//   }

//   Future<void> previewAnimation() async {
//     // var tmpPath="/system/media/bootanimation.zip";
//     Directory(tmpPath).create();
//     await Process.run('sh', <String>[
//       '-c',
//       'cp -rf $animaPath $tmpPath\nmkdir $tmpPath/bootanimation\nunzip $animaPath -d $tmpPath/bootanimation/'
//     ]);
//     await getInfoList();
//     // cacheAllImg();
//   }

//   Future<void> getInfoList() async {
//     desc = await File('$tmpPath/bootanimation/desc.txt').readAsLines();
//     animaSize = Size(double.tryParse(desc[0].split(' ')[0]),
//         double.tryParse(desc[0].split(' ')[1]));
//     fps = int.tryParse(desc[0].split(' ')[2]);
//     duration = Duration(microseconds: 1000000 ~/ fps);
//     desc.removeAt(0);
//     setState(() {});
//   }

//   Future<void> cacheAllImg() async {
//     for (int i = 0; i < desc.length; i++) {
//       final List<FileSystemEntity> list =
//           Directory("$tmpPath/bootanimation/${desc[i].split(" ").last}/")
//               .listSync();
//       while (list.isNotEmpty) {
//         await precacheImage(FileImage(File(list.first.path)), context);
//         list.removeAt(0);
//       }
//     }
//   }

//   Future<void> playNextFrame() async {
//     // var tmp = desc.first.split(" ");
//     // desc.removeAt(0);
//     // int index = 1;
//     // List<FileSystemEntity> list =
//     //     Directory("$tmpPath/bootanimation/${tmp.last}/").listSync();
//     // List<String> paths = [];
//     // list.forEach((v) {
//     //   paths.add(v.path);
//     // });
//     // paths.sort((a, b) => a.split("/").last.compareTo(b.split("/").last));
//     // print(paths);
//     // for (int i = 0; i <= int.tryParse(tmp[2]); i++) {
//     //   List tmpPaths = [];
//     //   for (int i = 0; i < paths.length; i++) {
//     //     tmpPaths.add(paths[i]);
//     //   }
//     //   while (tmpPaths.isNotEmpty) {
//     //     curFramePath = tmpPaths.first;
//     //     tmpPaths.removeAt(0);
//     //     await precacheImage(FileImage(File(curFramePath)), context);
//     //     if (dateTime == null) {
//     //       setState(() {});
//     //       await Future<void>.delayed(duration, () {});
//     //       dateTime = DateTime.now();
//     //     } else {
//     //       int tmp = duration.inMicroseconds -
//     //           DateTime.now().difference(dateTime).inMicroseconds;
//     //       if (tmp > 0) {
//     //         setState(() {});
//     //         dateTime = DateTime.now();
//     //         await Future<void>.delayed(Duration(microseconds: tmp), () {});
//     //       } else {
//     //         setState(() {});
//     //         dateTime = DateTime.now();
//     //         await Future<void>.delayed(Duration(microseconds: 30000), () {});

//     //       }
//     //     }
//     //     // if (File("$tmpPath/bootanimation/${tmp.split(" ").last}/0$index.png")
//     //     //     .existsSync()) {
//     //     //   break;
//     //     // } else
//     //     //   index++;
//     //   }
//     // }
//     // // int time = duration.inMicroseconds -
//     // //     DateTime.now().difference(dateTime).inMicroseconds;
//     // // if (time > 0) {
//     // await Future<void>.delayed(duration, () {});
//     // // } else {
//     // // }
//     // if (desc.isNotEmpty) playNextFrame();
//     // print(index);
//     // curFramePath = "$tmpPath/bootanimation/${tmp.split(" ").last}/0$index.png";
//     // setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     // print(duration.inMicroseconds);
//     if (animaSize == null)
//       return SpinKitThreeBounce(
//         color: Theme.of(context).accentColor,
//       );
//     return Scaffold(
//       // backgroundColor: Colors.black,
//       floatingActionButton: FloatingActionButton(
//           onPressed: () async {
//             await getInfoList();
//             playNextFrame();
//           },
//           child: const Text('')),
//       appBar: AppBar(
//         title: const Text('开机动画编辑器'),
//         elevation: 2.0,
//       ),
//       body: SizedBox(
//         // height: MediaQuery.of(context).size.height,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             Center(
//               child: SizedBox(
//                 height: MediaQuery.of(context).size.height -
//                     kToolbarHeight -
//                     MediaQuery.of(context).viewPadding.top -
//                     40.0,
//                 child: AspectRatio(
//                   aspectRatio: animaSize.width / animaSize.height,
//                   child: Container(
//                     color: Colors.grey,
//                     child: curFramePath != null
//                         ? Image.file(File(curFramePath))
//                         : const SizedBox(),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 40.0,
//               child: Text(
//                   '动画宽:${animaSize.width},高:宽${animaSize.height},播放帧率:$fps'),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
