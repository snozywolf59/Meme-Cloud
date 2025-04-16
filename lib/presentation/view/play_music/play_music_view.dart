import 'package:flutter/material.dart';
import 'package:meme_cloud/core/audio/notifiers/play_button_notifier.dart';
import 'package:meme_cloud/data/models/song/song_dto.dart';
import 'package:meme_cloud/core/audio/audio_manager.dart';
import 'package:meme_cloud/presentation/widgets/play_music/audio_controller_btn.dart';
import 'package:meme_cloud/presentation/widgets/play_music/music_player_slider.dart';
import 'package:meme_cloud/core/service_locator.dart';

class MusicPlayerScreen extends StatefulWidget {
  final SongDto song;

  const MusicPlayerScreen({super.key, required this.song});

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreen();
}

class _MusicPlayerScreen extends State<MusicPlayerScreen>
    with SingleTickerProviderStateMixin {
  final AudioManager _audioManager = serviceLocator<AudioManager>();
  late AnimationController _rotationController;
  late VoidCallback _isPlayingListener;

  @override
  void initState() {
    _initAudioPlayer();
    _initRotationController();

    super.initState();
  }

  Future<void> _initRotationController() async {
    try {
      _rotationController = AnimationController(
        duration: const Duration(seconds: 10),
        vsync: this,
      )..repeat();
      _isPlayingListener = () {
        if (_audioManager.playButtonNotifier.value == ButtonState.playing) {
          _rotationController.repeat();
        } else {
          _rotationController.stop();
        }
      };
      _audioManager.playButtonNotifier.addListener(_isPlayingListener);
    } catch (e) {
      debugPrint('Error initializing rotation controller: $e');
    }
  }

  Future<void> _initAudioPlayer() async {
    try {
      if (_audioManager.isEmptyPlaylist() ||
          widget.song.id != _audioManager.getCurrentSong().id) {
        await _audioManager.removeAllPlaylistAndPlaySong(widget.song);
      }
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
    _audioManager.playButtonNotifier.removeListener(_isPlayingListener);
    super.dispose();
  }
}
