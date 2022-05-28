import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:wordle/widgets/grid.dart';
import 'package:wordle/widgets/keyboard.dart';
import 'package:wordle/state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WORDLE',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const int wordLength = 5;
    const int guessTimes = 6;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("WORDLE"),
      ),
      body: Center(
        child: ChangeNotifierProvider(
          create: (context) => WordleState(
            guessTimes: guessTimes,
            wordLength: wordLength,
          ),
          child: Column(
            children: const [
              Flexible(child: Grid()),
              Flexible(child: KeyBoard()),
            ],
          ),
        ),
      ),
    );
  }
}
