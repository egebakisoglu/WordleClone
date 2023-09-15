import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordle/models/wordle_model.dart';
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
            Row(
              children: [
                for (final letter in letterList)
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                    ),
                    child: Text(letter.letterString),
                  ),
              ],
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