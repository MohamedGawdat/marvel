import 'dart:async';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:itg_test/data/models/person/people_model.dart';
import 'package:itg_test/data/network/ApiManager.dart';
import 'package:itg_test/data/network/ApiResponse.dart';
import 'package:itg_test/utilities/connictivity.dart';
import 'package:itg_test/utilities/toast.dart';
import '../../constants/constants.dart';

class PeopleManager {
  int totalCharacters = 0;
  int nextOffset = 0;
  late ApiResponseJson peopleApiResponse;
  List<CharacterHero> peopleResults = [];
  List<CharacterHero> characterSearchedResult = [];
  String searchKey = '';
  Future<List<CharacterHero>> getAllCharacters() async {
    if (await checkInternetConnection()) {
      return _getPeopleFromNetwork();
    } else
      return _getCachedCharacters();
  }

  Future<List<CharacterHero>> getSearchedCharacters(String searchKey) async {
    this.searchKey = searchKey;
    if (await checkInternetConnection()) {
      return _getPeopleFromNetworkSearch();
    } else
      return _getCachedCharacters();
  }

  Future<List<CharacterHero>> getNextPage() async {
    if (await checkInternetConnection()) {
      return _getPeopleNextPage();
    } else
      return peopleResults;
  }

  Future<List<CharacterHero>> resetPeopleList() async {
    if (await checkInternetConnection()) {
      return _resetPeopleList();
    } else
      return _getCachedCharacters();
  }

  FutureOr<List<CharacterHero>> _getCachedCharacters() async {
    // peopleResults = await AppCache.getPeopleListFromCache();
    return peopleResults;
  }

  FutureOr<List<CharacterHero>> _getPeopleFromNetwork() async {
    EasyLoading.show(status: 'loading...');

    peopleResults = await loadDataFromApi();

    EasyLoading.dismiss();

    return peopleResults;
  }

  FutureOr<List<CharacterHero>> _getPeopleFromNetworkSearch() async {
    characterSearchedResult = [];
    characterSearchedResult = await loadDataFromApiSearch();

    return characterSearchedResult;
  }

  FutureOr<List<CharacterHero>> _getPeopleNextPage() async {
    if (nextOffset < totalCharacters) {
      peopleResults = await loadDataFromApi();
      showToastSuccess(msg: 'Heros $nextOffset/$totalCharacters');
    } else {
      showToastError(msg: 'You Had Reach The Last Page');
    }

    return peopleResults;
  }

  FutureOr<List<CharacterHero>> _resetPeopleList() async {
    nextOffset = 0;
    peopleResults = [];
    peopleResults = await loadDataFromApi();
    showToastSuccess(msg: 'Refresh');
    return peopleResults;
  }

  Future<List<CharacterHero>> loadDataFromApi() async {
    ApiResponse response = await ApiManager.sendRequest(
        link:
            "public/characters?ts=1&apikey=${AppConst.apiAuthKey}&hash=${AppConst.apiAuthHash}&offset=$nextOffset",
        method: Method.GET);

    if (response.isSuccess) {
      print(response.data);
      peopleApiResponse =
          ApiResponseJson.fromJson(response.data as Map<String, dynamic>);
      peopleResults = peopleResults + peopleApiResponse.data!.results!;
      print(peopleApiResponse.data!.offset!);
      print(peopleApiResponse.data!.count!);
      totalCharacters = peopleApiResponse.data!.total!;
      nextOffset =
          peopleApiResponse.data!.offset! + peopleApiResponse.data!.limit!;
      return peopleResults;
    } else {
      EasyLoading.showError('Error');
      return peopleResults;
    }
  }

  Future<List<CharacterHero>> loadDataFromApiSearch() async {
    ApiResponse response = await ApiManager.sendRequest(
        link:
            "public/characters?ts=1&apikey=${AppConst.apiAuthKey}&hash=${AppConst.apiAuthHash}&nameStartsWith=$searchKey",
        method: Method.GET);

    if (response.isSuccess) {
      print(response.data);
      peopleApiResponse =
          ApiResponseJson.fromJson(response.data as Map<String, dynamic>);

      return peopleApiResponse.data!.results!;
    } else {
      // EasyLoading.showError('Error');
      return characterSearchedResult;
    }
  }
}
