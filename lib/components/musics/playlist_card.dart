import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:memecloud/models/playlist_model.dart';
import 'package:memecloud/components/musics/default_music_card.dart';

class PlaylistCard extends StatelessWidget {
  // must be between 1 and 1.
  final int variation;
  final PlaylistModel playlist;

  const PlaylistCard({
    super.key,
    required this.variation,
    required this.playlist,
  });

  @override
  Widget build(BuildContext context) {
    return _variation1(context);
  }

  Widget _variation1(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/playlist_page', extra: playlist.id),
      child: DefaultMusicCard(
        thumbnailUrl: playlist.thumbnailUrl,
        title: playlist.title,
        subTitle: 'Danh sách phát • ${playlist.artistsNames}',
      ),
    );
  }
}
