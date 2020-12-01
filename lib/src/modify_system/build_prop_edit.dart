import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:global_repository/global_repository.dart';

class BuildPropEdit extends StatefulWidget {
  @override
  _BuildPropEditState createState() => _BuildPropEditState();
}

class _BuildPropEditState extends State<BuildPropEdit> {
  final TextEditingController _textcontroller0 = TextEditingController();
  final TextEditingController _textcontroller1 = TextEditingController();
  String bd;
  ScrollController scrollController1;
  List<String> bdlist;
  List<String> bdvlist;
  @override
  void initState() {
    super.initState();
    scrollController1 = ScrollController();
    bd = '1';
    getBuild();
  }

  Future<void> getBuild() async {
    bdlist = <String>[];
    bdvlist = <String>[];
    bd = await NiProcess.exec('cat /system/build.prop');
    final String b = bd.replaceAll(RegExp('#.*\n'), ''); //将#注释的行删除
    final List<String> build = <String>[];
    for (final String str in b.split('\n')) {
      if (str != '') {
        build.add(str);
      }
    } //删除空行
    for (final String str in build) {
      bdlist.add(str.replaceAll(RegExp('=.*'), '')); //名字
      bdvlist.add(str.replaceAll(RegExp('.*='), '')); //值
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollbar.semicircle(
      controller: scrollController1,
      child: ListView.builder(
        cacheExtent: 2,
        padding: const EdgeInsets.only(bottom: 0),
        controller: scrollController1,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              Card(
                margin: const EdgeInsets.all(2.0),
                color: Colors.white,
                elevation: 1,
                child: InkWell(
                  borderRadius: BorderRadius.circular(4.0),
                  onTap: () {
                    _textcontroller0.text = bdlist[index];
                    _textcontroller1.text = bdvlist[index];
                    getBuild();
                    showCustomDialog(
                      context: context,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            '编辑',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextField(
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            controller: _textcontroller0,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(top: 10.0),
                            ),
                            autofocus: false,
                          ),
                          TextField(
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            controller: _textcontroller1,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(top: 10.0),
                            ),
                            autofocus: false,
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
                                  '确定',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                  await NiProcess.exec(
                                      'mount -o rw,remount /system\n'
                                      "busybox sed -i 's/${bdlist[index]}=${bdvlist[index]}/${_textcontroller0.text}=${_textcontroller1.text}/g' /system/build.prop\n");
                                  getBuild();
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 0.0),
                          child: Text(
                            bdlist[index],
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: bdlist.contains(index)
                                  ? Colors.red
                                  : Colors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 2.0, 0.0, 8.0),
                          child: Text(
                            bdvlist[index],
                            style: const TextStyle(
                              color: Color(0xff696666),
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        },
        itemCount: bdlist.length,
      ),
    );
  }
}
