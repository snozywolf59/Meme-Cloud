import 'package:flutter/material.dart';
import 'package:memecloud/components/miscs/grad_background.dart';
import 'package:memecloud/components/miscs/mini_player.dart';
import 'package:memecloud/components/musics/song_card.dart';
import 'package:memecloud/core/getit.dart';
import 'package:memecloud/apis/apikit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memecloud/models/song_model.dart';
import 'package:memecloud/models/playlist_model.dart';
import 'package:memecloud/components/miscs/search_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:memecloud/blocs/song_player/song_player_cubit.dart';
import 'package:memecloud/components/miscs/default_future_builder.dart';
import 'package:memecloud/utils/common.dart';

void _playNextAvailableSong(
  BuildContext context,
  List<SongModel> songs,
  int startIndex,
) async {
  for (int i = startIndex; i < songs.length; i++) {
    final song = songs[i];
    final isPlayable = await getIt<SongPlayerCubit>().loadAndPlay(
      context,
      song,
      songList: songs,
    );

    if (isPlayable) break;
  }
}

class PlaylistPage extends StatelessWidget {
  final String playlistId;

  const PlaylistPage({super.key, required this.playlistId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: defaultFutureBuilder(
          future: getIt<ApiKit>().getPlaylistInfo(playlistId),
          onNull: (context) {
            return Center(
              child: Text("Playlist with id $playlistId doesn't exist!"),
            );
          },
          onData: (context, data) {
            return GradBackground2(
              imageUrl: data!.thumbnailUrl,
              child: Stack(
                children: [
                  _PlaylistPageInner(playlist: data),
                  getMiniPlayer()
                ]
              ),
            );
          },
        ),
      ),
    );
  }
}

class _PlaylistPageInner extends StatefulWidget {
  final PlaylistModel playlist;

  const _PlaylistPageInner({required this.playlist});

  @override
  State<_PlaylistPageInner> createState() => _PlaylistPageInnerState();
}

class _PlaylistPageInnerState extends State<_PlaylistPageInner> {
  late List<SongModel> _displaySongs = widget.playlist.songs ?? [];
  late final _searchBar = MySearchBar(
    variation: 2,
    onSubmitted: (query) {
      if (query.trim().isEmpty) {
        setState(() => _displaySongs = widget.playlist.songs ?? []);
      }

      String lowercasedQuery = query.toLowerCase();
      setState(() {
        _displaySongs =
            (widget.playlist.songs ?? [])
                .where(
                  (song) => song.title.toLowerCase().contains(lowercasedQuery),
                )
                .toList();
      });
    },
  );

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _appBar(context),
        _generalDetails(),

        widget.playlist.description != null && widget.playlist.description!.isNotEmpty
            ? (_playlistDescription())
            : (SliverToBoxAdapter(child: SizedBox(height: 18))),

        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final song = _displaySongs[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
              child: Row(
                children: [
                  Flexible(
                    child: SongCard(
                      variation: 1,
                      song: song,
                      songList: _displaySongs,
                    ),
                  ),
                  SizedBox(width: 8),
                  IconButton(
                    icon: Icon(
                      Icons.more_vert,
                      color: Colors.grey[400],
                      size: 20,
                    ),
                    onPressed: () {
                      // Hiển thị menu tùy chọn cho bài hát
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.grey[900],
                        builder: (context) => SongOptionsSheet(song: song),
                      );
                    },
                  ),
                ],
              ),
            );
          }, childCount: _displaySongs.length),
        ),
      ],
    );
  }

  SliverToBoxAdapter _playlistDescription() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.teal.shade500,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            widget.playlist.description!,
            style: GoogleFonts.mali(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _generalDetails() {
    Duration playlistDuration = (widget.playlist.songs ?? []).fold(
      Duration.zero,
      (prev, song) => prev + song.duration,
    );
    String playlistDurationStr = formatDuration(playlistDuration);
    int playlistLength = widget.playlist.songs?.length ?? 0;

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: widget.playlist.thumbnailUrl,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      widget.playlist.followed == true
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color:
                          widget.playlist.followed == true
                              ? Colors.white
                              : Colors.white,
                      size: 26,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '100,7K',
                      style: TextStyle(color: Colors.grey[400], fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.playlist.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Playlist • $playlistLength Tracks • $playlistDurationStr',
                    style: TextStyle(color: Colors.grey[400], fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[800],
                        ),
                        child: const Icon(
                          Icons.music_note,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          widget.playlist.artistsNames ?? "Trending Music",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      SizedBox(width: 10)
                    ],
                  ),
                  _playlistControlButtons(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _playlistControlButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () {
            _playNextAvailableSong(context, _displaySongs, 0);
          },
          icon: const Icon(Icons.play_arrow, color: Colors.black),
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.white),
          ),
          constraints: BoxConstraints(minWidth: 35, minHeight: 35),
          padding: const EdgeInsets.all(4),
        ),
        IconButton(
          icon: Icon(Icons.more_vert, color: Colors.grey[400], size: 20),
          onPressed: () {
            // Hiển thị menu tùy chọn cho bài hát
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.grey[900],
              builder:
                  (context) =>
                      SongOptionsSheet(song: widget.playlist.songs![0]),
            );
          },
        ),
      ],
    );
  }

  SliverAppBar _appBar(BuildContext context) {
    return SliverAppBar(
      floating: true,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        background: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: IconButton(
                onPressed: () => Navigator.of(context).maybePop(),
                icon: Icon(
                  Icons.arrow_back,
                  size: 20,
                  color: Colors.grey.shade900,
                ),
                padding: EdgeInsets.all(4),
                constraints: BoxConstraints(minWidth: 32, minHeight: 32),
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.white),
                ),
              ),
            ),
            Expanded(child: SizedBox(height: 40, child: _searchBar)),
            SizedBox(width: 15),
          ],
        ),
      ),
    );
  }

  // Widget _buildGenreTag(String tag) {
  //   return Container(
  //     margin: const EdgeInsets.only(right: 8),
  //     decoration: BoxDecoration(
  //       color: Colors.grey[900],
  //       borderRadius: BorderRadius.circular(16),
  //     ),
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  //       child: Text(
  //         tag,
  //         style: const TextStyle(color: Colors.white, fontSize: 14),
  //       ),
  //     ),
  //   );
  // }
}

class SongOptionsSheet extends StatelessWidget {
  final SongModel song;

  const SongOptionsSheet({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.playlist_add, color: Colors.white),
            title: const Text(
              'Thêm vào playlist',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.download, color: Colors.white),
            title: const Text(
              'Tải xuống',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.share, color: Colors.white),
            title: const Text('Chia sẻ', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person, color: Colors.white),
            title: const Text(
              'Xem nghệ sĩ',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
