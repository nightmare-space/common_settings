import 'package:flutter/material.dart';

//储存当前设备信息的类
class DevicesInfo {
  DevicesInfo() {
    physicalSize = const Size(0, 0);
    deviceDPI = 0;
  }
  Size physicalSize;
  int deviceDPI;
}
