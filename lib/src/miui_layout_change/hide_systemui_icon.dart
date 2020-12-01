import 'package:flutter/material.dart';
import 'package:global_repository/global_repository.dart';

class HideSystemUiIcon extends StatefulWidget {
  @override
  _HideSystemUiIconState createState() => _HideSystemUiIconState();
}

class _HideSystemUiIconState extends State<HideSystemUiIcon> {
  String _str;
  bool bluetooth;
  bool headset;
  bool hotspot;
  bool alarmclock;
  bool clock;
  bool battery;
  bool wifi;

  Future<void> set() async {
    _str = await NiProcess.exec('settings get secure icon_blacklist\n');
    for (final String _strr in _str.split(',')) {
      if (_strr == 'bluetooth') {
        bluetooth = false;
      }
      if (_strr == 'headset') {
        headset = false;
      }
      if (_strr == 'hotspot') {
        hotspot = false;
      }
      if (_strr == 'alarm_clock') {
        alarmclock = false;
      }
      if (_strr == 'clock') {
        clock = false;
      }
      if (_strr == 'battery') {
        battery = false;
      }
      if (_strr == 'wifi') {
        wifi = false;
      }
    }
    if (context != null) {
      setState(() {});
    }
  }

  @override
  void initState() {
    bluetooth = true;
    headset = true;
    hotspot = true;
    alarmclock = true;
    clock = true;
    battery = true;
    wifi = true;
    set();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> change(String str, bool val) async {
    if (val) {
      final List<String> _list = _str.split(',')..remove(str);
      if (_list.isEmpty) {
        await NiProcess.exec('settings put secure icon_blacklist 0\n');
      } else
        await NiProcess.exec(
            'settings put secure icon_blacklist ${_list.join(',')}\n');
      set();
    } else {
      final List<String> _list = _str.split(',')..add(str);
      if (_str == '0') {
        _list.remove('0');
      }
      await NiProcess.exec(
          'settings put secure icon_blacklist ${_list.join(',')}\n');
      set();
    }
  }

  Widget item(
    String str,
    bool bval,
    Function fun,
  ) {
    return Material(
      color: Colors.white,
      child: Ink(
        child: InkWell(
          onTap: () {
            fun();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(2.0, 0.0, 0.0, 0.0),
                child: Text(
                  str,
                  style: const TextStyle(
                    color: Color(0xff000000),
                    fontSize: 14.0,
                  ),
                ),
              ),
              Checkbox(
                value: bval,
                activeColor: const Color(0xff213349),
                onChanged: (bool val) {
                  fun();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: ListBody(
          children: <Widget>[
            item(bluetooth ? '蓝牙图标(显示)' : '蓝牙图标(隐藏)', bluetooth, () {
              bluetooth = !bluetooth;
              change('bluetooth', bluetooth);
              setState(() {});
            }),
            item(headset ? '耳机图标(显示)' : '耳机图标(隐藏)', headset, () {
              headset = !headset;
              setState(() {});
              change('headset', headset);
            }),
            item(hotspot ? '热点图标(显示)' : '热点图标(隐藏)', hotspot, () {
              hotspot = !hotspot;
              setState(() {});
              change('hotspot', hotspot);
            }),
            item(alarmclock ? '闹钟图标(显示)' : '闹钟图标(隐藏)', alarmclock, () {
              alarmclock = !alarmclock;
              setState(() {});
              change('alarm_clock', alarmclock);
            }),
            item(clock ? '时间图标(显示)' : '时间图标(隐藏)', clock, () {
              clock = !clock;
              setState(() {});
              change('clock', clock);
            }),
            item(battery ? '电池图标(显示)' : '电池图标(隐藏)', battery, () {
              battery = !battery;
              setState(() {
                change('battery', battery);
              });
            }),
            item(wifi ? 'WIFI图标(显示)' : 'WIFI图标(隐藏)', wifi, () {
              wifi = !wifi;
              setState(() {
                change('wifi', wifi);
              });
            }),
          ],
        ),
      ),
    );
  }
}
