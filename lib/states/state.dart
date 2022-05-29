import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:wordle/states/words.dart';

enum LetterState { initial, correct, present, absent }

var letterStateColor = {
  LetterState.initial: null,
  LetterState.correct: Colors.green,
  LetterState.present: Colors.lightBlue,
  LetterState.absent: Colors.grey
};

class WordleState extends ChangeNotifier {
  bool isWin = false;
  bool isWordsAllowedReady = false;
  Set<String> wordsAllowed = {};
  bool isAnswerReady = false;
  String answer = "";
  final int guessTimes;
  final int wordLength;

  bool isGuessWordInvalid = false;

  List<List<String>> letterList = [];
  List<List<LetterState>> letterStateList = [];
  int currentRowIdx = 0;
  Map<String, LetterState> keyState = {};

  WordleState({required this.guessTimes, required this.wordLength}) {
    readAllowedWords().then((res) {
      wordsAllowed = res;
      isWordsAllowedReady = true;
    });

    reset();
  }

  reset() {
    isWin = false;
    isAnswerReady = false;
    generateAnswer(wordLength).then((ans) {
      answer = ans;
      isAnswerReady = true;
      if (kDebugMode) {
        print("Answer: $answer");
      }
    });

    isGuessWordInvalid = false;

    letterList = [];
    letterStateList = [];
    currentRowIdx = 0;
    keyState = {};

    for (var i = 0; i < guessTimes; ++i) {
      List<String> letterRow = [];
      List<LetterState> letterStateRow = [];
      for (var j = 0; j < wordLength; ++j) {
        letterRow.add("");
        letterStateRow.add(LetterState.initial);
      }
      letterList.add(letterRow);
      letterStateList.add(letterStateRow);
    }

    "abcdefghijklmnopqrstuvwxyz".split("").forEach((ch) {
      keyState[ch] = LetterState.initial;
    });
    notifyListeners();
  }

  pressKey(String key) {
    if (isWin || !isWordsAllowedReady || !isAnswerReady) {
      return;
    }
    if (currentRowIdx >= letterList.length) {
      return;
    }
    isGuessWordInvalid = false;
    for (var letterIdx = 0; letterIdx < wordLength; ++letterIdx) {
      if (letterList[currentRowIdx][letterIdx] == "") {
        letterList[currentRowIdx][letterIdx] = key.toLowerCase();
        notifyListeners();
        return;
      }
    }
  }

  pressBackspace() {
    if (isWin || !isWordsAllowedReady || !isAnswerReady) {
      return;
    }
    if (currentRowIdx >= letterList.length) {
      return;
    }
    isGuessWordInvalid = false;
    for (var letterIdx = wordLength - 1; letterIdx >= 0; --letterIdx) {
      if (letterList[currentRowIdx][letterIdx] != "") {
        letterList[currentRowIdx][letterIdx] = "";
        notifyListeners();
        return;
      }
    }
  }

  pressEnter() {
    if (isWin || !isWordsAllowedReady || !isAnswerReady) {
      return;
    }
    if (currentRowIdx >= letterList.length) {
      return;
    }
    String currentWord = "";
    for (var letterIdx = 0; letterIdx < wordLength; ++letterIdx) {
      if (letterList[currentRowIdx][letterIdx] == "") {
        isGuessWordInvalid = true;
        notifyListeners();
        return;
      }
      currentWord += letterList[currentRowIdx][letterIdx];
    }
    currentWord = currentWord.toLowerCase();
    if (!wordsAllowed.contains(currentWord)) {
      // print("The word '$currentWord' is invalid.");
      isGuessWordInvalid = true;
      notifyListeners();
      return;
    }
    letterStateList[currentRowIdx] = guessWord(currentWord, answer);
    for (var letterIdx = 0; letterIdx < wordLength; ++letterIdx) {
      String ch = letterList[currentRowIdx][letterIdx];
      switch (letterStateList[currentRowIdx][letterIdx]) {
        case LetterState.correct:
          keyState[ch] = LetterState.correct;
          break;
        case LetterState.present:
          if (keyState[ch] != LetterState.correct) {
            keyState[ch] = LetterState.present;
          }
          break;
        case LetterState.absent:
          if (keyState[ch] == LetterState.initial) {
            keyState[ch] = LetterState.absent;
          }
          break;
        case LetterState.initial:
          throw "ERROR";
      }
    }
    if (currentWord.toLowerCase() == answer.toLowerCase()) {
      isWin = true;
      // print("Win!");
    } else {
      ++currentRowIdx;
      if (currentRowIdx == letterList.length) {
        // print("Fail!");
      }
    }
    notifyListeners();
  }
}
