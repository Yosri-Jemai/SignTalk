import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:signtalk/main.dart';
import 'package:signtalk/screens/login_screen.dart';
import 'package:signtalk/screens/offline_screen.dart';

class HomeScreen extends StatefulWidget {
  final List<CameraDescription>? cameras;
  const HomeScreen({Key? key, required this.cameras}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  Route createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () =>
                Navigator.of(context).push(createRoute(const LoginScreen())),
            child: Container(
              height: 50,
              width: 180,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0.0, 4.0),
                      blurRadius: 2)
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
                color: Color(0xFF021334),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Icon(Icons.wifi, color: Colors.white),
                  Text(
                    'ONLINE MODE',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 80),
          InkWell(
            onTap: () => Navigator.of(context)
                .push(createRoute(OfflineScreen(cameras: cameras))),
            child: Container(
              height: 50,
              width: 180,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0.0, 4.0),
                      blurRadius: 2)
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
                color: Color(0xFF021334),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Icon(Icons.wifi_off_outlined, color: Colors.white),
                  Text(
                    'OFFLINE MODE',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
