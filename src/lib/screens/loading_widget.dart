import 'package:flutter/material.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget>
    with TickerProviderStateMixin {
  late final AnimationController fadeController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 800));
  late final Animation<double> fadeAnimation =
      Tween(begin: 0.4, end: 1.0).animate(fadeController);

  @override
  void initState() {
    super.initState();
    fadeController
      ..reverse()
      ..repeat();
  }

  @override
  void dispose() {
    fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset('assets/images/signtalk.png', height: 200, width: 200),
        FadeTransition(
            opacity: fadeAnimation,
            child: Image.asset(
              'assets/images/text.png',
              height: 150,
              width: 150,
            )),
      ],
    ));
  }
}
