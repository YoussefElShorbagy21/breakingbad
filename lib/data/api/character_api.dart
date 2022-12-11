import 'package:breakingbad/constants/strings.dart';
import 'package:dio/dio.dart';

class CharacterApi{
  late Dio dio ;


  CharacterApi(){
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl ,
      receiveDataWhenStatusError: true,
      connectTimeout: 20*1000,
      receiveTimeout: 20*1000,
    );

    dio = Dio(options);
  }


  Future<List<dynamic>> getAllCharacter() async {
    try {
      Response response  = await dio.get('characters');
      return response.data ;
    } on Exception catch (e) {
      print(e.toString());
      return [] ;
    }
  }

  Future<List<dynamic>> getCharacterQuotes(String charName) async {
    try {
      Response response  = await dio.get('quote' , queryParameters:  {'author' : charName,});
      return response.data ;
    } on Exception catch (e) {
      print(e.toString());
      return [] ;
    }
  }
}