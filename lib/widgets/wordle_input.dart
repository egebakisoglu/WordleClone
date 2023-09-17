import 'package:flutter/material.dart';
import 'package:wordle/models/wordle_model.dart';

class WordleInput extends StatelessWidget {
  final List<Letter> letterList;
  const WordleInput({
    super.key,
    required this.letterList,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
      ),
      itemCount: 30,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 4, vertical: 5),
          decoration: BoxDecoration(
            color: letterList.length > index
                ? letterList[index].letterState == LetterState.inWordRightPlace
                    ?Colors.green
                    :Colors.grey[700]
                : Colors.grey[900],
            border: Border.all(
              color: Color(0xFF424242),
              width: 2,
            )
          ),
          child: Center(
            child: Text(
              index >= letterList.length ? " " : letterList[index].letterString,
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
