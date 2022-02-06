import 'package:flutter/material.dart';
import 'package:myanilab/Core/Models/anime.dart';
import 'package:myanilab/UI/Widgets/network_image.dart';

class AnimeListItem extends StatelessWidget {
  const AnimeListItem({
    Key? key,
    required this.anime,
  }) : super(key: key);

  final Anime anime;

  @override
  Widget build(BuildContext context) {
    final heroTag = UniqueKey();
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(5),
        child: Card(
          elevation: 4,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Container(
            height: 120,
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Hero(
                  tag: heroTag,
                  child: AspectRatio(
                    aspectRatio: 225 / 318,
                    child: Card(
                      elevation: 4,
                      margin: EdgeInsets.zero,
                      clipBehavior: Clip.hardEdge,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: MalNetworkImage(
                        link: anime.mainPicture.large,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        anime.title,
                        maxLines: 1,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // if (anime.type != null)
                          const Text(
                            'TV',
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            [
                              'Finished',
                              'Winter',
                              '2022',
                            ].join(' | '),
                            textDirection: TextDirection.rtl,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Drama, Action, Isekai, Si-Fi',
                          maxLines: 1,
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
