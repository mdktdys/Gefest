import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

CustomTransitionPage transitionPage(state,page) {
  return CustomTransitionPage(
      key: state.pageKey,
      child: page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
          child: child,
        );
      },
    );
}