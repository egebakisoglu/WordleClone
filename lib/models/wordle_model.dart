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

  int guessCount = 0;
  int lettersWritten = 0;

  void clearList() {
    state = [];
  }

  void addLetter(String letterText) {
    state = [...state, Letter(
      letterState: LetterState.notInWord,
      letterString: letterText,
    )
    ];
    lettersWritten += 1;
  }

  void removeLetter() {
    state.removeLast();
    lettersWritten -= 1;
  }

  void guessMade() {
    guessCount++;
  }

}

final lettersProvider = StateNotifierProvider<LetterNotifier, List<Letter>> ((ref) {
  return LetterNotifier();
});