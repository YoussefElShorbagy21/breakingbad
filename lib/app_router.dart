import 'package:breakingbad/business%20logic/cubit/character_cubit.dart';
import 'package:breakingbad/constants/strings.dart';
import 'package:breakingbad/data/model/charactersmodel.dart';
import 'package:breakingbad/presentation/screens/character_details.dart';
import 'package:breakingbad/presentation/screens/characters_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/api/character_api.dart';
import 'data/respository/charater_repositry.dart';

class AppRouter{
  late CharacterRepository characterRepository ;
  late CharacterCubit characterCubit ;

  AppRouter(){
    characterRepository = CharacterRepository(CharacterApi());
    characterCubit = CharacterCubit(characterRepository);
  }

  Route? generateRoute(RouteSettings settings){
    switch(settings.name){
      case charactersScreen:
        return MaterialPageRoute(builder: (_)=> BlocProvider(
          create: (BuildContext context) => characterCubit,
          child: const CharactersScreen(),
        )
        );


      case characterDetailsScreen:
        final characterSelected = settings.arguments as CharactersModel ;
        return MaterialPageRoute(builder: (_)=> BlocProvider(
          create: (context) => CharacterCubit(characterRepository),
            child: CharacterDetailsScreen(charactersModel: characterSelected,)
        ),
        );
    }
    return null;
  }
}