import 'package:flutter/cupertino.dart';
import 'package:itg_test/data/models/person/people_model.dart';
import 'package:itg_test/data/providers/PeopleManager.dart';

class HomeScreenProvider extends ChangeNotifier {
  List<CharacterHero> charactersResult = [];
  PeopleManager peopleManager = PeopleManager();
  getPopularCharactersList() async {
    charactersResult = await peopleManager.getAllCharacters();
    print(charactersResult.length);
    notifyListeners();
  }

  fetchNextPage() async {
    charactersResult = await peopleManager.getNextPage();
    notifyListeners();
  }

  resetPeopleList() async {
    charactersResult = await peopleManager.resetPeopleList();

    notifyListeners();
  }
}
