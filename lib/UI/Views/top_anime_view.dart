import 'package:flutter/material.dart';
import 'package:myanilab/Core/Providers/top_anime_provider.dart';
import 'package:myanilab/UI/Widgets/anime_list.dart';
import 'package:provider/provider.dart';

class TopAnimeView extends StatefulWidget {
  const TopAnimeView({Key? key}) : super(key: key);

  @override
  State<TopAnimeView> createState() => _TopAnimeViewState();
}

class _TopAnimeViewState extends State<TopAnimeView> {
  bool isGrid = true;

  static const _tabs = {
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
          actions: [
            IconButton(
              onPressed: () => setState(() => isGrid = !isGrid),
              icon: Icon(
                isGrid ? Icons.view_headline : Icons.apps,
              ),
            )
          ],
          bottom: TabBar(
            isScrollable: true,
            tabs: _tabs.values.map((name) => Tab(text: name)).toList(),
          ),
        ),
        body: TabBarView(
          children: _tabs.keys
              .map(
                (type) => ChangeNotifierProvider(
                  create: (_) => TopAnimeProvider(rankingType: type),
                  child: AnimeList<TopAnimeProvider>(isGrid: isGrid),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
