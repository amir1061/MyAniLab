import 'package:flutter/material.dart';
import 'package:myanilab/Core/API/api.dart';
import 'package:myanilab/Core/Models/anime.dart';
import 'package:myanilab/Core/Utils/mal_exceptions.dart';

class SeasonalAnimeProvider with ChangeNotifier {
  static const int limit = 30;
  String season;
  String year;
  List<Anime>? animes;
  MalException? error;
  int offset = 0;
  bool canLoadMore = true;

  SeasonalAnimeProvider({required this.season, required this.year}) {
    init();
    getAnimes();
  }

  void init() {
    animes = null;
    error = null;
    canLoadMore = true;
    offset = 0;
  }

  Future<void> getAnimes() async {
    try {
      final moreAnimes = await API.getAnimeList(
        '/anime/season/$year/$season?offset=${offset * limit}&limit=$limit',
      );
      canLoadMore = moreAnimes.isNotEmpty;
      animes == null ? animes = moreAnimes : animes!.addAll(moreAnimes);
      offset++;
      error = null;
      notifyListeners();
    } on MalException catch (e) {
      error = e;
      notifyListeners();
    }
  }
}

class CustomSeasonalAnimeProvider extends SeasonalAnimeProvider {
  CustomSeasonalAnimeProvider({required String season, required String year})
      : super(season: season, year: year);
}
