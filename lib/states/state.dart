import 'package:flutter/material.dart';

import 'package:wordle/states/words.dart';

enum LetterState { initial, correct, present, absent }

class WordleState extends ChangeNotifier {
  bool wordsAllowedReady = false;
  Set<String> wordsAllowed = {};
  bool answerReady = false;
  String answer = "";
  final int guessTimes;
  final int wordLength;

  List<List<String>> letterList = [];
  List<List<LetterState>> letterStateList = [];
  int currentRowIdx = 0;

  Map<String, LetterState> keyState = {};

  WordleState({required this.guessTimes, required this.wordLength}) {
    readAllowedWords().then((res) {
      wordsAllowed = res;
      wordsAllowedReady = true;
    });

    reset();
  }

  reset() {
    answerReady = false;
    generateAnswer(wordLength).then((ans) {
      answer = ans;
      answerReady = true;
      print("Answer: $answer");
    });

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
    if (!wordsAllowedReady || !answerReady) {
      return;
    }
    if (currentRowIdx >= letterList.length) {
      return;
    }
    for (var letterIdx = 0; letterIdx < wordLength; ++letterIdx) {
      if (letterList[currentRowIdx][letterIdx] == "") {
        letterList[currentRowIdx][letterIdx] = key.toLowerCase();
        notifyListeners();
        return;
      }
    }
  }

  pressEnter() {
    if (!wordsAllowedReady || !answerReady) {
      return;
    }
    if (currentRowIdx >= letterList.length) {
      return;
    }
    String currentWord = "";
    for (var letterIdx = 0; letterIdx < wordLength; ++letterIdx) {
      if (letterList[currentRowIdx][letterIdx] == "") {
        return;
      }
      currentWord += letterList[currentRowIdx][letterIdx];
    }
    currentWord = currentWord.toLowerCase();
    if (!wordsAllowed.contains(currentWord)) {
      print("The word is invalid.");
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
    ++currentRowIdx;
    notifyListeners();
  }

  pressBackspace() {
    if (!wordsAllowedReady || !answerReady) {
      return;
    }
    if (currentRowIdx >= letterList.length) {
      return;
    }
    for (var letterIdx = wordLength - 1; letterIdx >= 0; --letterIdx) {
      if (letterList[currentRowIdx][letterIdx] != "") {
        letterList[currentRowIdx][letterIdx] = "";
        notifyListeners();
        return;
      }
    }
  }
}
