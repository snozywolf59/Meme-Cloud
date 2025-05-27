import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:memecloud/core/getit.dart';
import 'package:memecloud/utils/common.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memecloud/models/song_model.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:memecloud/components/song/like_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:memecloud/blocs/song_player/song_player_cubit.dart';
import 'package:memecloud/blocs/song_player/song_player_state.dart';
import 'package:memecloud/components/song/play_or_pause_button.dart';

class MiniPlayer extends StatelessWidget {
  final bool floating;

  const MiniPlayer({super.key, this.floating = false});

  @override
  Widget build(BuildContext context) {
    final playerCubit = getIt<SongPlayerCubit>();
    return BlocBuilder<SongPlayerCubit, SongPlayerState>(
      bloc: playerCubit,
      builder: (context, state) {
        if (state is SongPlayerLoaded || state is SongPlayerLoading) {
          final w = _MiniPlayerInner(playerCubit, (state as dynamic).currentSong);
          return floating
              ? Positioned(left: 0, right: 0, bottom: 12, child: w)
              : w;
        } else {
          return SizedBox(height: 1);
        }
      },
    );
  }
}

class _MiniPlayerInner extends StatefulWidget {
  final SongPlayerCubit playerCubit;
  final SongModel song;

  const _MiniPlayerInner(this.playerCubit, this.song);

  @override
  State<_MiniPlayerInner> createState() => _MiniPlayerInnerState();
}

class _MiniPlayerInnerState extends State<_MiniPlayerInner> {
  List<Color>? paletteColors;

  Future<void> loadPaletteColors() {
    return getPaletteColors(widget.song.thumbnailUrl).then((data) {
      setState(() => paletteColors = data);
    });
  }

  @override
  void didUpdateWidget(covariant _MiniPlayerInner oldWidget) {
    super.didUpdateWidget(oldWidget);
    unawaited(loadPaletteColors());
  }

  @override
  void initState() {
    super.initState();
    unawaited(loadPaletteColors());
  }

  @override
  Widget build(BuildContext context) {
    if (paletteColors == null) return SizedBox();

    late final Color domBg, subDomBg;
    if (AdaptiveTheme.of(context).mode.isDark) {
      domBg = adjustColor(paletteColors!.first, l: 0.3, s: 0.3);
      subDomBg = adjustColor(paletteColors!.last, l: 0.4, s: 0.4);
    } else {
      domBg = adjustColor(paletteColors!.first, l: 0.5, s: 0.3);
      subDomBg = adjustColor(paletteColors!.last, l: 0.6, s: 0.4);
    }
    Color onBgColor = getTextColor(domBg);

    return GestureDetector(
      onTap: () => context.push('/song_page'),
      child: miniPlayerSongDetails(domBg, subDomBg, onBgColor),
    );
  }

  Widget miniPlayerSongDetails(Color domBg, Color subDomBg, Color onBgColor) {
    return Container(
      height: 60,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [domBg, subDomBg],
          stops: [0.0, 0.8],
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          miniThumbnail(),
          SizedBox(width: 10),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.song.title,
                        style: TextStyle(
                          color: onBgColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        widget.song.artistsNames,
                        style: TextStyle(
                          color: onBgColor.withAlpha(180),
                          fontSize: 12,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Row(
                  children: [
                    PlayOrPauseButton(song: widget.song, color: onBgColor),
                    SongLikeButton(song: widget.song),
                    _seekNextButton(onBgColor),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 5),
        ],
      ),
    );
  }

  IconButton _seekNextButton(Color onBgColor) {
    return IconButton(
      color: onBgColor,
      icon: Icon(Icons.skip_next),
      onPressed: () {
        widget.playerCubit.seekToNext();
      },
    );
  }

  ClipRRect miniThumbnail() {
    return ClipRRect(
      borderRadius: BorderRadius.horizontal(left: Radius.circular(20)),
      child: CachedNetworkImage(
        imageUrl: widget.song.thumbnailUrl,
        width: 60,
        height: 60,
        fit: BoxFit.cover,
      ),
    );
  }
}
