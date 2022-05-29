import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:wordle/states/state.dart';

class KeyLetter extends StatelessWidget {
  final String s;
  final int flexFactor;

  const KeyLetter({required this.s, this.flexFactor = 1, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (s == " ") {
      child = Container(
        margin: const EdgeInsets.fromLTRB(3, 5, 3, 5),
        height: 48,
      );
    } else {
      child = Consumer<WordleState>(builder: (context, state, child) {
        Color? containerColor;
        switch (state.keyState[s.toLowerCase()]) {
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
          case null:
            break;
        }

        return Container(
          margin: const EdgeInsets.fromLTRB(3, 5, 3, 5),
          height: 48,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(5),
            color: containerColor,
          ),
          child: TextButton(
            style: TextButton.styleFrom(
              primary: Colors.black,
            ),
            onPressed: () {
              if (s == "OK") {
                state.pressEnter();
              } else if (s == "<-") {
                state.pressBackspace();
              } else {
                state.pressKey(s);
              }
            },
            child: Text(s.toUpperCase()),
          ),
        );
      });
    }
    return Flexible(
      fit: FlexFit.tight,
      flex: flexFactor,
      child: child,
    );
  }
}

class KeyRow extends StatelessWidget {
  final int id;
  const KeyRow({required this.id, Key? key}) : super(key: key);

  List<KeyLetter> generate() {
    List<KeyLetter> l = [];
    if (id == 1) {
      for (var el in "QWERTYUIOP".split("")) {
        l.add(KeyLetter(s: el));
      }
    } else if (id == 2) {
      var strList = " ASDFGHJKL ".split("");
      for (var i = 0; i < strList.length; ++i) {
        if (i == 0 || i == strList.length - 1) {
          l.add(KeyLetter(
            s: strList[i],
            flexFactor: 1,
          ));
        } else {
          l.add(KeyLetter(
            s: strList[i],
            flexFactor: 2,
          ));
        }
      }
    } else if (id == 3) {
      var strList = ["OK"] + "ZXCVBNM".split("") + ["<-"];
      for (var i = 0; i < strList.length; ++i) {
        if (i == 0 || i == strList.length - 1) {
          l.add(KeyLetter(
            s: strList[i],
            flexFactor: 3,
          ));
        } else {
          l.add(KeyLetter(
            s: strList[i],
            flexFactor: 2,
          ));
        }
      }
    }
    return l;
  }

  @override
  Widget build(BuildContext context) {
    var l = generate();
    return Flexible(
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: l,
      ),
    );
  }
}

class KeyBoard extends StatelessWidget {
  const KeyBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<KeyRow> keyRows = [];
    keyRows.add(const KeyRow(id: 1));
    keyRows.add(const KeyRow(id: 2));
    keyRows.add(const KeyRow(id: 3));
    return Container(
      margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
      constraints: const BoxConstraints(maxWidth: 480),
      child: Column(
        children: keyRows,
      ),
    );
  }
}
