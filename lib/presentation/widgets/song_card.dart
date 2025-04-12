import 'package:flutter/material.dart';
import 'package:meme_cloud/domain/entities/song/song.dart';

class SongCard extends StatelessWidget {
  final SongEntity song;

  const SongCard({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.blueGrey,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 10),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                song.coverUrl.toString(),
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            song.title.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            song.artist.toString(),
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

final song = SongEntity(
  id: '1',
  title: 'Sóng gió',
  artist: 'Jack',
  coverUrl: 'assets/images/sasuke_avt.jpeg',
  url: 'https://example.com/song.mp3',
  duration: 180,
  createdAt: DateTime.now(),
  album: 'K-ICM',
  trackNumber: 3,
);

void main() => runApp(
  MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('Song  sCard')),
      body: Center(child: SongCard(song: song)),
    ),
  ),
);
