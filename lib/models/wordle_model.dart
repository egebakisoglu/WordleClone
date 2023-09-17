import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordle/data/word_list.dart';

enum LetterState {initial, notInWord, inWordWrongPlace, inWordRightPlace}

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

  String randomWord = fiveLetterWords[Random().nextInt(fiveLetterWords.length)].toUpperCase();
  int guessCount = 1;

  void clearList() {
    state = [];
  }

  void addLetter(Letter newLetter) {
    if (state.length < guessCount * 5) {
      state = [...state, newLetter
      ];
    }
    print(randomWord);
  }

  void removeLetter() {
    if (state.length <= guessCount * 5 && state.length > guessCount * 5 - 5) {
      state = state.sublist(0, state.length - 1);
    }
  }

  void guessMade() {
    if(state.length == guessCount * 5){
      int inPlaceWords = 0;
      List<Letter> newAddedWord = [];

      for (int i = guessCount * 5 - 5; i < guessCount * 5; i++) {
        if (state[i].letterString == randomWord[i%5]){
          inPlaceWords++;
          newAddedWord.add(state[i].copyWith(letterState: LetterState.inWordRightPlace));
        }
        else if (randomWord.contains(state[i].letterString)) {
          newAddedWord.add(state[i].copyWith(letterState: LetterState.inWordWrongPlace));
        }
        else {
          newAddedWord.add(state[i].copyWith(letterState: LetterState.notInWord));
        }
      }

      for (int i = 0; i < 5; i++){
        removeLetter();
      }

      for (int i = 0; i < 5; i++){
        addLetter(newAddedWord[i]);
      }

      if(inPlaceWords == 5){
        print('game won');
      }

      guessCount++;
    }
  }

}

final lettersProvider = StateNotifierProvider<LetterNotifier, List<Letter>> ((ref) {
  return LetterNotifier();
});