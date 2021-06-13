import 'dart:async';
import 'package:flutter/material.dart';
import 'package:global_repository/global_repository.dart';

class TextAutoInput extends StatefulWidget {
  @override
  _TextAutoInputState createState() => _TextAutoInputState();
}

class _TextAutoInputState extends State<TextAutoInput> {
  TextEditingController _textcontroller0;
  TextEditingController _textcontroller1;
  @override
  void initState() {
    _textcontroller0 = TextEditingController(text: '5');
    _textcontroller1 = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            children: <Widget>[
              const Text(
                '延迟',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 40,
                child: TextField(
                  style: const TextStyle(),
                  controller: _textcontroller0,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 14),
                  ),
                  onChanged: (String str) {
                    print(str);
                  },
                  autofocus: false,
                ),
              ),
              const Text(
                '秒后输入',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 300,
          child: TextField(
            controller: _textcontroller1,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              fillColor: Colors.white10,
              filled: true,
              contentPadding: EdgeInsets.only(left: 4, top: 8),
            ),
            minLines: 20,
            maxLines: 20,
            autofocus: false,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                '返回',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            FlatButton(
              onPressed: () {
                int i = int.parse(_textcontroller0.text);
                showToast('$i');
                Timer.periodic(const Duration(seconds: 1), (Timer timer) async {
                  i--;
                  if (i == 0) {
                    showToast('执行输入');
                    timer.cancel();
                    await NiProcess.exec(
                        'ime set com.android.adbkeyboard/.AdbIME\nsleep 1');
                    // TODO
                    // await PlatformChannel.SendBroadcast.invokeMethod<void>(
                    //     'ADB_INPUT_TEXT', _textcontroller1.text);
                    // await CustomProcess.exec(
                    //     'am broadcast -a ADB_INPUT_TEXT --es msg '${_textcontroller1.text.toString()}'\nsleep 1');
                    await NiProcess.exec(
                        'ime set com.baidu.input_mi/.ImeService');
                  } else {
                    showToast('$i');
                  }
                });
              },
              child: const Text(
                '确认',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ],
    );
  }
}
