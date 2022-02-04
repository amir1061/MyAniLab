import 'package:flutter/material.dart';
import 'package:myanilab/Core/Providers/top_anime_provider.dart';
import 'package:myanilab/UI/Widgets/anime_list.dart';
import 'package:provider/provider.dart';

class TopAnimeView extends StatelessWidget {
  const TopAnimeView({Key? key}) : super(key: key);

  static const tabs = {
    'all': 'All time',
    'airing': 'Airing',
    'upcoming': 'Upcoming',
    'tv': 'TV series',
    'movie': 'Movies',
    'ova': 'OVAs',
    'special': 'Specials',
    'bypopularity': 'Most popular',
    'favorite': 'Most favorited',
  };

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Top Anime'),
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              final scaffoldState =
                  context.findRootAncestorStateOfType<ScaffoldState>()!;
              scaffoldState.openDrawer();
            },
          ),
          bottom: TabBar(
            isScrollable: true,
            tabs: tabs.values.map((name) => Tab(text: name)).toList(),
          ),
        ),
        body: TabBarView(
          children: tabs.keys.map((type) => TopAnimeList(type: type)).toList(),
        ),
      ),
    );
  }
}

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
