import 'package:flutter/material.dart';

enum LetterState { initial, correct, present, absent }

class WordleState extends ChangeNotifier {
  String answer = "";
  final int guessTimes;
  final int wordLength;

  List<List<String>> letterList = [];
  List<List<LetterState>> letterStateList = [];
  int currentRowIdx = 0;

  Map<String, LetterState> keyState = {};

  WordleState({required this.guessTimes, required this.wordLength}) {
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
  }

  pressKey(String key) {
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
    if (currentRowIdx >= letterList.length) {
      return;
    }
    print("TODO");
  }

  pressBackspace() {
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
