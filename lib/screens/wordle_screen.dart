import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordle/models/wordle_model.dart';

class WordleScreen extends ConsumerWidget{
  const WordleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    List<Letter> letterList = ref.watch(lettersProvider);
    
    return Scaffold(

    );
  }
}