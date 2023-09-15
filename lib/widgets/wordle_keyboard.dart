import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordle/models/wordle_model.dart';

class WordleKeyboard extends StatelessWidget {
  final List<List<String>> keyboardList;
  final WidgetRef ref;

  const WordleKeyboard({
    super.key,
    required this.keyboardList,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var item in keyboardList[0])
              KeyboardKey(
                keyText: item,
                ref: ref,
              )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var item in keyboardList[1])
              KeyboardKey(
                keyText: item,
                ref: ref,
              )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var item in keyboardList[2])
              KeyboardKey(
                keyText: item,
                ref: ref,
              )
          ],
        ),
      ],
    );
  }
}

class KeyboardKey extends StatelessWidget {
  final String keyText;
  final WidgetRef ref;

  const KeyboardKey({
    super.key,
    required this.keyText,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (keyText == "DEL"){
          ref.read(lettersProvider.notifier).clearList();
        }
        else {
          ref.read(lettersProvider.notifier).addLetter(keyText);
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2, vertical: 4),
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 20),
        height: 55,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(3),
        ),
        child: Text(keyText,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}