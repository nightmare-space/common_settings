import 'package:global_repository/global_repository.dart';

// TODO 重构,change就不应该带有get的方法
Future<bool> changeState(String key, [bool change]) async {
  //反向更改Key对应值的状态
  final String index =
      await NiProcess.exec('settings get system $key'); //先保存之前Key对应的值
  if (change == null) {
    //如果change的值为空直接返回布尔值
    if (index == '1') {
      return true;
    } else {
      return false;
    }
  } else {
    await NiProcess.exec(
        "settings put system $key ${index == "1" ? "0" : "1"}");
    return await changeState(key); //递归调用自己，但是不带布尔形参
  }
}
