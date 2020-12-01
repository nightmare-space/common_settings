// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class BaseConversion extends StatefulWidget {
//   @override
//   _BaseConversionState createState() => _BaseConversionState();
// }

// class _BaseConversionState extends State<BaseConversion> {
//   TextEditingController _controll;
//   String format;
//   double _result;
//   String _result1 = "";
//   int before;
//   int after;
//   int rTurnToxN(List<int> _list, int _r, int _index) {
//     if (_list.isEmpty)
//       return 0;
//     else if (_index < _list.length) {
//       return _list[_list.length - _index] * pow(_r, _index - 1) +
//           rTurnToxN(_list, _r, _index + 1);
//     } else {
//       return _list[_list.length - _index] * pow(_r, _index - 1);
//     }
//   }

//   double rTurnToxF(List<int> _list, int _r, int _index) {
//     if (_list.isEmpty)
//       return 0;
//     else if (_index < _list.length) {
//       return _list[_list.length - _index] * pow(_r, _index - _list.length - 1) +
//           rTurnToxF(_list, _r, _index + 1);
//     } else {
//       return _list[_list.length - _index] * pow(_r, _index - _list.length - 1);
//     }
//   }

//   @override
//   void initState() {
//     before = 10;
//     after = 2;
//     _controll = TextEditingController();
//     changeformat();
//     super.initState();
//   }

//   changeformat() {
//     switch (before) {
//       case 2:
//         format = "[0-1]|\\.";
//         break;
//       case 4:
//         format = "[0-3]|\\.";
//         break;
//       case 8:
//         format = "[0-7]|\\.";
//         break;
//       case 10:
//         format = "[0-9]|\\.";
//         break;
//       case 16:
//         format = "[A-F]|[a-f]|\\.|[0-9]";
//         break;
//       case 32:
//         format = "[A-F]|[a-f]|\\.|[0-9]";
//         break;
//     }
//   }

//   String xTurnToRN(int _x, int _r) {
//     if (_x == null) return "";
//     int _remainder = _x ~/ _r;
//     // print(_remainder);
//     if (_remainder != 0)
//       return getEFromNum(_x % _r) + xTurnToRN(_remainder, _r);
//     else
//       return (getEFromNum(_x % _r));
//   }

//   String xTurnToRF(double _x, int _r) {
//     if (_x == null) return "0";
//     double _remainder = _x * _r;
//     if (_remainder - _remainder.toInt() <= 0.2)
//       return _remainder.toInt().toString();
//     else
//       return _remainder.toInt().toString() + xTurnToRF(_remainder, _r);
//   }

//   String getEFromNum(int _int) {
//     switch (_int) {
//       case 0:
//         return "0";
//         break;
//       case 1:
//         return "1";
//         break;
//       case 2:
//         return "2";
//         break;
//       case 3:
//         return "3";
//         break;
//       case 4:
//         return "4";
//         break;
//       case 5:
//         return "5";
//         break;
//       case 6:
//         return "6";
//         break;
//       case 7:
//         return "7";
//         break;
//       case 8:
//         return "8";
//         break;
//       case 9:
//         return "9";
//         break;
//       case 9:
//         return "9";
//         break;
//       case 10:
//         return "a";
//         break;
//       case 11:
//         return "b";
//         break;
//       case 12:
//         return "c";
//         break;
//       case 13:
//         return "d";
//         break;
//       case 14:
//         return "e";
//         break;
//       case 15:
//         return "f";
//         break;
//       case 16:
//         return "g";
//         break;
//       case 17:
//         return "h";
//         break;
//       case 18:
//         return "i";
//         break;
//       case 19:
//         return "j";
//         break;
//       case 20:
//         return "k";
//         break;
//       case 21:
//         return "l";
//         break;
//       case 22:
//         return "m";
//         break;
//       case 23:
//         return "n";
//         break;
//       case 24:
//         return "o";
//         break;
//       case 25:
//         return "p";
//         break;
//       case 26:
//         return "q";
//         break;
//       case 27:
//         return "r";
//         break;
//       case 28:
//         return "s";
//         break;
//       case 29:
//         return "t";
//         break;
//       case 30:
//         return "u";
//         break;
//       case 31:
//         return "v";
//         break;
//       case 32:
//         return "w";
//         break;
//       case 33:
//         return "x";
//         break;
//       case 34:
//         return "y";
//         break;
//       case 35:
//         return "z";
//         break;
//       default:
//         return "";
//     }
//   }

//   numChange(String str) {
//     if (before == 10) {
//       _result = 0;
//       List<int> _list1 = [];
//       double _list2;
//       bool hasPoint = false;
//       for (String _str in str.split("")) {
//         if (_str == ".")
//           hasPoint = true;
//         else if (!hasPoint) _list1.add(int.tryParse(_str, radix: 16));
//       }
//       if (str.contains("."))
//         _list2 = double.tryParse(str.replaceAll(RegExp(".*\\."), "0."));
//       _result1 = xTurnToRN(int.tryParse(_list1.join("")), after)
//               .split("")
//               .reversed
//               .join() +
//           ".${xTurnToRF(_list2, after)}";
//       setState(() {});
//     } else if (after == 10) {
//       _result1 = "";
//       List<int> _list1 = [];
//       List<int> _list2 = [];
//       bool hasPoint = false;
//       for (String _str in str.split("")) {
//         if (_str == ".")
//           hasPoint = true;
//         else if (hasPoint)
//           _list2.add(int.tryParse(_str, radix: 16));
//         else
//           _list1.add(int.tryParse(_str, radix: 16));
//       }
//       _result = rTurnToxN(_list1, before, 1) + rTurnToxF(_list2, before, 1);
//       setState(() {});
//     } else {
//       _result1 = "";
//       List<int> _list1 = [];
//       List<int> _list2 = [];
//       bool hasPoint = false;
//       for (String _str in str.split("")) {
//         if (_str == ".")
//           hasPoint = true;
//         else if (hasPoint)
//           _list2.add(int.tryParse(_str, radix: 16));
//         else
//           _list1.add(int.tryParse(_str, radix: 16));
//       }
//       double _tmp = rTurnToxN(_list1, before, 1) + rTurnToxF(_list2, before, 1);
//       print(_tmp);
//       _result = 0;
//       double _list4;
//       _list4 = _tmp-_tmp.toInt();
//       _result1 = xTurnToRN(_tmp.toInt(), after)
//               .split("")
//               .reversed
//               .join() +
//           ".${xTurnToRF(_list4, after)}";
//       setState(() {});
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Divider(),
//         SizedBox(
//           height: 40.0,
//           child: Align(
//             alignment: Alignment.centerLeft,
//             child: TextField(
//               controller: _controll,
//               onChanged: (_input) {
//                 numChange(_input);
//               },
//               inputFormatters: [
//                 WhitelistingTextInputFormatter(RegExp(format)), //只能输入汉字或者字母或数字
//               ],
//               style: TextStyle(fontSize: 16.0),
//               decoration: InputDecoration(
//                 hintText: "请输入需要转换的数:",
//                 border: InputBorder.none,
//               ),
//             ),
//           ),
//         ),
//         Divider(),
//         Text(
//           "转换的结果为:",
//           style: TextStyle(color: Colors.grey),
//         ),
//         Divider(),
//         SizedBox(
//           height: 40.0,
//           child: Align(
//             alignment: Alignment.centerLeft,
//             child: Text(
//               (_result != null && _result != 0.0 ? "$_result" : "") + _result1,
//               style: TextStyle(fontSize: 16.0),
//             ),
//           ),
//         ),
//         Divider(),
//         Text("将 $before 进制"),
//         Slider(
//           value: before.toDouble(),
//           max: 36.0,
//           min: 2.0,
//           divisions: 35,
//           activeColor: Color(0xff213349),
//           onChanged: (val) {
//             before = val.toInt();
//             changeformat();
//             numChange(_controll.text);
//             setState(() {});
//           },
//           label: '${before.toInt()}',
//         ),
//         Text("转换为 $after 进制"),
//         Slider(
//           value: after.toDouble(),
//           max: 36.0,
//           min: 2.0,
//           divisions: 35,
//           activeColor: Color(0xff213349),
//           onChanged: (val) {
//             after = val.toInt();
//             numChange(_controll.text);
//             setState(() {});
//           },
//           onChangeEnd: (a) {
//             // setdesk(desktoprow.toInt(), desktopcolumn.toInt(), folder.toInt());
//           },
//           label: '${after.toInt()}',
//         ),
//       ],
//     );
//   }
// }
