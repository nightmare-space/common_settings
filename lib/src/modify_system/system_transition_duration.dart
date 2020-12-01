import 'package:flutter/material.dart';
import 'package:global_repository/global_repository.dart';

class SystemTransitionDuration extends StatefulWidget {
  @override
  _SystemTransitionDurationState createState() =>
      _SystemTransitionDurationState();
}

class _SystemTransitionDurationState extends State<SystemTransitionDuration> {
  String text0;
  String text1;
  String text2;
  String text3;

  Future<void> set() async {
    text0 =
        await NiProcess.exec('settings get global window_animation_scale\n');
    text0 == '' ? text0 = '1.0' : print('');
    text1 = await NiProcess.exec(
        'settings get global transition_animation_scale\n');

    text1 == '' ? text1 = '1.0' : print('');
    text2 =
        await NiProcess.exec('settings get global animator_duration_scale\n');
    text2 == 'null' ? text2 = '1.0' : print('');
    setState(() {});
  }

  @override
  void initState() {
    text0 = '';
    text1 = '';
    text2 = '';
    text3 = '0.5';
    set();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void sett(String text, double dou, String str) {
    if (text == '1') {
      text0 = '${(double.parse(text0) * 10 + dou * 10) / 10}';

      NiProcess.exec('settings put global $str ${double.parse(text0)}\n');
      setState(() {});
    }

    if (text == '2') {
      text1 = '${(double.parse(text1) * 10 + dou * 10) / 10}';

      NiProcess.exec('settings put global $str ${double.parse(text1)}\n');
      setState(() {});
    }
    if (text == '3') {
      text2 = '${(double.parse(text2) * 10 + dou * 10) / 10}';

      NiProcess.exec('settings put global $str ${double.parse(text2)}\n');
      setState(() {});
    }

    if (text == '4') {
      text3 = '${(double.parse(text3) * 10 + dou * 10) / 10}';

      setState(() {});
    }
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
                  child: SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.fromLTRB(2.0, 0.0, 0.0, 0.0),
                      child: Text(
                        '窗口动画缩放',
                        style: TextStyle(
                          color: Color(0xff000000),
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25)),
                        height: 36,
                        width: 36,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(25),
                          child: const Icon(Icons.remove),
                          onTap: () {
                            if (double.parse(text0) >= double.parse(text3)) {
                              sett('1', -double.parse(text3.substring(0, 3)),
                                  'window_animation_scale');
                            } else {
                              NiToast.showToast('减不了这么多');
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                        width: 30,
                        child: Center(
                          child: Text(text0),
                        )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25)),
                        height: 36,
                        width: 36,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(25),
                          child: const Icon(Icons.add),
                          onTap: () {
                            sett('1', double.parse(text3.substring(0, 3)),
                                'window_animation_scale');
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )),
            ),
            Material(
              color: Colors.white,
              child: Ink(
                  child: SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.fromLTRB(2.0, 0.0, 0.0, 0.0),
                      child: Text(
                        '过度动画缩放',
                        style: TextStyle(
                          color: Color(0xff000000),
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25)),
                        height: 36,
                        width: 36,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(25),
                          child: const Icon(Icons.remove),
                          onTap: () {
                            if (double.parse(text1) >= double.parse(text3)) {
                              sett('2', -double.parse(text3.substring(0, 3)),
                                  'transition_animation_scale');
                            } else {
                              NiToast.showToast('减不了这么多');
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                        width: 50,
                        child: Center(
                          child: Text(text1),
                        )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25)),
                        height: 36,
                        width: 36,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(25),
                          child: const Icon(Icons.add),
                          onTap: () {
                            sett('2', double.parse(text3.substring(0, 3)),
                                'transition_animation_scale');
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )),
            ),
            Material(
              color: Colors.white,
              child: Ink(
                child: SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.fromLTRB(2.0, 0.0, 0.0, 0.0),
                        child: Text(
                          'Animator时长缩放',
                          style: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25)),
                          height: 36,
                          width: 36,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(25),
                            child: const Icon(Icons.remove),
                            onTap: () {
                              if (double.parse(text2) >= double.parse(text3)) {
                                sett('3', -double.parse(text3.substring(0, 3)),
                                    'animator_duration_scale');
                              } else {
                                NiToast.showToast('减不了这么多');
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                          width: 50,
                          child: Center(
                            child: Text(text2),
                          )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25)),
                          height: 36,
                          width: 36,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(25),
                            child: const Icon(Icons.add),
                            onTap: () {
                              sett('3', double.parse(text3.substring(0, 3)),
                                  'animator_duration_scale');
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Divider(),
            Material(
              color: Colors.white,
              child: Ink(
                child: SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.fromLTRB(2.0, 0.0, 0.0, 0.0),
                        child: Text(
                          '加减的数值',
                          style: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25)),
                          height: 36,
                          width: 36,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(25),
                            child: const Icon(Icons.remove),
                            onTap: () {
                              if (double.parse(text2) >= 0) {
                                sett('4', -0.1, 'animator_duration_scale');
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                          width: 50,
                          child: Center(
                            child: Text(text3),
                          )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25)),
                          height: 36,
                          width: 36,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(25),
                            child: const Icon(Icons.add),
                            onTap: () {
                              sett('4', 0.1, 'animator_duration_scale');
                            },
                          ),
                        ),
                      ),
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
