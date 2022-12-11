import 'package:breakingbad/business%20logic/cubit/character_state.dart';
import 'package:breakingbad/data/model/quotes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/charactersmodel.dart';

import '../../data/respository/charater_repositry.dart';

class CharacterCubit extends Cubit<CharacterState>
{

  final CharacterRepository characterRepository ;
  List<CharactersModel> characters = [];
  CharacterCubit(this.characterRepository) : super(CharacterInitial());

  List<CharactersModel> getAllCharacters(){
    characterRepository.getAllCharacter().then((value){
      emit(CharacterLoaded(value));
      characters = value ;
    }) ;

    return characters ;
  }

  void getQuotes(String charName){
    characterRepository.getCharacterQuotes(charName).then((value){
      emit(QuotesLoaded(value));
    }) ;
  }
}