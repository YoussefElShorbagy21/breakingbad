import 'package:breakingbad/business%20logic/cubit/character_cubit.dart';
import 'package:breakingbad/business%20logic/cubit/character_state.dart';
import 'package:breakingbad/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

import '../../data/model/charactersmodel.dart';
import '../widget/character_item.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<CharactersModel> allCharacters ;

  late List<CharactersModel> searchedForCharacter ;
  bool  _isSearching= false ;
  final _searchTextController = TextEditingController() ;


  Widget _buildSearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: MyColors.myGery,
      decoration: const InputDecoration(
        hintText: 'Find a Character.....',
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: MyColors.myGery,
          fontSize: 18,),
      ),
      style: const TextStyle(
        color: MyColors.myGery,
        fontSize: 18,
      ),
      onChanged: (searchedCharacter){
        addSearchedForItemToSearchList(searchedCharacter);
      },
    );
  }

  void addSearchedForItemToSearchList(String searchedCharacter){
    searchedForCharacter  = allCharacters.where((character) =>
        character.name.toLowerCase().startsWith(searchedCharacter))
        .toList();
    setState(() {

    });
  }

  List<Widget> _buildAppBarActions(){
    if(_isSearching){
      return [
        IconButton(
            onPressed: (){
              _clearSearch();
              Navigator.pop(context);
        },
            icon: const Icon(Icons.clear,color: MyColors.myGery,))
      ];
    }else{
      return  [
        IconButton(
            onPressed: _startSearch,
            icon: const Icon(Icons.search,color: MyColors.myGery,))
      ];
    }
  }

  void _startSearch(){
     ModalRoute.of(context)!.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

     setState(() {
       _isSearching = true ;
     });
  }
  void _stopSearching(){
    _clearSearch();
    setState(() {
      _isSearching = false ;
    });
  }
  void _clearSearch(){
    setState(() {
      _searchTextController.clear();
    });
  }


  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharacterCubit>(context).getAllCharacters() ;}

  Widget buildBlocWidget(){
    return BlocBuilder<CharacterCubit,CharacterState>(
      builder: (context, state){
        if(state is CharacterLoaded) {
          allCharacters = (state).characters;
          return buildLoadedListWidgets();
          }else{
          return showLoadingIndicator();
        }
      },
    );
  }
  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }
  Widget buildLoadedListWidgets(){
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myGery,
        child: Column(
          children:
          [
            buildCharactersList() ,
          ],
        ),
      ),
    );
  }
  Widget buildCharactersList(){
    return GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 2/3,
      crossAxisSpacing: 1,
      mainAxisSpacing: 1,
    ),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: _searchTextController.text.isEmpty ?  allCharacters.length : searchedForCharacter.length,
        itemBuilder: (context,index){
      return  CharacterItem(
        charactersModel: _searchTextController.text.isEmpty ? allCharacters[index] : searchedForCharacter[index],
      );
        });
  }
  Widget _buildAppBarTitle(){
    return const Text('Characters',
      style: TextStyle(
        color: MyColors.myGery,
      ),);
  }

  Widget buildNotInternetWidget(){
    return Center(
      child: Container(
        color: MyColors.myWhite,
        child: Column(
          children:  [
            const SizedBox(
              height: 20,
            ),
            const Text('Can\'t connect.....check internet',
            style: TextStyle(
              color: MyColors.myGery,
              fontSize: 22,
            ),
            ),
            Center(
              child: Image.asset('assets/image/undraw_Around_the_world_re_rb1p.png',
              ),
            ),
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: _isSearching ? const BackButton(color: MyColors.myGery,) : Container(),
        backgroundColor: MyColors.myYellow,
        title: _isSearching ? _buildSearchField() : _buildAppBarTitle() ,
        actions: _buildAppBarActions(),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,){
          final bool connected = connectivity != ConnectivityResult.none ;
          if(connected) {
            return buildBlocWidget();
            }else{
            return buildNotInternetWidget();
          }
        },
        child: showLoadingIndicator(),
      ),
    );
  }
}
