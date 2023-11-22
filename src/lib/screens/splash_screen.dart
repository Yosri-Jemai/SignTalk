import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:signtalk/firebase_options.dart';
import 'package:signtalk/screens/home_screen.dart';
import 'package:signtalk/screens/loading_widget.dart';

class SplashScreen extends StatelessWidget {
  final List<CameraDescription>? cameras;
  const SplashScreen({Key? key, required this.cameras}) : super(key: key);

  Future delayedNavigation() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    return Future.delayed(const Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: delayedNavigation(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return HomeScreen(cameras: cameras);
        }
        return const LoadingWidget();
      },
    );
  }
}
