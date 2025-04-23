import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:meme_cloud/common/audio_manager.dart';
import 'package:meme_cloud/core/audio/notifiers/progress_notifier.dart';
import 'package:meme_cloud/core/service_locator.dart';
import 'package:meme_cloud/presentation/widgets/play_music/audio_controller_btn.dart';

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({super.key});

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  final AudioManager audioManager = serviceLocator<AudioManager>();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: audioManager.currentSongNotifier,
      builder: (context, currentSong, child) {
        if (currentSong.title == '') {
          return const SizedBox.shrink();
        }
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Icon(Icons.music_note, color: Colors.white),
                  Expanded(
                    child: Text(
                      currentSong.title,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  PlayButton(),
                ],
              ),
              _slider(),
            ],
          ),
        );
      },
    );
  }

  Widget _slider() {
    final AudioManager audioManager = serviceLocator<AudioManager>();
    return ValueListenableBuilder<ProgressBarState>(
      valueListenable: audioManager.progressNotifier,
      builder: (_, value, __) {
        return ProgressBar(
          progress: value.current,
          buffered: value.buffered,
          total: value.total,
          onSeek: audioManager.seek,
        );
      },
    );
  }
}
