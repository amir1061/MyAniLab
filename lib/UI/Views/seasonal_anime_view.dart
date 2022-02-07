import 'package:flutter/material.dart';
import 'package:myanilab/Core/Providers/seasonal_anime_provider.dart';
import 'package:myanilab/Core/Utils/helpers.dart';
import 'package:myanilab/UI/Widgets/anime_list.dart';
import 'package:provider/provider.dart';

class SeasonalAnimeView extends StatefulWidget {
  const SeasonalAnimeView({Key? key}) : super(key: key);

  @override
  State<SeasonalAnimeView> createState() => _SeasonalAnimeViewState();
}

class _SeasonalAnimeViewState extends State<SeasonalAnimeView> {
  bool isGrid = true;

  static const _tabs = {
    'previous': 'Previous',
    'current': 'Current',
    'next': 'Next',
  };

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Seasonal Anime'),
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
                isGrid ? Icons.view_list : Icons.view_module,
              ),
            )
          ],
          bottom: TabBar(
            tabs: _tabs.values.map((name) => Tab(text: name)).toList(),
          ),
        ),
        body: TabBarView(
          children: _tabs.keys
              .map(
                (season) => ChangeNotifierProvider(
                  create: (_) => SeasonalAnimeProvider(
                    season: getSeason(season)['season']!,
                    year: getSeason(season)['year']!,
                  ),
                  child: AnimeList<SeasonalAnimeProvider>(isGrid: isGrid),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
