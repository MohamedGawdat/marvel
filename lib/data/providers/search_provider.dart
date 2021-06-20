import 'package:flutter/cupertino.dart';
import 'package:itg_test/data/models/person/people_model.dart';
import 'package:itg_test/data/providers/PeopleManager.dart';

class SearchProvider extends ChangeNotifier {
  List<CharacterHero> searchedCharacterResults = [];
  PeopleManager peopleManager = PeopleManager();

  getSearchedList(String searchKey) async {
    searchedCharacterResults =
        await peopleManager.getSearchedCharacters(searchKey);
    print(searchedCharacterResults.length);
    notifyListeners();
  }
}
