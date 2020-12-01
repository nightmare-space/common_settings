import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DpiEdit extends StatefulWidget {
  const DpiEdit({Key key, this.dpi, this.width, this.height, this.callback})
      : super(key: key);
  final int dpi;
  final int width;
  final int height;
  final void Function() callback;

  @override
  _DpiEditState createState() => _DpiEditState();
}

class _DpiEditState extends State<DpiEdit> {
  EventBus eventBus = EventBus();
  final TextEditingController _textcontroller0 = TextEditingController();
  final TextEditingController _textcontroller1 = TextEditingController();
  final TextEditingController _textcontroller2 = TextEditingController();
  @override
  void initState() {
    _textcontroller0.text = widget.dpi.toString();
    _textcontroller1.text = widget.width.toString();
    _textcontroller2.text = widget.height.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 240,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  '修改你的DPI，屏幕分辨率',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'DPI',
                  style: TextStyle(
                    color: Color(0x90303030),
                    fontSize: 16.0,
                  ),
                ),
              ),
              TextField(
                maxLength: 3,
                controller: _textcontroller0,
                keyboardType: TextInputType.number,
                //RegExp('[a-zA-Z]|[\u4e00-\u9fa5]|[0-9]')), //只能输入汉字或者字母或数字
                inputFormatters: const <TextInputFormatter>[
                  // FilteringTextInputFormatter.allow('[0-9]') //只能输入汉字或者字母或数字
                ],
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(top: 10.0),
                ),
                autofocus: false,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '分辨率',
                    style: TextStyle(
                      color: Color(0x90303030),
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 60,
                    child: TextField(
                      maxLength: 4,
                      controller: _textcontroller1,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(top: 20.0),
                      ),
                      autofocus: false,
                    ),
                  ),
                  const Icon(Icons.close),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: 60,
                    child: TextField(
                      maxLength: 4,
                      controller: _textcontroller2,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(top: 20.0),
                      ),
                      autofocus: false,
                    ),
                  ),
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                child: const Text(
                  '取消',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
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
                  if (int.parse(_textcontroller0.text) < 100 ||
                      int.parse(_textcontroller0.text) > 540) {
                    // showToast2('数字别太离谱啊喂！', '\u{1F624}');
                  } else {
                    //   Scaffold.of(pushContext).showSnackBar(
                    //     SnackBar(
                    //       content: Builder(
                    //         builder: (BuildContext c) {
                    //           Timer.periodic(const Duration(seconds: 1),
                    //               (Timer timer) {
                    //             if (!c.findRenderObject().attached)
                    //               timer.cancel();
                    //             if (timer.tick == 5) {
                    //               CustomProcess.exec('wm density reset\n'
                    //                   'wm size  reset\n');
                    //               if (widget.callback != null) {
                    //                 widget.callback();
                    //               }
                    //             }
                    //           });
                    //           return Row(
                    //             children: const <Widget>[
                    //               Text('显示5秒，5秒内用户未点击关闭复原DPI'),
                    //             ],
                    //           );
                    //         },
                    //       ),
                    //       action: SnackBarAction(
                    //           textColor: Colors.red,
                    //           label: '关闭',
                    //           onPressed: () {
                    //             // do something to undo
                    //           }),
                    //     ),
                    //   );

                    //   showToast2('马上就好');

                    //   CustomProcess.exec('wm density reset\n'
                    //       'wm density ${int.parse(_textcontroller0.text).toString()}\n'
                    //       'wm size  reset\n'
                    //       'wm size ${int.parse(_textcontroller1.text)}x${int.parse(_textcontroller2.text)}\n');
                    //   // ExplosionWidget.boomm();
                    //   Future<void>.delayed(const Duration(milliseconds: 590), () {
                    //     Navigator.of(context).pop();
                    //   });
                    //   if (widget.callback != null) {
                    //     widget.callback();
                    //   }
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
