import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordle/data/word_list.dart';

enum LetterState {initial, notInWord, inWord, correctLetter}
enum GameState {playing, won, lost}

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

  Color get backgroundColor {
    switch (letterState){
      case LetterState.initial:
        return Colors.transparent;
      case LetterState.notInWord:
        return const Color(0xFF616161);
      case LetterState.inWord:
        return const Color(0xFFF9A825);
      case LetterState.correctLetter:
        return const Color(0xFF4CAF50);
    }
  }
}

class LetterNotifier extends StateNotifier<List<Letter>> {
  LetterNotifier(): super([]
  );

  String randomWord = fiveLetterWords[Random().nextInt(fiveLetterWords.length)].toUpperCase();
  int guessCount = 1;
  GameState gameState = GameState.playing;

  void playAgain() {
    state = [];
    guessCount = 1;
    gameState = GameState.playing;
    randomWord = fiveLetterWords[Random().nextInt(fiveLetterWords.length)].toUpperCase();
  }

  void addLetter(Letter newLetter) {
    if (state.length < guessCount * 5) {
      state = [...state, newLetter
      ];
    }
  }

  void removeLetter() {
    if (state.length <= guessCount * 5 && state.length > guessCount * 5 - 5) {
      state = state.sublist(0, state.length - 1);
    }
  }

  void guessMade() {
    String guessWord = "";
    for (int i = guessCount * 5 - 5; i < guessCount * 5; i++) {
      guessWord += state[i].letterString;
    }
    
    if(state.length == guessCount * 5 && fiveLetterWords.contains(guessWord.toLowerCase())){
      int inPlaceWords = 0;
      List<Letter> newAddedWord = [];

      for (int i = guessCount * 5 - 5; i < guessCount * 5; i++) {
        String currentLetter = state[i].letterString;

        if (currentLetter == randomWord[i%5]){
          inPlaceWords++;
          newAddedWord.add(state[i].copyWith(letterState: LetterState.correctLetter));
        }
        else if (randomWord.contains(state[i].letterString)) {
          newAddedWord.add(state[i].copyWith(letterState: LetterState.inWord));
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

      guessCount++;

      if (guessCount > 6){
        gameState = GameState.lost;
      }

      if(inPlaceWords == 5){
        gameState = GameState.won;
      }
    }
    else {
      print("Not a valid 5 letter word");
    }
  }

}

final lettersProvider = StateNotifierProvider<LetterNotifier, List<Letter>> ((ref) {
  return LetterNotifier();
});