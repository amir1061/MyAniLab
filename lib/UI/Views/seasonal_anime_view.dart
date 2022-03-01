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
  String? selectedSeason = getCurrentSeason()['season'];
  String? selectedYear = DateTime.now().year.toString();
  final List<String> years = [];

  static const _tabs = {
    'previous': 'Previous',
    'current': 'Current',
    'next': 'Next',
    'custom': 'Custom',
  };

  static const seasons = ['winter', 'spring', 'summer', 'fall'];

  @override
  void initState() {
    final currentYear = DateTime.now().year;
    for (int i = -1; !years.contains('1960'); i++) {
      years.add((currentYear - i).toString());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
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
                (season) => season == 'custom'
                    ? Column(
                        children: [
                          Card(
                            margin: const EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: DropdownButtonFormField<String>(
                                      value: selectedSeason,
                                      onChanged: (v) {
                                        setState(() => selectedSeason = v);
                                        if (selectedSeason != null &&
                                            selectedYear != null) {
                                          final seasonAnimeProvider = Provider
                                              .of<CustomSeasonalAnimeProvider>(
                                            context,
                                            listen: false,
                                          );
                                          seasonAnimeProvider.season =
                                              selectedSeason!;
                                          seasonAnimeProvider.year =
                                              selectedYear!;
                                          seasonAnimeProvider.init();
                                          seasonAnimeProvider.getAnimes();
                                        }
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        isDense: true,
                                      ),
                                      hint: const Text('Season'),
                                      items: seasons
                                          .map(
                                            (season) =>
                                                DropdownMenuItem<String>(
                                              value: season,
                                              child: Text(season),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: DropdownButtonFormField<String>(
                                      value: selectedYear,
                                      onChanged: (v) {
                                        setState(() => selectedYear = v);
                                        if (selectedSeason != null &&
                                            selectedYear != null) {
                                          final seasonAnimeProvider = Provider
                                              .of<CustomSeasonalAnimeProvider>(
                                            context,
                                            listen: false,
                                          );
                                          seasonAnimeProvider.season =
                                              selectedSeason!;
                                          seasonAnimeProvider.year =
                                              selectedYear!;
                                          seasonAnimeProvider.init();
                                          seasonAnimeProvider.getAnimes();
                                        }
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        isDense: true,
                                      ),
                                      hint: const Text('Year'),
                                      items: years
                                          .map(
                                            (year) => DropdownMenuItem<String>(
                                              value: year,
                                              child: Text(year),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child:
                                selectedSeason == null || selectedYear == null
                                    ? const Center(
                                        child: Text(
                                          'Select a season and year to see anime that aired at a specific season!',
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                    : AnimeList<CustomSeasonalAnimeProvider>(
                                        isGrid: isGrid,
                                      ),
                          ),
                        ],
                      )
                    : ChangeNotifierProvider(
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