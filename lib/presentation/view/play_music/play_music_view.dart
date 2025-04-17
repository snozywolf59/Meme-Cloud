import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:meme_cloud/core/audio/audio_service.dart';
import 'package:meme_cloud/data/models/song/song_dto.dart';
import 'package:meme_cloud/core/audio/audio_manager.dart';
import 'package:meme_cloud/presentation/view/play_music/audio_controller.dart';
import 'package:meme_cloud/presentation/view/play_music/slider.dart';
import 'package:meme_cloud/service_locator.dart';
import 'package:provider/provider.dart';

class MusicPlayerScreen extends StatefulWidget {
  final SongDto song;

  const MusicPlayerScreen({super.key, required this.song});

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreen();
}

class _MusicPlayerScreen extends State<MusicPlayerScreen>
    with SingleTickerProviderStateMixin {
  final AudioManager _audioPlayer = serviceLocator<AudioManager>();
  late AnimationController _rotationController;

  @override
  void initState() {
    _initAudioPlayer();
    _rotationController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();

    super.initState();
  }

  Future<void> _initAudioPlayer() async {
    try {
      await _audioPlayer.removeAllPlaylistAndPlaySong(widget.song);
    } catch (e) {
      debugPrint('Error initializing audio player: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Now Playing')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RotationTransition(
              turns: _rotationController,
              child: ClipOval(
                child: Image.network(
                  widget.song.coverUrl,
                  height: 250,
                  width: 250,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              widget.song.title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.song.artist,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            AudioProgressBar(),
            AudioControlButtons(),

            // IconButton(
            //   icon: Icon(_audioPlayer.playing ? Icons.pause : Icons.play_arrow),
            //   iconSize: 48,
            //   onPressed: () async {
            //     setState(() {
            //       if (_audioPlayer.playing) {
            //         _rotationController.stop();
            //       } else {
            //         _rotationController.repeat();
            //       }
            //     });
            //     if (!_audioPlayer.playing) {
            //       await _audioPlayer.play();
            //     } else {
            //       await _audioPlayer.pause();
            //     }
            //     print(_audioPlayer.duration);
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }
}
