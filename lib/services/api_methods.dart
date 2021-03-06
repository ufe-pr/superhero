import 'dart:async';
import 'dart:io';
import 'package:superhero/models/character_model.dart';
import 'package:http/http.dart' as http;
import 'package:superhero/config_vars.dart';
import 'dart:convert';

const BASE_URL = 'https://superheroapi.com/api/$API_ACCESS_TOKEN';
const SEARCH_URL = '$BASE_URL/search';
const ID_URL = '$BASE_URL/id';

Future<List<Character>> getSearchResults(String keyword) async {
  var response;
  try {
    response = await http.get('$SEARCH_URL/$keyword');
    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      if (res['response'] == 'success') {
        var results = res['results'];
        List<Character> searchResults =
            List.from(results.map((result) => Character.fromMap(result)));
        return searchResults;
      }
      throw 'No results found';
    }
  } on TimeoutException{
    throw
        'Unable to fetch results. Check your connection and try again';
  }
  on SocketException{
    throw
        'Unable to fetch results. Check your connection and try again';
  }

  throw
      'Unable to fetch results. Check your connection and try again';
}

Future<Character> getCharacterWithId(int id) async {
  var response;

  try {
    response = await http.get('$ID_URL/$id');
    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      if (res['response'] == 'success') {
        Character character = Character.fromMap(res);
        return character;
      }
      throw 'Specified character not found';
    }
  } on TimeoutException {
    throw 'Unable to fetch character. Check your connection and try again';
  } on SocketException {
    throw
        'Unable to fetch character. Check your connection and try again';
  }
  throw
      'Unable to fetch character. Check your connection and try again';
}
