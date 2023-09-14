import 'package:flutter_riverpod/flutter_riverpod.dart';

enum LetterState {notInWord, inWordWrongPlace, inWordRightPlace}

class Letter {
  const Letter({required this.letter, required this.letterState, required this.id});

  final int id;
  final String letter;
  final LetterState letterState;

  Letter copyWith({int? id, String? letter, LetterState? letterState}) {
    return Letter(
      id: id ?? this.id,
      letter: letter ?? this.letter,
      letterState: letterState ?? this.letterState,
    );
  }
}

class LetterNotifier extends StateNotifier<List<Letter>> {
  LetterNotifier(): super(List.generate(30, (index) =>
          Letter(
              letter: " ",
              letterState: LetterState.notInWord,
              id: index)
      )
  );

  int guessCount = 0;

  void addLetter(Letter letter) {
    state = [...state, letter];
  }

  void removeLetter() {
    state.removeLast();
  }

  void guessMade() {
    guessCount++;
  }

}