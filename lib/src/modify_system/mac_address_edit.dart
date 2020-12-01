import 'package:flutter/material.dart';
import 'package:global_repository/global_repository.dart';

class MacAdressEdit extends StatefulWidget {
  const MacAdressEdit({Key key, this.callback}) : super(key: key);
  final void Function() callback;

  @override
  _MacAdressEditState createState() => _MacAdressEditState();
}

class _MacAdressEditState extends State<MacAdressEdit> {
  final TextEditingController _textcontroller0 = TextEditingController();
  @override
  void initState() {
    _textcontroller0.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
        child: SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Text(
              'MAC地址修改',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextField(
            controller: _textcontroller0,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: '输入要修改的MAC',
              hintText: 'xx:xx:xx:xx:xx:xx',
              //helperText: "sdsd",
              contentPadding: EdgeInsets.only(top: 10.0),
            ),
            autofocus: true,
            onSubmitted: (_) {
              NiToast.showToast('按确认修改生效');
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                  child: const Text(
                    '返回',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () async {
                    Navigator.of(context).pop();
                  }),
              FlatButton(
                  child: const Text(
                    '确认修改',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () async {
                    if (_textcontroller0.text.length < 17) {
                      NiToast.showToast('MAC地址不完整');
                    } else {
                      await NiProcess.exec(
                          'ip link set wlan0 down &&ip link set wlan0 address ${_textcontroller0.text}\n');
                      NiToast.showToast('MAC更改成功,重新连接WIFI查看效果');
                    }
                    if (widget.callback != null) {
                      widget.callback();
                    }
                  }),
            ],
          )
        ],
      ),
    ));
  }
}
