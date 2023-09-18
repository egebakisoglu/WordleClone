import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordle/models/wordle_model.dart';
import 'package:wordle/widgets/wordle_input.dart';
import 'package:wordle/widgets/wordle_keyboard.dart';

class WordleScreen extends ConsumerWidget{
  const WordleScreen({super.key});

  final List<List<String>> keyboardList = const [
    ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"],
    ["A", "S", "D", "F", "G", "H", "J", "K", "L"],
    ["ENTER", "Z", "X", "C", "V", "B", "N", "M", "DEL"],
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref){
    List<Letter> letterList = ref.watch(lettersProvider);
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.grey[700],
        centerTitle: true,
        elevation: 8,
        leading: Icon(Icons.info_outline),
        actions: [
          Icon(Icons.leaderboard_outlined),
          SizedBox(width: 20),
          Icon(Icons.settings),
          SizedBox(width: 20),
        ],
        title: Text(
          "WORDLE",
          style: TextStyle(
            fontSize: 40,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: WordleInput(letterList: letterList),
              ),
            ),
            if (ref.read(lettersProvider.notifier).gameState == GameState.playing)
              WordleKeyboard(
                keyboardList: keyboardList,
                ref: ref,
                letterList: letterList,
              )
            else if (ref.read(lettersProvider.notifier).gameState == GameState.won)
              gameEnding(ref, "won!")
            else
              gameEnding(ref, "lost."),
          ],
        ),
      )
    );
  }

  Container gameEnding(WidgetRef ref, String result) {
    return Container(
      height: 250,
      width: 350,
      margin: EdgeInsets.only(bottom: 80),
      padding: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.grey[600],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 10,
            spreadRadius: 3,
            offset: Offset(0, 7),
          )
        ]
      ),
      child: Column(
        children: [
          Text(
            "You $result",
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
            ),
          ),
          Text(
            "The word was ${ref.read(lettersProvider.notifier).randomWord}",
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
            ),
          ),
          InkWell(
            onTap: ref.read(lettersProvider.notifier).playAgain,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              margin: EdgeInsets.only(top: 25),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 5,
                    spreadRadius: 1,
                    offset: Offset(0,2),
                  )
                ]
              ),
              child: Text(
                "Play again?",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}