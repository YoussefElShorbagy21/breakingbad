import 'package:breakingbad/data/api/character_api.dart';
import 'package:breakingbad/data/model/quotes.dart';

import '../model/charactersmodel.dart';

class CharacterRepository{

  final CharacterApi characterApi ;

  CharacterRepository(this.characterApi);

  Future<List<CharactersModel>> getAllCharacter() async {
    final characters = await characterApi.getAllCharacter() ;

    return characters.map((character) => CharactersModel.fromJson(character)).toList();
  }

  Future<List<Quotes>> getCharacterQuotes(String charName) async {
    final quotes = await characterApi.getCharacterQuotes(charName) ;

    return quotes.map((quotes) => Quotes.fromJson(quotes)).toList();
  }
}