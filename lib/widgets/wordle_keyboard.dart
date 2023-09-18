import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordle/models/wordle_model.dart';

class WordleKeyboard extends StatelessWidget {
  final List<List<String>> keyboardList;
  final WidgetRef ref;
  final List<Letter> letterList;

  const WordleKeyboard({
    super.key,
    required this.keyboardList,
    required this.ref,
    required this.letterList,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 80),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var item in keyboardList[0])
                KeyboardKey(
                  keyText: item,
                  ref: ref,
                  letterList: letterList,
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
                  letterList: letterList,
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
                  letterList: letterList,
                )
            ],
          ),
        ],
      ),
    );
  }
}

class KeyboardKey extends StatelessWidget {
  final String keyText;
  final WidgetRef ref;
  final List<Letter> letterList;

  const KeyboardKey({
    super.key,
    required this.keyText,
    required this.ref,
    required this.letterList,
  });

  Color findLetterColor() {
    for (var letter in letterList) {
      if (letter.letterString == keyText &&
          letter.letterState != LetterState.initial) {
        return letter.backgroundColor;
      }
    }
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (keyText == "DEL"){
          ref.read(lettersProvider.notifier).removeLetter();
        }
        else if (keyText == "ENTER"){
          ref.read(lettersProvider.notifier).guessMade();
        }
        else {
          ref.read(lettersProvider.notifier).addLetter(
              Letter(
                  letterState: LetterState.initial,
                  letterString: keyText,
              )
          );
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2, vertical: 4),
        padding: EdgeInsets.symmetric(horizontal: 12),
        height: 60,
        decoration: BoxDecoration(
          color: findLetterColor(),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Center(
          child: Text(keyText,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
