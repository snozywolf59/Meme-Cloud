import 'dart:async';
import 'package:audio_service/audio_service.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:meme_cloud/core/audio/audio_service.dart';
import 'package:meme_cloud/core/audio/audio_manager.dart';
import 'package:meme_cloud/core/audio/notifiers/play_button_notifier.dart';
import 'package:meme_cloud/core/audio/notifiers/progress_notifier.dart';
import 'package:meme_cloud/core/service_locator.dart';
import 'package:flutter/material.dart';
// class MySlider extends StatefulWidget {
//   const MySlider({super.key});

//   @override
//   State<MySlider> createState() => _MySliderState();
// }

// class _MySliderState extends State<MySlider> {
//   final AudioPlayer _audioPlayer = serviceLocator<AudioHandler>().;
//   Duration _position = Duration.zero;
//   Duration _duration = Duration.zero;
//   late final StreamSubscription<Duration> _positionSubscription;
//   late final StreamSubscription<Duration?> _durationSubscription;

//   @override
//   void initState() {
//     super.initState();
//     _positionSubscription = _audioPlayer.positionStream.listen((position) {
//       setState(() {
//         _position = position;
//       });
//     });
//     _durationSubscription = _audioPlayer.durationStream.listen((duration) {
//       if (duration == null) return;
//       setState(() {
//         _duration = duration;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _positionSubscription.cancel();
//     _durationSubscription.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Slider(
//           value: _position.inMilliseconds.toDouble(),
//           min: 0,
//           max: _duration.inMilliseconds.toDouble(),
//           onChanged: (value) {
//             _audioPlayer.seek(Duration(milliseconds: value.toInt()));
//           },
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(_formatDuration(_audioPlayer.position)),
//               Text(_formatDuration(_audioPlayer.duration ?? Duration.zero)),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   String _formatDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     String minutes = twoDigits(duration.inMinutes.remainder(60));
//     String seconds = twoDigits(duration.inSeconds.remainder(60));
//     return '$minutes:$seconds';
//   }
// }

class AudioProgressBar extends StatelessWidget {
  const AudioProgressBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
