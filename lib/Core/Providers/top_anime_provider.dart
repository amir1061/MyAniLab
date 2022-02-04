import 'package:flutter/material.dart';
import 'package:myanilab/Core/API/api.dart';
import 'package:myanilab/Core/Models/anime.dart';
import 'package:myanilab/Core/Utils/mal_exceptions.dart';

class TopAnimeProvider with ChangeNotifier {
  final String rankingType;
  List<Anime>? animes;
  MalException? error;
  int limit = 30;
  int offset = 0;
  bool canLoadMore = true;

  TopAnimeProvider({required this.rankingType}) {
    _init();
    getAnimes();
  }

  void _init() {
    animes = null;
    error = null;
    canLoadMore = true;
    offset = 0;
  }

  void reset() {
    _init();
  }

  Future<void> getAnimes() async {
    try {
      var moreAnimes = await API.getAnimeList(
        '/anime/ranking?ranking_type=$rankingType&offset=$offset&limit=$limit',
      );
      canLoadMore = moreAnimes.isNotEmpty;
      if (animes == null) {
        animes = moreAnimes;
      } else {
        animes!.addAll(moreAnimes);
      }
      offset++;
      error = null;
      notifyListeners();
    } on MalException catch (e) {
      error = e;
      notifyListeners();
    }
  }
}
