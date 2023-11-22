import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnlineScreen extends StatefulWidget {
  const OnlineScreen({Key? key}) : super(key: key);

  @override
  State<OnlineScreen> createState() => _OnlineScreenState();
}

class _OnlineScreenState extends State<OnlineScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 12.0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 225, 225, 225),
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: Icon(Icons.search, color: Colors.grey[600]),
                      ),
                      Expanded(
                        child: TextFormField(
                          cursorColor: Colors.grey[500],
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search for friends",
                              hintStyle: GoogleFonts.poppins(fontSize: 12)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(-0.89, 0.0),
                child: Text(
                  'FRIENDS ONLINE',
                  style: GoogleFonts.outfit(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF021334),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    child: Image.asset('assets/images/fares.jpg',
                        height: 50, width: 50),
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    child: Image.asset('assets/images/islem.jpg',
                        height: 50, width: 50),
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    child: Image.asset('assets/images/choura.jpg',
                        height: 50, width: 50),
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    child: Image.asset('assets/images/yosri.jpg',
                        height: 50, width: 50),
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    child: Image.asset('assets/images/mariam.jpg',
                        height: 50, width: 50),
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    child: Image.asset('assets/images/racem.jpg',
                        height: 50, width: 50),
                  )
                ],
              ),
              const Conversation(
                  sender: 'Islem Messaoud',
                  text: 'Islem sent : Product owner',
                  img: 'islem'),
              const Conversation(
                  sender: 'Racem Choura',
                  text: 'Racem sent a voice message',
                  img: 'choura'),
              const Conversation(
                  sender: 'Mariam Khlif',
                  text: 'Mariam sent a sign video',
                  img: 'mariam'),
              const Conversation(
                  sender: 'Yosri Jemaii', text: 'Replied : Okay', img: 'yosri'),
              const Conversation(
                  sender: 'Fares Dammak',
                  text: 'Fares sent : I am ready',
                  img: 'fares'),
              const Conversation(
                  sender: 'Racem Hachicha',
                  text: 'Racem sent : Scrum master',
                  img: 'racem'),
            ],
          ),
        ),
      ),
    );
  }
}

class Conversation extends StatelessWidget {
  final String sender, text, img;
  const Conversation(
      {Key? key, required this.sender, required this.text, required this.img})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        Row(children: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0, left: 5),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(40)),
              child:
                  Image.asset('assets/images/$img.jpg', height: 55, width: 55),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(sender,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
              const SizedBox(height: 3),
              Text(text,
                  style: GoogleFonts.poppins(
                      color: Colors.grey[600], fontSize: 12))
            ],
          )
        ]),
      ],
    );
  }
}
