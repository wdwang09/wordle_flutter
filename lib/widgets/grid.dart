import 'dart:math';
import 'package:flutter/material.dart';

class Letter extends StatelessWidget {
  const Letter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double boxSize = min(min(size.width / 5, size.height / 5), 60);

    return Container(
      margin: const EdgeInsets.all(5.0),
      color: Colors.red,
      width: boxSize,
      height: boxSize,
      child: const Center(
        child: Text("A"),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: letters,
    );
  }
}

class Words extends StatefulWidget {
  const Words({Key? key}) : super(key: key);

  @override
  State<Words> createState() => _WordsState();
}

class _WordsState extends State<Words> {
  @override
  Widget build(BuildContext context) {
    List<Word> words = [];
    for (var i = 0; i < 6; ++i) {
      words.add(const Word());
    }
    return Container(
      // constraints: const BoxConstraints(maxWidth: 480),
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: words,
      ),
    );
  }
}
