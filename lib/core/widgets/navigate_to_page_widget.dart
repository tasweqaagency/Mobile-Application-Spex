import 'package:flutter/material.dart';

class NavigateToPageWidget extends PageRouteBuilder {
  final Widget page;

  NavigateToPageWidget(this.page)
    : super(
        pageBuilder: (context, animation, anotherAnimation) => page,
        transitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
            curve: Curves.fastLinearToSlowEaseIn,
            parent: animation,
          );
          return Align(
            alignment: Alignment.bottomCenter,
            child: SizeTransition(sizeFactor: animation, child: page),
          );
        },
      );
}

class NavigateToPageWidgetFade extends PageRouteBuilder {
  final Widget page;

  NavigateToPageWidgetFade(this.page)
    : super(
        pageBuilder: (context, animation, anotherAnimation) => page,
        transitionDuration: const Duration(milliseconds: 300),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
            curve: Curves.easeInOut,
            parent: animation,
          );
          return Align(
            alignment: Alignment.center,
            child: FadeTransition(opacity: animation, child: page),
          );
        },
      );
}
