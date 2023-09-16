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
            color: Colors.grey[800],
          ),
          child: Text(index >= letterList.length ? " " : letterList[index].letterString),
        );
      },
    );
  }
}
