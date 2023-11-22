import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Slicer extends StatelessWidget {
  final String word;
  const Slicer({Key? key, required this.word}) : super(key: key);

  Widget buildLetter(String char) {
    final Widget letter = SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/abc/${char.toLowerCase()}.png',
            height: 40,
            width: 40,
          ),
          const Divider(
            color: Colors.red,
            indent: 5,
          ),
          Text(
            char,
            style: GoogleFonts.poppins(),
          )
        ],
      ),
    );
    return letter;
  }

  List<Widget> generateSlicers(String word) {
    List<Widget> slicers = [];
    for (int i = 0; i < word.length; i++) {
      slicers.add(buildLetter(word[i]));
    }
    return slicers;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0, top: 8.0, bottom: 8.0),
        child: Container(
          padding: const EdgeInsets.only(top: 8.0, left: 5.0, right: 5.0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            boxShadow: [
              BoxShadow(
                  blurStyle: BlurStyle.outer,
                  color: Colors.black45,
                  blurRadius: 2)
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: generateSlicers(word),
          ),
        ),
      ),
    );
  }
}
