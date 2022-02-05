import 'package:flutter/material.dart';
import 'package:myanilab/UI/Widgets/top_anime_list.dart';

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
