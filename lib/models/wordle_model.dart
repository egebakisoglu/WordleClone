import 'package:flutter_riverpod/flutter_riverpod.dart';

enum LetterState {notInWord, inWordWrongPlace, inWordRightPlace}

class Letter {
  const Letter({required this.letterString, required this.letterState});

  final String letterString;
  final LetterState letterState;

  Letter copyWith({int? id, String? letterString, LetterState? letterState}) {
    return Letter(
      letterString: letterString ?? this.letterString,
      letterState: letterState ?? this.letterState,
    );
  }
}

class LetterNotifier extends StateNotifier<List<Letter>> {
  LetterNotifier(): super([]
  );

  int guessCount = 1;

  void clearList() {
    state = [];
  }

  void addLetter(String letterText) {
    if (state.length < guessCount * 5) {
      state = [...state, Letter(
        letterState: LetterState.notInWord,
        letterString: letterText,
      )
      ];
    }
  }

  void removeLetter() {
    if (state.length <= guessCount * 5 && state.length > guessCount * 5 - 5) {
      state = state.sublist(0, state.length - 1);
    }
  }

  void guessMade() {
    guessCount++;
  }

}

final lettersProvider = StateNotifierProvider<LetterNotifier, List<Letter>> ((ref) {
  return LetterNotifier();
});