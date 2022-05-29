import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:wordle/states/state.dart';

class Letter extends StatelessWidget {
  final int wordIdx;
  final int letterIdx;
  const Letter({
    required this.wordIdx,
    required this.letterIdx,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Consumer<WordleState>(builder: (context, state, child) {
        Color? containerColor;
        switch (state.letterStateList[wordIdx][letterIdx]) {
          case LetterState.absent:
            containerColor = Colors.grey;
            break;
          case LetterState.present:
            containerColor = Colors.blue;
            break;
          case LetterState.correct:
            containerColor = Colors.green;
            break;
          case LetterState.initial:
            containerColor = null;
            break;
        }

        return Container(
          margin: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(5),
            color: containerColor,
          ),
          child: FractionallySizedBox(
            widthFactor: 0.5,
            heightFactor: 0.5,
            child: FittedBox(
              child: Center(
                child: Text(
                  state.letterList[wordIdx][letterIdx].toUpperCase(),
                  // style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class Word extends StatelessWidget {
  final int wordLength;
  final int idx;
  const Word({required this.wordLength, required this.idx, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Letter> letters = [];
    for (var i = 0; i < wordLength; ++i) {
      letters.add(Letter(wordIdx: idx, letterIdx: i));
    }
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: letters,
      ),
    );
  }
}

class Grid extends StatelessWidget {
  final int guessTime;
  final int wordLength;
  const Grid({this.guessTime = 6, this.wordLength = 5, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Word> words = [];
    for (var i = 0; i < guessTime; ++i) {
      words.add(Word(wordLength: wordLength, idx: i));
    }
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: words,
      ),
    );
  }
}
