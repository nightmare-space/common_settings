import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';

class ChangeMiuiDesktop extends StatefulWidget {
  @override
  _ChangeMiuiDesktopState createState() => _ChangeMiuiDesktopState();
}

class _ChangeMiuiDesktopState extends State<ChangeMiuiDesktop> {
  String zhuomianpre;
  Future<void> setdesk(int row, int column, [int count]) async {
    // final String _count=count!=null?"    <integer name='config_folder_columns_count'>$count</integer>\n":'';
    // final String _ini = "<?xml version='1.0' encoding='utf-8' standalone='yes' ?>\n"
    //     '<MIUI_Theme_Values>\n'
    //     "    <integer name='config_cell_count_x'>$row</integer>\n"
    //     "    <integer name='config_cell_count_y'>$column</integer>\n"
    //     '$_count'
    //     '</MIUI_Theme_Values>';
    set('$row$column$count');
    if (File('/data/system/theme/com.miui.home').existsSync()) {
      // await CustomProcess.exec(
      //     'mount -o rw,remount /system\n' +
      //         'echo \'$_ini\'>/system/usr/Nightmare/theme_values.xml\n' +
      //         '/system/usr/Nightmare/mengyan -j -7 /data/system/theme/com.miui.home /system/usr/Nightmare/theme_values.xml\n' +
      //         'chmod -R 0755 /data/system/theme/com.miui.home\n' +
      //         'rm -rf /system/usr/Nightmare/theme_values.xml\n' +
      //         'busybox killall com.miui.home\n');
    } else {
      // await CustomProcess.exec(
      //     'mount -o rw,remount /system\n' +
      //         'echo \'$_ini\'>/system/usr/Nightmare/theme_values.xml\n' +
      //         '/system/usr/Nightmare/mengyan -j -7 /system/media/theme/default/com.miui.home /system/usr/Nightmare/theme_values.xml\n' +
      //         'chmod -R 0755 /system/media/theme/default/com.miui.home\n' +
      //         'rm -rf /system/usr/Nightmare/theme_values.xml\n' +
      //         'busybox killall com.miui.home\n');
    }
  }

  Future<void> set(String shi, [Function fun]) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // if (prefs.getString('zhuomian') == null) {
      // prefs.setString('zhuomian', '453');
    // } else {
      // if (shi == 'a') {
      // } else {
        // prefs.setString('zhuomian', shi);
      // }
    // }
    // zhuomianpre = prefs.getString('zhuomian');
    // print(prefs.getString('zhuomian'));
    setState(() {});
    if (fun != null) {
      fun();
    }
  }

  @override
  void initState() {
    desktoprow = 3.0;
    desktopcolumn = 3.0;
    folder=3.0;
    set('a', () {
      desktoprow = double.parse(zhuomianpre.substring(0, 1));
      desktopcolumn = double.parse(zhuomianpre.substring(1, 2));
      folder = double.parse(zhuomianpre.substring(2, 3));
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  double desktoprow;
  double desktopcolumn;
  double folder;
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
        child: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const Padding(
              padding:  EdgeInsets.fromLTRB(2.0, 2.0, 0.0, 0.0),
              child: Center(
                child: Text(
                  '提示：点击返回桌面后生效',
                  style:  TextStyle(
                    color: Color(0xff000000),
                    fontSize: 14.0,
                  ),
                ),
              )),
          Center(
            child: Text(
              '横向图标个数${desktoprow.toInt()}',
              style: const TextStyle(fontSize: 18),
            ),
          ),
          Slider(
            value: desktoprow,
            max: 7.0,
            min: 3.0,
            divisions: 4,
            activeColor: const Color(0xff303030),
            onChanged: (double val) {
              desktoprow = val;
              setState(() {});
            },
            onChangeEnd: (double a) {
              setdesk(desktoprow.toInt(), desktopcolumn.toInt(),folder.toInt());
            },
          ),
          Center(
            child: Text(
              '竖向向图标个数${desktopcolumn.toInt()}',
              style: const TextStyle(fontSize: 18),
            ),
          ),
          Slider(
            value: desktopcolumn,
            max: 7.0,
            min: 3.0,
            divisions: 4,
            activeColor: const Color(0xff303030),
            onChanged: (double val) {
              desktopcolumn = val;
              setState(() {});
            },
            onChangeEnd: (double a) {
              setdesk(desktoprow.toInt(), desktopcolumn.toInt(),folder.toInt());
            },
          ),
          Center(
            child: Text(
              '文件夹内图标个数${folder.toInt()}',
              style: const TextStyle(fontSize: 18),
            ),
          ),
          Slider(
            value: folder,
            max: 7.0,
            min: 3.0,
            divisions: 4,
            activeColor: const Color(0xff303030),
            onChanged: (double val) {
              folder = val;
              setState(() {});
            },
            onChangeEnd: (double a) {
              setdesk(desktoprow.toInt(), desktopcolumn.toInt(),folder.toInt());
            },
          ),
        ],
      ),
    ));
  }
}
// Align(
//   alignment: Alignment.bottomCenter,
//   child: Container(
//     width: 160,
//     height: 40,
//     child: Card(
//       color: Colors.green,
//       shape: new RoundedRectangleBorder(
//         borderRadius: new BorderRadius.circular(20.0),
//       ),
//       elevation: 1,
//       child: InkWell(
//         borderRadius: BorderRadius.circular(25),
//         onTap: () {
//           if ('${desktoprow.toInt()}${desktopcolumn.toInt()}' ==
//               zhuomian_pre) {
//             PlatformChannel.Toast.invokeMethod<void>(
//                 '更改一下啊喂！', {'Emoji': 0x1F624});
//           } else {
//             eventBus.fire(
//               ExplosionWidget(),
//             );
//           }
//         },
//         child: Container(
//           height: 40 * 2.75 / window.devicePixelRatio,
//           width: MediaQuery.of(context).size.width,
//           child: Center(
//             child: Text(
//               '应用',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 14.0 * 2.75 / window.devicePixelRatio,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ),
//       ),
//     ),
//   ),
// ),
