import 'package:flutter/material.dart';
import 'package:global_repository/global_repository.dart';

class ChangeBatteryStyle extends StatefulWidget {
  @override
  _ChangeBatteryStyleState createState() => _ChangeBatteryStyleState();
}

class _ChangeBatteryStyleState extends State<ChangeBatteryStyle> {
  String shijian;
  String shijianpre;
  void handleSingleChanged(String value) {
    setState(() {
      shijian = value.toString();
    });

    switch (shijian) {
      case '0':
        NiProcess.exec('settings put system battery_indicator_style 0\n');
        break;
      case '1':
        NiProcess.exec('settings put system battery_indicator_style 1\n');
        break;
      case '3':
        NiProcess.exec('settings put system battery_indicator_style 3\n');
        break;
      case '4':
        NiProcess.exec('settings put system battery_indicator_style 4\n');
        break;
    }
  }

  Future<void> set(String shi) async {
    shijian =
        await NiProcess.exec('settings get system battery_indicator_style\n');
    setState(() {});
  }

  @override
  void initState() {
    shijian ??= '2';
    set('a');
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: ListBody(
          children: <Widget>[
            Material(
              color: Colors.white,
              child: Ink(
                child: InkWell(
                  onTap: () {
                    handleSingleChanged('0');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.fromLTRB(2.0, 0.0, 0.0, 0.0),
                        child: Text(
                          '图形方式',
                          style: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      Radio<String>(
                          value: '0',
                          groupValue: shijian,
                          onChanged: handleSingleChanged),
                    ],
                  ),
                ),
              ),
            ),
            Material(
              color: Colors.white,
              child: Ink(
                child: InkWell(
                  onTap: () {
                    handleSingleChanged('1');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.fromLTRB(2.0, 0.0, 0.0, 0.0),
                        child: Text(
                          '数字内显',
                          style: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      Radio<String>(
                          value: '1',
                          groupValue: shijian,
                          onChanged: handleSingleChanged),
                    ],
                  ),
                ),
              ),
            ),
            Material(
              color: Colors.white,
              child: Ink(
                child: InkWell(
                  onTap: () {
                    handleSingleChanged('3');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.fromLTRB(2.0, 0.0, 0.0, 0.0),
                        child: Text(
                          '数字外显',
                          style: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      Radio<String>(
                          value: '3',
                          groupValue: shijian,
                          onChanged: handleSingleChanged),
                    ],
                  ),
                ),
              ),
            ),
            Material(
              color: Colors.white,
              child: Ink(
                child: InkWell(
                  onTap: () {
                    handleSingleChanged('4');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.fromLTRB(2.0, 0.0, 0.0, 0.0),
                        child: Text(
                          '顶部方式（刘海屏无效）',
                          style: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      Radio<String>(
                          value: '4',
                          groupValue: shijian,
                          onChanged: handleSingleChanged),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
