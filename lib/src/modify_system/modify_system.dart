import 'package:flutter/material.dart';

import 'build_prop_edit.dart';
import 'modify_system_home.dart';

class ModifySystem extends StatefulWidget {
  @override
  _ModifySystemState createState() => _ModifySystemState();
}

class _ModifySystemState extends State<ModifySystem> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Theme.of(context).copyWith(
        buttonTheme: ButtonThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
              // primary: YanToolColors.fontsColor,
              ),
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      initialRoute: 'buildListView',
      onGenerateRoute: (RouteSettings settings) {
        Widget child;
        switch (settings.name) {
          case 'buildListView':
            child = Builder(builder: (BuildContext c) {
              return ModSysHome();
            });
            break;

          // case 'ModelChange':
          //   child = Builder(builder: (BuildContext c) {
          //     return Scaffold(
          //       body: ModelChange(),
          //     );
          //   });
          //   break;
          case 'BuildPropEdit':
            child = Builder(builder: (BuildContext c) {
              return Scaffold(
                body: BuildPropEdit(),
              );
            });
            break;

          default:
        }
        return PageRouteBuilder<void>(
          opaque: false,
          pageBuilder: (BuildContext context, _, __) {
            return child;
          },
          transitionDuration: const Duration(milliseconds: 400),
          transitionsBuilder:
              (_, Animation<double> animation, __, Widget child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
      },
    );

    // return FadeTransition(
    //   opacity: opacityTween,
    //   child: WillPopScope(
    //     child: child,
    //     onWillPop: () async {
    //       if (modifySystemPage != 0) modifySystemPage = 0;
    //       setState(() {});
    //       return false;
    //     },
    //   ),
    // );
  }
}
