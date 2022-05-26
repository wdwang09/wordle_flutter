import 'package:flutter/material.dart';

class KeyLetter extends StatelessWidget {
  const KeyLetter({required this.s, this.flexFactor = 1, Key? key})
      : super(key: key);

  final String s;
  final int flexFactor;

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (s == " ") {
      child = Container();
    } else {
      child = Container(
        margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
        height: 48,
        color: const Color(0xffd3d6da),
        child: MaterialButton(
          onPressed: () {},
          child: Text(s),
        ),
      );
    }
    return Flexible(
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
      var strList = ["Enter"] + "ZXCVBNM".split("") + ["Back"];
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
      constraints: const BoxConstraints(maxWidth: 480, maxHeight: 200),
      child: Column(
        children: keyRows,
      ),
    );
  }
}
