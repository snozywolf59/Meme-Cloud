import 'package:flutter/material.dart';
import 'package:meme_cloud/models/Song.dart';
import 'package:meme_cloud/widgets/song_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Column(
        children: [
          const Text('Có thể bạn thích'),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(16),
            height: 320,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SongCard(song: songs[index]),
                );
              },
              itemCount: songs.length,
            ),
          ),
        ],
      ),
    );
  }
}

final List<Song> songs = [
  Song(
    title: 'Song 1',
    artist: 'Artist 1',
    imageUrl: 'assets/images/sasuke_avt.jpeg',
  ),
  Song(
    title: 'Song 2',
    artist: 'Artist 2',
    imageUrl: 'assets/images/sasuke_avt.jpeg',
  ),
  Song(
    title: 'Song 2',
    artist: 'Artist 2',
    imageUrl: 'assets/images/sasuke_avt.jpeg',
  ),
  Song(
    title: 'Song 2',
    artist: 'Artist 2',
    imageUrl: 'assets/images/sasuke_avt.jpeg',
  ),
];
