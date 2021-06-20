class DataImagesResult {
  int? offset;
  int? limit;
  int? total;
  int? count;
  List<ResultsCharacterGallery>? results = [];
  DataImagesResult();

  DataImagesResult.fromJson(Map<String, dynamic> json) {
    offset = json['offset'];
    limit = json['limit'];
    total = json['total'];
    count = json['count'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results!.add(new ResultsCharacterGallery.fromJson(v));
      });
    }
  }
}

class ResultsCharacterGallery {
  CharacterGallery? series;
  CharacterGallery? stories;
  CharacterGallery? comics;
  CharacterGallery? events;

  ResultsCharacterGallery();

  ResultsCharacterGallery.fromJson(Map<String, dynamic> json) {
    print('json${json['images']}');
    comics =
        json['images'] != null ? new CharacterGallery.fromJson(json) : null;
    stories = json['stories'] != null
        ? new CharacterGallery.fromJson(json['stories'])
        : null;

    events = json['events'] != null
        ? new CharacterGallery.fromJson(json['events'])
        : null;
  }
}

class CharacterGallery {
  List<Images>? images;

  CharacterGallery({this.images});

  CharacterGallery.fromJson(Map<String, dynamic> json) {
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  String? path;
  String? extension;

  Images({this.path, this.extension});

  Images.fromJson(Map<String, dynamic> json) {
    path = json['path'];
    extension = json['extension'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['path'] = this.path;
    data['extension'] = this.extension;
    return data;
  }
}
