import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:itg_test/constants/constants.dart';
import 'package:itg_test/data/models/person/people_model.dart';
import 'package:itg_test/data/models/person/person_gallery.dart';
import 'package:itg_test/data/network/ApiManager.dart';
import 'package:itg_test/data/network/ApiResponse.dart';

class PersonDetailsProvider extends ChangeNotifier {
  // List<Comics> profileGalleryComics = [];
  // List<Comics> profileGallerySeries = [];
  // List<Comics> profileGalleryStories = [];
  // List<Comics> profileGalleryEvents = [];
  DataImagesResult personGallery = DataImagesResult();
  fetchPersonImages(int id) async {
    EasyLoading.show(status: 'loading...');

    ApiResponse responseComics = await ApiManager.sendRequest(
        link:
            "public/characters/${id.toString()}/comics?ts=1&apikey=${AppConst.apiAuthKey}&hash=${AppConst.apiAuthHash}",
        method: Method.GET);

    if (responseComics.isSuccess) {
      // print(responseComics.data!['data']['results']);
      personGallery = DataImagesResult.fromJson(
          responseComics.data!['data'] as Map<String, dynamic>);
    }

    EasyLoading.dismiss();

    notifyListeners();
  }
}
