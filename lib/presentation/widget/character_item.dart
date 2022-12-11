import 'package:breakingbad/constants/color.dart';
import 'package:breakingbad/data/model/charactersmodel.dart';
import 'package:flutter/material.dart';

import '../../constants/strings.dart';

class CharacterItem extends StatelessWidget {
  final CharactersModel charactersModel ;
  const CharacterItem({Key? key, required this.charactersModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
        color: MyColors.myWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, characterDetailsScreen, arguments: charactersModel),
        child: GridTile(
          footer: Hero(
            tag: charactersModel.char_id,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
              color: Colors.black54,
              alignment: Alignment.bottomCenter,
              child: Text(
                charactersModel.name,
                style: const TextStyle(
                  height: 1.3,
                  fontSize: 16,
                  color: MyColors.myWhite,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          child: Container(
            color: MyColors.myGery,
            child: charactersModel.img.isNotEmpty ?
            FadeInImage.assetNetwork(
              width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                placeholder: 'assets/image/loading.gif',
                image: charactersModel.img) : Image.asset('assets/image'),
          ),
        ),
      ),
    );
  }
}
