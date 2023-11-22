import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:signtalk/screens/online_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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

  final TextEditingController firstNameCtrl = TextEditingController();
  final TextEditingController lastNameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();
  final TextEditingController cpassCtrl = TextEditingController();

  String? firstNameError, lastNameError, emailError, passError, cpassError;
  bool isTalker = false;
  bool isNonTalker = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'SIGN UP',
                  style: GoogleFonts.secularOne(
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                      color: Colors.blue[900]),
                ),
              ),
              const Divider(),
              const SizedBox(height: 5),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                // ignore: prefer_const_constructors
                GestureDetector(
                  //borderRadius: const BorderRadius.all(Radius.circular(20)),
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
                        Navigator.of(context)
                            .pushReplacement(createRoute(const OnlineScreen()));
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
              ]),
              const SizedBox(height: 5),
              const Divider(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 32, horizontal: 10),
                child: Form(
                    child: Column(
                  children: [
                    TextFormField(
                      controller: firstNameCtrl,
                      onChanged: (value) {
                        if (firstNameError != null) {
                          setState(() => firstNameError = null);
                        }
                      },
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        label: Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: Text('First name',
                              style: GoogleFonts.poppins(fontSize: 13)),
                        ),
                        hintText: 'Enter first name',
                        errorText: firstNameError,
                        hintStyle: GoogleFonts.poppins(fontSize: 13),
                        prefixIcon: const Icon(Icons.account_circle),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      controller: lastNameCtrl,
                      onChanged: (value) {
                        if (lastNameError != null) {
                          setState(() => lastNameError = null);
                        }
                      },
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        errorText: lastNameError,
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red[300]!)),
                        label: Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: Text('Last name',
                              style: GoogleFonts.poppins(fontSize: 13)),
                        ),
                        hintText: 'Enter last name',
                        hintStyle: GoogleFonts.poppins(fontSize: 13),
                        prefixIcon: const Icon(Icons.account_circle),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      onChanged: (value) {
                        if (emailError != null) {
                          setState(() => emailError = null);
                        }
                      },
                      controller: emailCtrl,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        errorText: emailError,
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red[300]!)),
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
                      onChanged: (value) {
                        if (passError != null) {
                          setState(() => passError = null);
                        }
                      },
                      controller: passCtrl,
                      obscureText: true,
                      autocorrect: false,
                      enableSuggestions: false,
                      decoration: InputDecoration(
                        errorText: passError,
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red[300]!)),
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
                    TextFormField(
                      onChanged: (value) {
                        if (cpassError != null) {
                          setState(() => cpassError = null);
                        }
                      },
                      controller: cpassCtrl,
                      obscureText: true,
                      autocorrect: false,
                      enableSuggestions: false,
                      decoration: InputDecoration(
                        errorText: cpassError,
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red[300]!)),
                        hintText: 'Enter password',
                        hintStyle: GoogleFonts.poppins(fontSize: 13),
                        label: Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: Text('Confirm password',
                              style: GoogleFonts.poppins(fontSize: 13)),
                        ),
                        prefixIcon: const Icon(Icons.password, size: 22),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(children: [
                            Text("Hearing", style: GoogleFonts.poppins()),
                            Checkbox(
                              value: isTalker,
                              onChanged: (value) {
                                if (!isNonTalker) {
                                  setState(() => isTalker = value!);
                                }
                              },
                            )
                          ]),
                          Row(
                            children: [
                              Text("Deaf", style: GoogleFonts.poppins()),
                              Checkbox(
                                value: isNonTalker,
                                onChanged: (value) {
                                  if (!isTalker) {
                                    setState(() => isNonTalker = value!);
                                  }
                                },
                              )
                            ],
                          ),
                        ]),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        onPressed: () async {
                          if (firstNameCtrl.text.isEmpty) {
                            setState(() => firstNameError =
                                'Please enter your first name.');
                          } else if (lastNameCtrl.text.isEmpty) {
                            setState(() =>
                                lastNameError = 'Please enter your last name.');
                          } else if (emailCtrl.text.isEmpty) {
                            setState(
                                () => emailError = 'Please enter your email.');
                          } else if (passCtrl.text.isEmpty) {
                            setState(() =>
                                passError = 'Please enter your password.');
                          } else if (cpassCtrl.text.isEmpty) {
                            setState(() =>
                                cpassError = 'Please confirm your password');
                          } else if (cpassCtrl.text.compareTo(passCtrl.text) !=
                              0) {
                            setState(
                                () => cpassError = 'Password do not match.');
                          } else {
                            try {
                              final credential = await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                      email: emailCtrl.text,
                                      password: passCtrl.text);
                              credential.user?.updateDisplayName(
                                  '${firstNameCtrl.text} ${lastNameCtrl.text}');
                              if (!mounted) return;
                              Navigator.of(context).pushReplacement(
                                  createRoute(const OnlineScreen()));
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                setState(() => passError =
                                    'The password provided is too weak.');
                              } else if (e.code == 'email-already-in-use') {
                                setState(() => emailError =
                                    'An account already exists for that email.');
                              } else {
                                setState(() => cpassError = e.message);
                              }
                            } catch (e) {
                              debugPrint(e.toString());
                            }
                          }
                        },
                        color: Colors.blue[900],
                        textColor: Colors.white,
                        child: const Text('Sign up now'),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Text(
                        "Already have an account?",
                        style: GoogleFonts.roboto(
                            fontSize: 13, decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
