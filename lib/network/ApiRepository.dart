import 'package:drinkapp/modals/DrinkModal.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:http_parser/http_parser.dart';

class ApiRepository {

  var headers = {
    'Content-Type': 'application/json'
  };

  final String BASE_API_LINK_URL = 'https://www.thecocktaildb.com';

  ///Shared Preference
  Future<List<DrinkModal>?> getDrinkMasters(String searchText) async {
    var headers = {
      'Content-Type': 'application/json',
      "Access-Control_Allow_Origin": "*"
    };

    var request = http.Request('POST', Uri.parse('$BASE_API_LINK_URL/api/json/v1/1/search.php?s=$searchText'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String result = await response.stream.bytesToString();
      print(result);
      Map valueMap = jsonDecode(result);
      print(valueMap.runtimeType);
      print("valueMap[drinks]");
      print(valueMap["drinks"]);
      print("drinkModalList.length");
      List? drinksList = valueMap["drinks"];
      List<DrinkModal> drinkModalList = [];
      drinksList?.forEach((element) {
        print("element");
        print(element);
        drinkModalList.add(DrinkModal.fromJson(element));
      });
      print("Dasas");
      print(drinkModalList.first.strAlcoholic);
      return drinkModalList;
    }
    else {
      /*print("response.reasonPhrase");
      print(response.reasonPhrase);
      return false;*/
    }
  }
}