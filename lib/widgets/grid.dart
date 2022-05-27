import 'dart:math';
import 'package:flutter/material.dart';

class Letter extends StatelessWidget {
  const Letter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Center(
          child: Text("A"),
        ),
      ),
    );
  }
}

class Word extends StatelessWidget {
  const Word({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Letter> letters = [];
    for (var i = 0; i < 5; ++i) {
      letters.add(const Letter());
    }
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: letters,
      ),
    );
  }
}

class Grid extends StatefulWidget {
  const Grid({Key? key}) : super(key: key);

  @override
  State<Grid> createState() => _GridState();
}

class _GridState extends State<Grid> {
  @override
  Widget build(BuildContext context) {
    List<Word> words = [];
    for (var i = 0; i < 6; ++i) {
      words.add(const Word());
    }
    double h = max(350, min(420, MediaQuery.of(context).size.width - 310));
    return Container(
      height: h,
      width: h / 6 * 5,
      margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: words,
      ),
    );
  }
}
