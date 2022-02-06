import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:myanilab/Core/Utils/enums.dart';
import 'package:myanilab/UI/Widgets/anime_grid_item.dart';
import 'package:myanilab/UI/Widgets/anime_list_item.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AnimeList<T> extends StatelessWidget {
  final ViewType viewType;
  AnimeList({Key? key, this.viewType = ViewType.grid}) : super(key: key);

  final _refreshController = RefreshController();

  void _onRefresh(context) async {
    try {
      final dynamic latestUpdatedProvider =
          Provider.of<T>(context, listen: false);
      latestUpdatedProvider.reset();
      await latestUpdatedProvider.getAnimes();
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
    } catch (e) {
      log(e.toString());
      _refreshController.refreshFailed();
    }
  }

  void _onLoading(context) async {
    try {
      final dynamic latestUpdatedProvider =
          Provider.of<T>(context, listen: false);
      await latestUpdatedProvider.getAnimes();
      if (latestUpdatedProvider.canLoadMore) {
        _refreshController.loadComplete();
      } else {
        _refreshController.loadNoData();
      }
    } catch (e) {
      log(e.toString());
      _refreshController.loadFailed();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<T>(
      builder: (context, provider, child) {
        dynamic animesProvider = provider;
        if (animesProvider.error != null) {
          return SmartRefresher(
            controller: _refreshController,
            header: const MaterialClassicHeader(),
            onRefresh: () => _onRefresh(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error),
                  const SizedBox(height: 10),
                  Text(
                    animesProvider.error.message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          );
        }
        if (animesProvider.animes == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (animesProvider.animes!.isEmpty) {
          return const Center(
            child: Text('No animes found!'),
          );
        }
        return SmartRefresher(
          enablePullUp: true,
          header: const MaterialClassicHeader(),
          footer: const ClassicFooter(
            loadStyle: LoadStyle.ShowWhenLoading,
            loadingText: 'Loading',
            noDataText: 'No Data',
            idleText: 'Idle',
            failedText: 'Failed',
            canLoadingText: 'Release to load more',
          ),
          controller: _refreshController,
          onRefresh: () => _onRefresh(context),
          onLoading: () => _onLoading(context),
          physics: const BouncingScrollPhysics(),
          child: viewType == ViewType.grid
              ? GridView.builder(
                  addRepaintBoundaries: false,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    childAspectRatio: .58,
                  ),
                  itemCount: animesProvider.animes!.length,
                  itemBuilder: (BuildContext context, int index) {
                    final animeInfo = animesProvider.animes![index];
                    return AnimeGridItem(anime: animeInfo);
                  },
                )
              : ListView.builder(
                  itemCount: animesProvider.animes!.length,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  itemBuilder: (context, index) {
                    final animeInfo = animesProvider.animes![index];
                    return AnimeListItem(anime: animeInfo);
                  },
                ),
        );
      },
    );
  }
}
