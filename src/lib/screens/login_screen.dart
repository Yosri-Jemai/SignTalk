import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:signtalk/screens/online_screen.dart';
import 'package:signtalk/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();
  String? passError, emailError;

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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  'LOGIN',
                  style: GoogleFonts.secularOne(
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                      color: Colors.blue[900]),
                ),
              ),
              const Divider(),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      try {
                        final GoogleSignInAccount? googleUser =
                            await GoogleSignIn().signIn();
                        if (googleUser != null) {
                          final GoogleSignInAuthentication googleAuth =
                              await googleUser.authentication;
                          final credential = GoogleAuthProvider.credential(
                              accessToken: googleAuth.accessToken,
                              idToken: googleAuth.idToken);
                          await FirebaseAuth.instance
                              .signInWithCredential(credential);
                          if (!mounted) return;
                          Navigator.of(context).pushReplacement(
                              createRoute(const OnlineScreen()));
                        } else {
                          debugPrint("Aborted.");
                        }
                      } catch (e) {
                        debugPrint(e.toString());
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0.0, 2.0),
                              blurRadius: 3,
                              spreadRadius: 2),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Image.asset(
                        'assets/images/g_logo.png',
                        height: 24,
                        width: 24,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  GestureDetector(
                    onTap: () async {
                      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Under Development'),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0.0, 2.0),
                              blurRadius: 3,
                              spreadRadius: 2),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Image.asset(
                        'assets/images/f_logo.png',
                        height: 26,
                        width: 26,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 5),
              const Divider(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
                child: Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          if (emailError != null) {
                            setState(() => emailError = null);
                          }
                        },
                        decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red[300]!)),
                          errorText: emailError,
                          hintText: 'Enter email',
                          hintStyle: GoogleFonts.poppins(fontSize: 13),
                          label: Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: Text('Email',
                                style: GoogleFonts.poppins(fontSize: 13)),
                          ),
                          prefixIcon: const Icon(Icons.email, size: 22),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        controller: passCtrl,
                        obscureText: true,
                        autocorrect: false,
                        enableSuggestions: false,
                        onChanged: (value) {
                          debugPrint(value);
                          if (passError != null) {
                            setState(() => passError = null);
                          }
                        },
                        decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red[300]!)),
                          errorText: passError,
                          hintText: 'Enter password',
                          hintStyle: GoogleFonts.poppins(fontSize: 13),
                          label: Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: Text('Password',
                                style: GoogleFonts.poppins(fontSize: 13)),
                          ),
                          prefixIcon: const Icon(Icons.password, size: 22),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: MaterialButton(
                          minWidth: double.infinity,
                          onPressed: () async {
                            if (emailCtrl.text.isEmpty) {
                              setState(
                                  () => emailError = 'Please enter an email');
                              return;
                            }
                            if (passCtrl.text.isEmpty) {
                              setState(
                                  () => passError = 'Please enter a password');
                              return;
                            }
                            try {
                              await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: emailCtrl.text,
                                      password: passCtrl.text);
                              if (!mounted) return;
                              Navigator.of(context).pushReplacement(
                                  createRoute(const OnlineScreen()));
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                setState(() => emailError =
                                    'No user found with that email.');
                              } else if (e.code == 'wrong-password') {
                                setState(() => passError =
                                    "The credentials you have entered do not match.");
                              } else {
                                setState(() => passError = e.message);
                              }
                            } catch (e) {
                              debugPrint(e.toString());
                            }
                          },
                          color: Colors.blue[900],
                          textColor: Colors.white,
                          child: const Text('Login'),
                        ),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () => Navigator.of(context)
                            .push(createRoute(const SignupScreen())),
                        child: Text(
                          "You don't have an account?",
                          style: GoogleFonts.roboto(
                              fontSize: 13,
                              decoration: TextDecoration.underline),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
