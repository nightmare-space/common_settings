import 'package:flutter/material.dart';
import 'package:global_repository/global_repository.dart';

class ChangeTrafficState extends StatefulWidget {
  @override
  _ChangeTrafficStateState createState() => _ChangeTrafficStateState();
}

class _ChangeTrafficStateState extends State<ChangeTrafficState> {
  String shijian;
  String shijianpre;
  void handleSingleChanged(String value) {
    setState(() {
      shijian = value.toString();
    });

    switch (shijian) {
      case '0':
        NiProcess.exec('settings put system M_X_bar_traffic_style 0\n');
        break;
      case '1':
        NiProcess.exec('settings put system M_X_bar_traffic_style 1\n');
        break;
      case '2':
        NiProcess.exec('settings put system M_X_bar_traffic_style 2\n');
        break;
      case '3':
        NiProcess.exec('settings put system M_X_bar_traffic_style 3\n');
        break;
    }
  }

  Future<void> set(String shi) async {
    shijian =
        await NiProcess.exec('settings get system M_X_bar_traffic_style\n');
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
                          '不显示',
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
                          '显示上传速度',
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
                    handleSingleChanged('2');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.fromLTRB(2.0, 0.0, 0.0, 0.0),
                        child: Text(
                          '显示下载速度',
                          style: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      Radio<String>(
                          value: '2',
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
                          '显示上传/下载速度',
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
          ],
        ),
      ),
    );
  }
}
