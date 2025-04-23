import 'package:flutter/material.dart';
import 'package:meme_cloud/data/models/song/song_dto.dart';
import 'package:meme_cloud/domain/repositories/song/song_repository.dart';
import 'package:meme_cloud/presentation/view/play_music/play_music_view.dart';
import 'package:meme_cloud/core/service_locator.dart';
import 'package:dartz/dartz.dart' as dartz;

class LikedSongsView extends StatefulWidget {
  const LikedSongsView({super.key});

  @override
  State<LikedSongsView> createState() => _LikedSongsViewState();
}

class _LikedSongsViewState extends State<LikedSongsView> {
  final _getSongList = serviceLocator<SongRepository>().getLikedSongslist();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Liked Songs',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<dartz.Either>(
        future: _getSongList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return Center(
              child: Text('Error loading songs: ${snapshot.error}'),
            );
          }

          final songsEither = snapshot.data!;
          return songsEither.fold(
            (error) => Center(child: Text('Error: $error')),
            (songs) {
              // Filter only liked songs
              final likedSongs =
                  (songs as List<dynamic>)
                      .where((song) => song.isLiked)
                      .toList();

              if (likedSongs.isEmpty) {
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

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: likedSongs.length,
                itemBuilder: (context, index) {
                  final song = likedSongs[index];
                  return _buildSongListItem(context, song);
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildSongListItem(BuildContext context, SongDto song) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            song.coverUrl,
            width: 56,
            height: 56,
            fit: BoxFit.cover,
            errorBuilder:
                (context, error, stackTrace) =>
                    const Icon(Icons.music_note, size: 32),
          ),
        ),
        title: Text(
          song.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          song.artist,
          style: const TextStyle(color: Colors.grey, fontSize: 14),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.favorite, color: Colors.red),
              onPressed: () {
                // Toggle like functionality will be implemented here
                // This will use the toggleLike usecase
              },
            ),
            IconButton(
              icon: const Icon(Icons.play_arrow),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MusicPlayerScreen(song: song),
                  ),
                );
              },
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MusicPlayerScreen(song: song),
            ),
          );
        },
      ),
    );
  }
}
