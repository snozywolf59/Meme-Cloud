import 'package:flutter/material.dart';
import 'package:memecloud/core/getit.dart';
import 'package:memecloud/apis/apikit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memecloud/models/song_model.dart';
import 'package:memecloud/components/default_appbar.dart';
import 'package:memecloud/components/grad_background.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:memecloud/components/default_future_builder.dart';
import 'package:memecloud/blocs/liked_songs/liked_songs_cubit.dart';
import 'package:memecloud/blocs/liked_songs/liked_songs_state.dart';
import 'package:memecloud/blocs/song_player/song_player_cubit.dart';
import 'package:memecloud/blocs/song_player/song_player_state.dart';

Map getLikedSongsPage(BuildContext context) {
  return {
    'appBar': defaultAppBar(context, title: 'Liked Songs'),
    'bgColor': MyColorSet.redAccent,
    'body': LikedSongPage(),
  };
}

class LikedSongPage extends StatefulWidget {
  const LikedSongPage({super.key});

  @override
  State<LikedSongPage> createState() => _LikedSongPageState();
}

class _LikedSongPageState extends State<LikedSongPage> {
  @override
  Widget build(BuildContext context) {
    return defaultFutureBuilder(
      future: getIt<ApiKit>().getLikedSongsList(),
      onData: (context, songs) {
        return _SongListView(likedSongs: List<SongModel>.from(songs));
      },
    );
  }
}

class _SongListView extends StatefulWidget {
  const _SongListView({required this.likedSongs});

  final List<SongModel> likedSongs;

  @override
  State<_SongListView> createState() => _SongListViewState();
}

class _SongListViewState extends State<_SongListView> {
  Set<SongModel> unlikedSongs = {};
  late List<SongModel> currentLikedSongs;

  @override
  void initState() {
    super.initState();
    currentLikedSongs = widget.likedSongs;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: getIt<LikedSongsCubit>(),
      builder: (context, state) {
        if (state is UserLikeSong) {
          currentLikedSongs.add(state.song);
        } else if (state is UserUnlikeSong) {
          currentLikedSongs.removeWhere((song) => song.id == state.song.id);
        }

        if (currentLikedSongs.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.favorite_border, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'No liked songs yet',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          );
        }

        final playerCubit = getIt<SongPlayerCubit>();

        return BlocBuilder(
          bloc: playerCubit,
          builder: (context, state) {
            SongModel? currentPlayingSong;
            if (state is SongPlayerLoaded) {
              currentPlayingSong = state.currentSong;
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: currentLikedSongs.length,
              itemBuilder: (context, index) {
                final SongModel song = currentLikedSongs[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        imageUrl: song.thumbnailUrl,
                        width: 56,
                        height: 56,
                        fit: BoxFit.cover,
                        errorWidget:
                            (context, url, err) =>
                                const Icon(Icons.music_note, size: 32),
                      ),
                    ),
                    title: Text(
                      song.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    subtitle: Text(
                      song.artistsNames,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedOpacity(
                          opacity: unlikedSongs.contains(song) ? 0.0 : 1.0,
                          duration: Duration(milliseconds: 600),
                          onEnd: () {
                            setState(() {
                              unlikedSongs.remove(song);
                              currentLikedSongs.remove(song);
                            });
                          },
                          child: IconButton(
                            icon: const Icon(Icons.favorite, color: Colors.red),
                            onPressed: () {
                              if (!unlikedSongs.contains(song)) {
                                song.setIsLiked(false);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Đã unlike thành công 1 bài hát!',
                                    ),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                                setState(() {
                                  unlikedSongs.add(song);
                                });
                              }
                            },
                          ),
                        ),
                        IconButton(
                          icon:
                              (song.id == currentPlayingSong?.id &&
                                      playerCubit.isPlaying)
                                  ? (Icon(Icons.pause_rounded))
                                  : (Icon(Icons.play_arrow_rounded)),
                          onPressed: () async {
                            if (song.id == currentPlayingSong?.id) {
                              playerCubit.playOrPause();
                            } else {
                              await playerCubit.loadAndPlay(
                                context,
                                song,
                                songList: currentLikedSongs,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                    onTap: () async {
                      await playerCubit.loadAndPlay(
                        context,
                        song,
                        songList: currentLikedSongs,
                      );
                    },
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
