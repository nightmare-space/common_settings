import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:global_repository/global_repository.dart';

//显示WIFI密码的widget
class WifiPassword extends StatefulWidget {
  @override
  _WifiPasswordState createState() => _WifiPasswordState();
}

class _WifiPasswordState extends State<WifiPassword>
    with TickerProviderStateMixin {
  AnimationController animationController; //动画控制器
  Animation<double> transformX; //Transform组件变换的X坐标
  List<String> wifin = <String>[];
  Matrix4 matrix4; //四阶变换矩阵
  ScrollController scrollController = ScrollController(); //用来联动ListView
  @override
  void initState() {
    super.initState();
    getWifiPassword();
    animationInit();
  }

  void animationInit() {
    //初始化动画
    animationController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    final Animation<double> curve =
        CurvedAnimation(parent: animationController, curve: Curves.ease);
    transformX = Tween<double>(
      begin: 390.0,
      end: 0.0,
    ).animate(curve);
    transformX.addListener(() {
      setState(() {});
    });
    animationController.forward();
  }

  Future<void> getWifiPassword() async {
    final String wifiXml = await NiProcess.exec(
      'cat /data/misc/wifi/WifiConfigStore.xml',
    ); //拿到Wifi的配置文件
    final Iterable<Match> e =
        RegExp('name=\"SSID\">.*|name=\"PreSharedKey\".*').allMatches(wifiXml);
    String match1 = '';
    for (final Match h in e) {
      match1 = match1 + h.group(0) + '\n';
    }
    match1 = match1.replaceAll(
      RegExp(
        '&quot;</string>|name=\"SSID\">&quot;|name=\"PreSharedKey\"|>&quot;',
      ),
      '',
    );

    match1 = match1.replaceAll(RegExp('/>'), '公开');
    wifin = match1.split('\n');
    setState(() {});
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    matrix4 = Matrix4.identity()
      ..translate(transformX.value); //每次Build都会根据动画的补间值
    return Transform(
      alignment: FractionalOffset.center, //以控件中心变换
      transform: matrix4,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 8.0,
          left: 6.0,
          right: 6.0,
          bottom: 8.0,
        ),
        child: Material(
          color: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12.0),
            ),
          ),
          shadowColor: Colors.grey.withOpacity(0.4),
          // elevation: 12.0,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(12.0),
            ),
            child: Material(
              color: Colors.white,
              child: buildListView(),
            ),
          ),
        ),
      ),
    );
  }

  ListView buildListView() {
    return ListView.builder(
      cacheExtent: 2,
      controller: scrollController,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: <Widget>[
            if (index != 0)
              const Divider(
                height: 1.0,
                endIndent: 8.0,
                indent: 8.0,
              )
            else
              const SizedBox(),
            Tooltip(
              message: '点击即可复制密码',
              child: InkWell(
                onTap: () async {
                  await Clipboard.setData(
                    ClipboardData(text: '${wifin[2 * index + 1]} '),
                  );
                  showToast(
                    'WIFI名称为${wifin[2 * index]}的密码已复制',
                  );
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 10.0, 0.0, 0.0),
                        child: Text(
                          'WIFI名称：${wifin[2 * index]}',
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            // color: YanToolColors.fontsColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 2.0, 0.0, 10.0),
                        child: Text(
                          wifin[2 * index + 1],
                          style: TextStyle(
                            // color: YanToolColors.fontsColor.withOpacity(0.8),
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
      itemCount: (wifin.length * 0.5).toInt(),
    );
  }
}
