class Anime {
  Anime({
    required this.id,
    required this.title,
    required this.mainPicture,
  });
  late final int id;
  late final String title;
  late final MainPicture mainPicture;

  Anime.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    mainPicture = MainPicture.fromJson(json['main_picture']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['main_picture'] = mainPicture.toJson();
    return _data;
  }
}

class MainPicture {
  MainPicture({
    required this.medium,
    required this.large,
  });
  late final String medium;
  late final String large;

  MainPicture.fromJson(Map<String, dynamic> json) {
    medium = json['medium'];
    large = json['large'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['medium'] = medium;
    _data['large'] = large;
    return _data;
  }
}
