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
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                child: WordleInput(letterList: letterList),
              ),
            ),
            WordleKeyboard(
              keyboardList: keyboardList,
              ref: ref,
            ),
          ],
        ),
      )
    );
  }
}