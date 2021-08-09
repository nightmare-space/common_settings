import 'package:flutter/material.dart';
import 'package:global_repository/global_repository.dart';

class ChangeBootAnimation extends StatefulWidget {
  const ChangeBootAnimation({Key key, this.filepath}) : super(key: key);
  final String filepath;

  @override
  _ChangeBootAnimationState createState() => _ChangeBootAnimationState();
}

class _ChangeBootAnimationState extends State<ChangeBootAnimation> {
  String filepath;

  @override
  void initState() {
    super.initState();
    filepath ??= widget.filepath;
    backup();
  }

  Future<void> backup() async {
    // TODO
    // NiProcess.exec(
    //     'if [ ! -e ${Global.documentsDir}/${Config.backupPath}/bootanimation.zip ]; then\n'
    //     'cp /system/media/bootanimation.zip ${Global.documentsDir}/${Config.backupPath}/bootanimation.zip\n'
    //     'fi\n');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        const Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Center(
              child: Text(
                '原开机动画已备份/Sdcard/YanTool/Backup',
                style: TextStyle(
                    color: Color(0xff000000),
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600),
              ),
            )),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Center(
            child: Text(
              '当前选中的文件为：' + filepath,
              style: const TextStyle(
                  color: Color(0xff000000),
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Center(
              child: Container(
                width: 120,
                height: 40,
                child: Card(
                  // color: YanToolColors.accentColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        25.0), //如果[borderRadius]被指定，那么[type]属性不能是 [MaterialType.circle]。
                  ),
                  elevation: 1,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(25),
                    onTap: () {
                      // eventBus.fire(
                      //   const ExplosionWidget(),
                      // );
                      YanProcess().exec('mount -o rw,remount /system\n'
                          'cp -rf /sdcard/Nightmare/bootanimation.zip /system/media/bootanimation.zip\n'
                          'chmod -R 0644 /system/media/bootanimation.zip\n'
                          'fi\n');

                      showToast('还原成功');
                      filepath = ' ';
                      setState(() {});
                    },
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      child: const Center(
                        child: Text(
                          '还原',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                width: 120,
                height: 40,
                child: Card(
                    // color: YanToolColors.accentColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          25.0), //如果[borderRadius]被指定，那么[type]属性不能是 [MaterialType.circle]。
                    ),
                    elevation: 1,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(25),
                      onTap: () {
                        // if (filepath != ' ') {
                        //   eventBus.fire(
                        //     const ExplosionWidget(),
                        //   );
                        //   NiProcess.exec('mount -o rw,remount /system\n'
                        //       'cp -rf $filepath /system/media/bootanimation.zip\n'
                        //       'chmod -R 0644 /system/media/bootanimation.zip\n'
                        //       'fi\n');

                        //   PlatformChannel.Toast.invokeMethod<void>('修改成功');
                        //   filepath = '选择一个文件';
                        //   setState(() {});
                        // } else {
                        //   PlatformChannel.Toast.invokeMethod<void>(
                        //       '选择一个文件啊喂！', <String, dynamic>{'Emoji': 0x1F624});
                        // }
                      },
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        child: const Center(
                          child: Text(
                            '确认修改',
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
        )
      ],
    );
  }
}
