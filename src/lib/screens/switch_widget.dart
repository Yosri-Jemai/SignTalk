import 'package:flutter/material.dart';

class Switcher extends StatelessWidget {
  final bool mode;
  final Function onTap;
  const Switcher({Key? key, required this.mode, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          alignment: Alignment.center,
          height: 40,
          width: 80,
          decoration: BoxDecoration(
            border: Border.all(
                color: const Color.fromARGB(255, 94, 135, 157), width: 2.0),
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          ),
          child: Text(
            mode ? 'Talker' : 'Non-Talker',
            style: const TextStyle(
                color: Color(0xFF3C4C64),
                fontWeight: FontWeight.w500,
                fontSize: 12),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(6.0),
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: Color.fromARGB(255, 44, 84, 103)),
          child: GestureDetector(
            onTap: () => onTap(),
            child: const Icon(Icons.repeat, color: Colors.white, size: 20),
          ),
        ),
        Container(
          alignment: Alignment.center,
          height: 40,
          width: 80,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF3C4C64), width: 2.0),
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          ),
          child: Text(
            mode ? 'Non-Talker' : 'Talker',
            style: const TextStyle(
                color: Color(0xFF3C4C64),
                fontWeight: FontWeight.w500,
                fontSize: 12),
          ),
        ),
      ],
    );
  }
}
