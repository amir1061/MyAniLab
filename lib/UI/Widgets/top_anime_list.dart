import 'package:flutter/material.dart';
import 'package:myanilab/Core/Providers/top_anime_provider.dart';
import 'package:myanilab/UI/Widgets/anime_list.dart';
import 'package:provider/provider.dart';

class TopAnimeList<T> extends StatefulWidget {
  final String type;
  const TopAnimeList({Key? key, required this.type}) : super(key: key);

  @override
  _TopAnimeListState createState() => _TopAnimeListState();
}

class _TopAnimeListState extends State<TopAnimeList>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (_) => TopAnimeProvider(rankingType: widget.type),
      child: AnimeList<TopAnimeProvider>(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
