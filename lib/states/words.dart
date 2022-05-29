import 'dart:math';
import 'package:flutter/services.dart' show rootBundle;

import 'package:wordle/states/state.dart';

List<LetterState> guessWord(String guess, String answer) {
  assert(guess.length == answer.length);
  final int len = guess.length;
  List<LetterState> res = [];
  for (var i = 0; i < len; ++i) {
    res.add(LetterState.absent);
  }
  for (var i = 0; i < len; ++i) {
    if (answer[i] == guess[i]) {
      res[i] = LetterState.correct;
      continue;
    }
    for (var j = 0; j < len; ++j) {
      if (i == j || res[j] != LetterState.absent) {
        continue;
      }
      if (answer[i] == guess[j]) {
        res[j] = LetterState.present;
        break;
      }
    }
  }
  return res;
}

Future<Set<String>> readAllowedWords() async {
  String wordsAllowedRaw =
      await rootBundle.loadString('lib/assets/words_allowed.txt');
  wordsAllowedRaw = wordsAllowedRaw.replaceAll("\r", "");
  Set<String> wordsAllowed = wordsAllowedRaw.split("\n").toSet();
  String wordsAnswerRaw =
      await rootBundle.loadString('lib/assets/words_answer.txt');
  wordsAnswerRaw = wordsAnswerRaw.replaceAll("\r", "");
  Set<String> wordsAnswer = wordsAnswerRaw.split("\n").toSet();
  wordsAllowed = wordsAllowed.union(wordsAnswer);
  wordsAllowed.remove("");
  return wordsAllowed;
}

Future<String> generateAnswer(int wordLength) async {
  String wordsAnswerRaw =
      await rootBundle.loadString('lib/assets/words_answer.txt');
  wordsAnswerRaw = wordsAnswerRaw.replaceAll("\r", "");
  List<String> wordsAnswer = wordsAnswerRaw.split("\n");
  if (wordsAnswer[wordsAnswer.length - 1] == "") {
    wordsAnswer.removeLast();
  }
  return wordsAnswer[Random().nextInt(wordsAnswer.length)];
}
