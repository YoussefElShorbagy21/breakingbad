import '../../data/model/charactersmodel.dart';
import '../../data/model/quotes.dart';

abstract class CharacterState{}

class CharacterInitial extends CharacterState {}

class CharacterLoaded extends CharacterState {
  final List<CharactersModel> characters;

  CharacterLoaded(this.characters);
}

class QuotesLoaded extends CharacterState {
  final List<Quotes> quotes;

  QuotesLoaded(this.quotes);
}