import 'dart:io';
import 'package:flutter/material.dart';
import 'package:global_repository/global_repository.dart';
import 'devices_reboot_list.dart';
import 'miui_layout_change/miui_layout_change.dart';
import 'modify_system/modify_system.dart';
import 'practical_tool/practical_tool.dart';

// double indexChangeProgress(TabController controller) {
//   //官方源码复制过来的计算Tab滑动的进度
//   final double controllerValue = controller.animation.value;
//   final double previousIndex = controller.previousIndex.toDouble();
//   final double currentIndex = controller.index.toDouble();
//   // The controller's offset is changing because the user is dragging the
//   // TabBarView's PageView to the left or right.
//   if (!controller.indexIsChanging)
//     return (currentIndex - controllerValue).abs().clamp(0.0, 1.0);
//   // The TabController animation's value is changing from previousIndex to currentIndex.
//   return (controllerValue - currentIndex).abs() /
//       (currentIndex - previousIndex).abs();
// }

class CommonTool extends StatefulWidget {
  CommonTool({
    Key key,
  }) : super(key: key) {
    if (Platform.isAndroid) {
      NiProcess.exec('su');
    }
  } //super(key:key)是为了将传入的key传到父类

  @override
  _CommonToolState createState() => _CommonToolState();
}

class _CommonToolState extends State<CommonTool> with TickerProviderStateMixin {
  // var mToolKitNotifier; //provider
  AnimationController animationController;
  Animation<EdgeInsets> titlePadding;
  TabController tabController;
  ScrollController scrollController = ScrollController();
  Animation<Color> tabcolor; //切换Tab对应的颜色数组
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    final Animation<double> curve = CurvedAnimation(
      parent: animationController,
      curve: Curves.bounceInOut,
    );
    titlePadding = EdgeInsetsTween(
      begin: const EdgeInsets.fromLTRB(300.0, 0, 0.0, 0.0),
      end: const EdgeInsets.fromLTRB(0.0, 0, 0.0, 0.0),
    ).animate(curve);
    titlePadding.addListener(() {
      setState(() {});
    });
    start();
    // _neverSatisfied();
    super.initState();
  }

  void start() {
    animationController.forward().whenComplete(
      () {
        scrollController.animateTo(36,
            duration: const Duration(milliseconds: 500), //跳转过去的时间
            curve: Curves.ease);
      },
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    ThemeData theme = Theme.of(context);
    final Color fontsColor =
        isDarkMode ? Colors.white70 : const Color(0xff4b5c76);
    final Color backgroundColor =
        isDarkMode ? Colors.black : const Color(0xfffafafa);
    final Color cardColor = isDarkMode ? const Color(0xff303030) : Colors.white;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: Platform.isLinux ? 'SourceHanSansSC-Light' : null,
        textTheme: TextTheme(
          bodyText2: TextStyle(color: fontsColor),
        ),
        cardTheme: CardTheme(color: theme.accentColor),
        iconTheme: IconThemeData(color: fontsColor),
        tabBarTheme: TabBarTheme(labelColor: fontsColor),
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: fontsColor),
          textTheme: TextTheme(
            headline6: TextStyle(
              color: fontsColor,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
        ),
        brightness: Brightness.light, //这个永远是light，不然会去读取蓝色
        primaryColorBrightness: isDarkMode ? Brightness.dark : Brightness.light,
        accentColorBrightness: Brightness.light,
        cardColor: cardColor,
        accentColor: theme.accentColor,
        primaryColor: backgroundColor,
        splashColor: Colors.transparent,
        highlightColor: const Color(0x66bcbcbc),
      ),
      home: Scaffold(
        appBar: PreferredSize(
          child: AppBar(
            elevation: 0.0,
            primary: true,
          ),
          preferredSize: const Size.fromHeight(0),
        ),
        body: buildNestedScrollView(context),
      ),
    );
  }

  NestedScrollView buildNestedScrollView(BuildContext context) {
    return NestedScrollView(
      controller: scrollController,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverPersistentHeader(
            pinned: false,
            floating: true,
            delegate: AppBarBuilder(
              AppBar(
                //是否固定
                elevation: 0.0,
                //这个是阴影
                primary: false,
                title: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: titlePadding.value,
                    child: GestureDetector(
                      onTap: () {
                        start();
                      },
                      child: Text(
                        '常用功能',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily:
                              Platform.isLinux ? 'SourceHanSansSC-Light' : null,
                        ),
                      ),
                    ),
                  ),
                ),
                // leading: Align(
                //   alignment: Alignment.center,
                //   child: Container(
                //     decoration:
                //         BoxDecoration(borderRadius: BorderRadius.circular(25)),
                //     height: 36,
                //     width: 36,
                //     child: InkWell(
                //       borderRadius: BorderRadius.circular(25),
                //       child: Center(
                //         child: Selector<DrawerNotifier, double>(
                //           selector: (BuildContext context,
                //                   DrawerNotifier viewModel) =>
                //               viewModel.scale,
                //           builder: (BuildContext context, double progress,
                //               Widget child) {
                //             return AnimatedIcon(
                //               icon: AnimatedIcons.menu_arrow,
                //               progress: AlwaysStoppedAnimation<double>(
                //                   progress / 0.2),
                //             );
                //           },
                //         ),
                //       ),
                //       onTap: () {
                //         Provider.of<DrawerNotifier>(context, listen: false)
                //             .openDrawer();
                //       },
                //     ),
                //   ),
                // ),
                actions: <Widget>[
                  RotationTransition(
                    turns: tabController.animation,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25)),
                        height: 36,
                        width: 36,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(25),
                          child: const Tooltip(
                            message: '高级重启',
                            child: Icon(Icons.power_settings_new, size: 24.0),
                          ),
                          onTap: () {
                            // showCustomDialog(
                            //     context,
                            //     const Duration(milliseconds: 400),
                            //     394,
                            //     RebootTools(),
                            //     true);
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                ],
              ),
            ),
          ),
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverPersistentHeader(
              pinned: true,
              delegate: TabBarBuilder(
                TabBar(
                  indicatorWeight: 2,
                  isScrollable: false,
                  controller: tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: const <Widget>[
                    SizedBox(
                      height: 46,
                      child: Tab(
                        child: Text(
                          '实用工具',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 46,
                      child: Tab(
                        child: Text(
                          '系统修改',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 46,
                      child: Tab(
                        child: Text(
                          'MIUI布局修改',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                  // indicatorColor: YanToolColors.appColor,
                ),
              ),
            ),
          ),
        ];
      },
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 48, 0, 0),
        child: TabBarView(
          controller: tabController,
          children: <Widget>[
            PracticalTool(),
            ModifySystem(),
            const MiuiLayoutChange()
          ],
        ),
      ),
    );
  }
}

class TabBarBuilder extends SliverPersistentHeaderDelegate {
  TabBarBuilder(this._tbBar);
  final TabBar _tbBar;
  @override
  double get minExtent => 48;
  @override
  double get maxExtent => 48;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Padding(
      padding: const EdgeInsets.only(left: 2.0, right: 2.0),
      child: Material(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        shadowColor: Colors.black.withOpacity(0.6),
        elevation: 2.0,
        color: Colors.transparent,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(12.0),
            bottomRight: Radius.circular(12.0),
          ),
          child: Material(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: _tbBar,
          ),
        ),
        // color: Colors.white,
      ),
    );
  }

  @override
  bool shouldRebuild(TabBarBuilder oldDelegate) {
    return true; //是否及时更改
  }
}

class AppBarBuilder extends SliverPersistentHeaderDelegate {
  AppBarBuilder(this._tbBar);
  final AppBar _tbBar;
  @override
  double get minExtent => 36;
  @override
  double get maxExtent => 36;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Padding(
      padding: const EdgeInsets.only(left: 2.0, right: 2.0),
      child: _tbBar,
    );
  }

  @override
  bool shouldRebuild(AppBarBuilder oldDelegate) {
    return true; //是否及时更改
  }
}
