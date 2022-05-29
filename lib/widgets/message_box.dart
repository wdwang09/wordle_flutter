import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:wordle/states/state.dart';

class MessageBox extends StatelessWidget {
  const MessageBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String messageToShow = "";
    List<String> winMessages = [
      'Genius',
      'Magnificent',
      'Impressive',
      'Splendid',
      'Great',
      'Phew'
    ];
    return Consumer<WordleState>(builder: (context, state, child) {
      if (state.isWin) {
        messageToShow = winMessages[state.currentRowIdx];
      } else if (state.currentRowIdx == state.letterList.length) {
        messageToShow = state.answer.toUpperCase();
      } else if (state.isGuessWordInvalid) {
        messageToShow = "Invalid Word";
      } else {
        messageToShow = "";
      }
      return Text(
        messageToShow,
        style: const TextStyle(fontSize: 18),
      );
    });
  }
}
