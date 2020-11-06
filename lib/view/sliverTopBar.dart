import 'package:flutter/material.dart';
import 'package:livemusic/notifier/artist_notifier.dart';
import 'package:livemusic/view/heroTop.dart';

import '../colors.dart';

class SliverTopBar extends StatelessWidget {
  const SliverTopBar({
    @required this.index,
    @required this.artistNotifier,
    this.isLiked,
    this.isLikedCheck,
  });

  final int index;
  final bool isLiked;
  final ArtistNotifier artistNotifier;
  final Function isLikedCheck;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: backgroundColor,
      leading: InkWell(
        child: Icon(Icons.arrow_back),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      expandedHeight: 250,
      flexibleSpace: FlexibleSpaceBar(
        background: HeroTop(
            index: index,
            artistNotifier: artistNotifier,
            isLiked: isLiked,
            isLikedCheck: isLikedCheck),
      ),
      actions: [
        Icon(Icons.share),
        Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
      ],
    );
  }
}
