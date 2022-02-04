import 'package:flutter/material.dart';
import 'package:myanilab/Core/Models/anime.dart';
import 'package:myanilab/UI/Widgets/network_image.dart';

class AnimeGridItem extends StatelessWidget {
  const AnimeGridItem({
    Key? key,
    required this.anime,
  }) : super(key: key);

  final Anime anime;

  @override
  Widget build(BuildContext context) {
    final heroTag = UniqueKey();
    return Column(
      children: [
        InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(5),
          child: AspectRatio(
            aspectRatio: 225 / 318,
            child: Hero(
              transitionOnUserGestures: true,
              tag: heroTag,
              child: Card(
                elevation: 4,
                margin: EdgeInsets.zero,
                clipBehavior: Clip.hardEdge,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    MalNetworkImage(
                      link: anime.mainPicture.large,
                    ),
                    Positioned(
                      top: 3,
                      left: 3,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Text(
                          'TV',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const Positioned(
                      right: 8,
                      bottom: 5,
                      child: Text(
                        'Finished',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.white,
                          shadows: [
                            BoxShadow(
                              blurRadius: 5,
                              color: Colors.black,
                              offset: Offset(1, 1),
                            ),
                            BoxShadow(
                              blurRadius: 5,
                              color: Colors.black,
                              offset: Offset(-1, -1),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          anime.title,
          maxLines: 1,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
