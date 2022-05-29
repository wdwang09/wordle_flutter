import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:wordle/widgets/grid.dart';
import 'package:wordle/widgets/keyboard.dart';
import 'package:wordle/states/state.dart';

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
    return ChangeNotifierProvider(
      create: (context) => WordleState(
        guessTimes: guessTimes,
        wordLength: wordLength,
      ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("WORDLE"),
          actions: [
            Consumer<WordleState>(builder: (context, state, child) {
              return IconButton(
                onPressed: () {
                  state.reset();
                },
                icon: const Icon(Icons.refresh),
              );
            }),
          ],
        ),
        body: Center(
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
