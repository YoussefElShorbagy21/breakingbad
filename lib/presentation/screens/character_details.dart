import 'dart:math';

import 'package:breakingbad/business%20logic/cubit/character_cubit.dart';
import 'package:breakingbad/business%20logic/cubit/character_state.dart';
import 'package:breakingbad/constants/color.dart';
import 'package:breakingbad/data/model/charactersmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final CharactersModel charactersModel ;
  const CharacterDetailsScreen({super.key, required this.charactersModel});


  Widget buildSliverAppBar(){
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGery,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(charactersModel.nickname,
          style: const TextStyle(
            color: MyColors.myWhite,),
          textAlign: TextAlign.start,
        ),
        background: Hero(
          tag: charactersModel.char_id,
          child: Image.network(charactersModel.img,fit: BoxFit.cover,),
        ),
      ),
    );
  }

  Widget characterInfo(String title , String value){
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              color: MyColors.myWhite,
              fontWeight: FontWeight.bold,
              fontSize: 18
            ),
          ),

          TextSpan(
            text: value,
            style: const TextStyle(
                color: MyColors.myWhite,
                fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent){
    return Divider(
      height: 30,
      endIndent: endIndent,
      color: MyColors.myYellow,
      thickness: 2,
    );
  }

  Widget checkIfQuotesAreLoaded(CharacterState state){
    if(state is QuotesLoaded){
      return displayRandomQuoteOrEmptySpace(state);
    }else{
      return showProgressIndicator();
    }
  }

  Widget displayRandomQuoteOrEmptySpace(state){
    var quotes = (state).quotes;
    if(quotes.length != 0 ){
      int randomQuoteIndex = Random().nextInt(quotes.length -1 );
      return Center(
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            color: MyColors.myWhite,
            shadows: [
              Shadow(
                blurRadius: 7,
                color: MyColors.myYellow,
                offset: Offset(0,0),
              ),
            ],
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FlickerAnimatedText(quotes[randomQuoteIndex].quote),
            ],
          ),
        ),
      );
    }else{
      return Container();
    }
  }

  Widget showProgressIndicator(){
    return const Center(
      child: CircularProgressIndicator(color: MyColors.myYellow,),
    );
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharacterCubit>(context).getQuotes(charactersModel.name) ;
    return Scaffold(
      backgroundColor: MyColors.myGery,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    characterInfo('Job : ', charactersModel.occupation.join(' / ')),
                    buildDivider(315),
                    characterInfo('Appeared in : ', charactersModel.category),
                    buildDivider(250),
                    characterInfo('Seasons: ', charactersModel.appearance.join(' / ')),
                    buildDivider(280),
                    characterInfo('Status: ', charactersModel.status),
                    buildDivider(300),
                    charactersModel.better_call_saul_appearance.isEmpty ? Container() :
                    characterInfo('Better Call Saul Seasons: ', charactersModel.better_call_saul_appearance.join(' / ')),
                    charactersModel.better_call_saul_appearance.isEmpty ? Container() : buildDivider(150),
                    characterInfo('Actors/Actress: ', charactersModel.name),
                    buildDivider(235),
                    const SizedBox(height: 20,),

                    BlocBuilder<CharacterCubit,CharacterState>(
                      builder: (context , state){
                        return checkIfQuotesAreLoaded(state);
                      },
                    ),
                  ],
                ),

              ),
              const SizedBox(height: 500,)
            ],
            ),
          ),
        ],
      ),
    );
  }
}
