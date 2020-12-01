import 'dart:math';
import 'package:flutter/material.dart';

List<Color> colors = const <Color>[
  Color(0xffef92a5),
  Color(0xff73b3fa),
  Color(0xffb4d761),
  Color(0xffcc99fe),
  Color(0xff6d998e),
  Colors.deepPurple,
  Colors.indigo,
  Colors.indigoAccent,
];

class CardButton extends StatefulWidget {
  const CardButton({
    Key key,
    this.title,
    this.subtitle,
    this.subhead,
    this.onTap,
    this.width,
    this.suffix,
  }) : super(key: key);
  final String title;
  final String subtitle;
  final String subhead;
  final Function onTap;
  final double width;
  final Widget suffix;

  @override
  _CardButtonState createState() => _CardButtonState();
}

class _CardButtonState extends State<CardButton>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _location;
  bool isOnTap = false;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    _location =
        Tween<double>(begin: 0.0, end: 0.0).animate(_animationController);
    _location.addListener(() {
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback(_onAfterRendering);
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(CardButton oldWidget) {
    WidgetsBinding.instance.addPostFrameCallback(_onAfterRendering);
    super.didUpdateWidget(oldWidget);
  }

  Future<void> _onAfterRendering(Duration timeStamp) async {
    if (context != null) {
      await Future<void>.delayed(const Duration(milliseconds: 100));
      _location = Tween<double>(
              begin: 0.0, end: MediaQuery.of(context).size.width - 24.0)
          .animate(_animationController);
      _location.addListener(() {
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  int animation;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(4.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            // color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(8.0),
            ),
            boxShadow: !isOnTap
                ? <BoxShadow>[
                    BoxShadow(
                      offset: const Offset(0, 2),
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 1.0,
                      spreadRadius: 0.0,
                    ),
                    BoxShadow(
                      offset: const Offset(0, -0.5),
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 2.0,
                      spreadRadius: 0.0,
                    )
                  ]
                : null,
          ),
          child: Material(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
            shadowColor: Colors.grey.withOpacity(0.4),
            // elevation: isOnTap ? 0.0 : 4.0,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(8.0),
              ),
              child: Material(
                color: Theme.of(context).cardColor,
                child: InkWell(
                  // highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  borderRadius: const BorderRadius.all(Radius.circular(0.0)),
                  onTapCancel: () {
                    isOnTap = false;
                    setState(() {});
                  },
                  onTapDown: (_) async {
                    isOnTap = true;
                    setState(() {});
                    animation ??= 1;
                    while (animation != 0) {
                      if (animation == 1) {
                        await _animationController.forward();
                        animation = -1;
                      }
                      if (animation == -1) {
                        await _animationController.reverse();
                        animation = 1;
                      }
                    }
                  },
                  onTap: () {
                    isOnTap = false;
                    setState(() {});
                    widget.onTap();
                    // animation = 0;
                    _animationController.stop();
                  },
                  child: SizedBox(
                    width: widget.width,
                    height: 64.0,
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        // Align(
                        //   alignment: Alignment.topLeft,
                        //   child: Container(
                        //     alignment: FractionalOffset.center,
                        //     transform: Matrix4.identity()
                        //       ..translate(_location.value),
                        //     width: 20.0,
                        //     height: 12.0,
                        //     decoration: BoxDecoration(
                        //       color: _color,
                        //       // borderRadius: BorderRadius.only(
                        //       //   topRight: Radius.circular(12),
                        //       //   bottomLeft: Radius.circular(12),
                        //       // ),
                        //       borderRadius: BorderRadius.only(
                        //           bottomRight: Radius.circular(12),
                        //           bottomLeft: Radius.circular(12)),
                        //     ),
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 12.0, top: 10.0, bottom: 10.0),
                          child: Stack(
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        widget.title,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 4.0,
                                      ),
                                      Text(
                                        widget.subhead ?? '',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              .color
                                              .withOpacity(0.6),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    widget.subtitle,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .color
                                            .withOpacity(0.8),
                                        fontSize: 12.0),
                                  ),
                                ],
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: widget.suffix ?? const SizedBox(),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}

class CardWidget extends StatefulWidget {
  const CardWidget(
      {Key key,
      this.title,
      this.subtitle,
      this.subhead,
      this.onTap,
      this.width,
      this.suffix})
      : super(key: key);
  final String title;
  final String subtitle;
  final String subhead;
  final Function onTap;
  final double width;
  final Widget suffix;

  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget>
    with SingleTickerProviderStateMixin {
  bool isOnTap = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
          boxShadow: !isOnTap
              ? <BoxShadow>[
                  BoxShadow(
                    offset: const Offset(0, 0),
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 1.0,
                    spreadRadius: 0.0,
                  ),
                ]
              : null,
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
          child: Material(
            color: Theme.of(context).cardColor,
            child: InkWell(
              // highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              borderRadius: const BorderRadius.all(Radius.circular(0.0)),
              onTapCancel: () {
                isOnTap = false;
                setState(() {});
              },
              onTapDown: (_) async {
                isOnTap = true;
                setState(() {});
              },
              onTap: () {
                isOnTap = false;
                setState(() {});
                widget.onTap();
              },
              child: SizedBox(
                width: widget.width,
                height: 64.0,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, top: 10.0, bottom: 10.0),
                      child: Stack(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    widget.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4.0,
                                  ),
                                  Text(
                                    widget.subhead ?? '',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .color
                                          .withOpacity(0.6),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                widget.subtitle,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .color
                                      .withOpacity(0.8),
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: widget.suffix ?? const SizedBox(),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Widget cardButton(String title, String subtitle,
//     {Function onTap, String str3, Widget suffix}) {
//   return Material(
//     shadowColor: Colors.black,
//     color: Colors.white,
//     //Card可以被ClipRRect剪切,但是会覆盖上一个组件的阴影
//     elevation: 1.0,
//     child: InkWell(
//       borderRadius: BorderRadius.all(Radius.circular(0.0)),
//       onTapDown: (_) {
//         print('object');
//       },
//       onTap: onTap,
//       child: SizedBox(
//         height: 72.0,
//         child: Stack(
//           alignment: Alignment.center,
//           children: <Widget>[
//             Align(
//               alignment: Alignment.topLeft,
//               child: Container(
//                 width: 20,
//                 height: 16.0,
//                 decoration: BoxDecoration(
//                   color: colors[Random().nextInt(3)],
//                   // borderRadius: BorderRadius.only(
//                   //   topRight: Radius.circular(12),
//                   //   bottomLeft: Radius.circular(12),
//                   // ),
//                   borderRadius: BorderRadius.only(
//                       topRight: Radius.circular(16),
//                       bottomLeft: Radius.circular(16)),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(left: 12.0, top: 14.0, bottom: 14.0),
//               child: Stack(
//                 children: <Widget>[
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Row(
//                         children: <Widget>[
//                           Text(
//                             title,
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(
//                             str3 ?? '',
//                             style: TextStyle(
//                               color: Colors.black54,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 12.0,
//                             ),
//                           ),
//                         ],
//                       ),
//                       Text(
//                         subtitle,
//                         style:
//                             TextStyle(color: Color(0xff696666), fontSize: 12.0),
//                       ),
//                     ],
//                   ),
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: suffix ?? SizedBox(),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
