import 'package:flutter/material.dart';
import 'package:global_repository/global_repository.dart';

class BatteryPretend extends StatefulWidget {
  const BatteryPretend({Key key, this.callback}) : super(key: key);
  final void Function() callback;

  @override
  _BatteryPretendState createState() => _BatteryPretendState();
}

class _BatteryPretendState extends State<BatteryPretend> {
  final TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: FullHeightListView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    '电池伪装',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextField(
                  controller: textEditingController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: '输入要伪装的电量',
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    isDense: true,
                    // enabledBorder: OutlineInputBorder(
                    //   borderSide: const BorderSide(
                    //     width: 1,
                    //     color: Colors.black,
                    //   ),
                    //   borderRadius: BorderRadius.circular(8),
                    // ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.black.withOpacity(0.2),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.black.withOpacity(0.2),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    fillColor: const Color(0xfff7f7f7),
                    filled: true,
                  ),
                  autofocus: false,
                  onSubmitted: (_) {
                    NiToast.showToast('按确认修改生效');
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                  child: const Text(
                    '无线充电',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () async {
                    await NiProcess.exec(
                      'dumpsys battery set status 2\n'
                      'dumpsys battery set ac 0\n'
                      'dumpsys battery set usb 0\n'
                      'dumpsys battery set wireless 1\n',
                    );
                    if (widget.callback != null) {
                      widget.callback();
                    }
                  },
                ),
                FlatButton(
                  child: const Text(
                    '交流电充电',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () async {
                    await NiProcess.exec(
                      'dumpsys battery set status 2\n'
                      'dumpsys battery set ac 1\n'
                      'dumpsys battery set usb 0\n'
                      'dumpsys battery set wireless 0\n',
                    );
                    if (widget.callback != null) {
                      widget.callback();
                    }
                  },
                ),
                FlatButton(
                  child: const Text(
                    'USB充电',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () async {
                    await NiProcess.exec(
                      'dumpsys battery set status 2\n'
                      'dumpsys battery set ac 0\n'
                      'dumpsys battery set usb 1\n'
                      'dumpsys battery set wireless 0\n',
                    );
                    if (widget.callback != null) {
                      widget.callback();
                    }
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  child: const Text(
                    '未充电',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () async {
                    await NiProcess.exec('dumpsys battery set status 1');
                    if (widget.callback != null) {
                      widget.callback();
                    }
                  },
                ),
                FlatButton(
                  child: const Text(
                    '恢复默认',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () async {
                    await NiProcess.exec('dumpsys battery reset');
                    if (widget.callback != null) {
                      widget.callback();
                    }
                  },
                ),
                FlatButton(
                  child: const Text(
                    '确认修改',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () async {
                    await NiProcess.exec(
                        'dumpsys battery set level ${int.parse(textEditingController.text)}\n');
                    if (widget.callback != null) {
                      widget.callback();
                    }
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
