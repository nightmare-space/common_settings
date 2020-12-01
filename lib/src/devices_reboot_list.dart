import 'package:flutter/material.dart';

class RebootTools extends StatefulWidget {
  @override
  _RebootToolsState createState() => _RebootToolsState();
}

class _RebootToolsState extends State<RebootTools> {
  String donghua;

  void handleSingleChanged(String value) {
    setState(() {
      donghua = value.toString();
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ListBody(
              children: <Widget>[
                Material(
                  color: Colors.white,
                  child: Ink(
                    child: InkWell(
                      onTap: () {
                        handleSingleChanged('fast_shut');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.fromLTRB(2.0, 0.0, 0.0, 0.0),
                            child: Text(
                              '快速关机',
                              style: TextStyle(
                                color: Color(0xff000000),
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                          Radio<String>(
                              value: 'fast_shut',
                              groupValue: donghua,
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
                        handleSingleChanged('fast_reboot');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.fromLTRB(2.0, 0.0, 0.0, 0.0),
                            child: Text(
                              '快速重启',
                              style: TextStyle(
                                color: Color(0xff000000),
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                          Radio<String>(
                              value: 'fast_reboot',
                              groupValue: donghua,
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
                        handleSingleChanged('hot_reboot');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.fromLTRB(2.0, 0.0, 0.0, 0.0),
                            child: Text(
                              '热重启',
                              style: TextStyle(
                                color: Color(0xff000000),
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                          Radio<String>(
                              value: 'hot_reboot',
                              groupValue: donghua,
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
                        handleSingleChanged('fastboot');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.fromLTRB(2.0, 0.0, 0.0, 0.0),
                            child: Text(
                              '重启进入FastBoot',
                              style: TextStyle(
                                color: Color(0xff000000),
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                          Radio<String>(
                              value: 'fastboot',
                              groupValue: donghua,
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
                        handleSingleChanged('recovery');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.fromLTRB(2.0, 0.0, 0.0, 0.0),
                            child: Text(
                              '重启进入Recovery',
                              style: TextStyle(
                                color: Color(0xff000000),
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                          Radio<String>(
                              value: 'recovery',
                              groupValue: donghua,
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
                        handleSingleChanged('9008');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.fromLTRB(2.0, 0.0, 0.0, 0.0),
                            child: Text(
                              '重启进入9008模式',
                              style: TextStyle(
                                color: Color(0xff000000),
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                          Radio<String>(
                              value: '9008',
                              groupValue: donghua,
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
                        handleSingleChanged('reboot_status');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.fromLTRB(2.0, 0.0, 0.0, 0.0),
                            child: Text(
                              '重启状态栏',
                              style: TextStyle(
                                color: Color(0xff000000),
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                          Radio<String>(
                              value: 'reboot_status',
                              groupValue: donghua,
                              onChanged: handleSingleChanged),
                        ],
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: 160,
                    height: 40,
                    child: Card(
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              25.0), //如果[borderRadius]被指定，那么[type]属性不能是 [MaterialType.circle]。
                        ),
                        elevation: 1,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(25),
                          onTap: () {
                            // if (donghua == null) {
                            //   PlatformChannel.Toast.invokeMethod<void>(
                            //       '选择一下啊喂！',
                            //       <String, dynamic>{'Emoji': 0x1F624});
                            // } else {
                            //   switch (donghua) {
                            //     case 'fast_shut':
                            //       NiProcess.exec('reboot -p');
                            //       break;
                            //     case 'fast_reboot':
                            //       NiProcess.exec('reboot');
                            //       break;
                            //     case 'hot_reboot':
                            //       NiProcess.exec(
                            //           'busybox killall system_server');
                            //       break;
                            //     case 'fastboot':
                            //       NiProcess.exec('reboot bootloader');
                            //       break;
                            //     case 'recovery':
                            //       NiProcess.exec('reboot recovery');
                            //       break;
                            //     case '9008':
                            //       NiProcess.exec('reboot edl');
                            //       break;
                            //     case 'reboot_status':
                            //       NiProcess.exec(
                            //           'busybox killall com.android.systemui');
                            //       break;
                            //   }
                            //   eventBus.fire(
                            //     const ExplosionWidget(),
                            //   );
                            // }
                          },
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            child: const Center(
                              child: Text(
                                '重启',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
