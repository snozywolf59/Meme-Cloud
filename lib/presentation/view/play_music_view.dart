import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math' as math;

class MusicPlayerScreen extends StatefulWidget {
  const MusicPlayerScreen({super.key});

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen>
    with SingleTickerProviderStateMixin {
  bool _isPlaying = false;
  bool _isFavorite = false;
  bool _isRepeat = false;
  bool _isShuffle = false;
  late AnimationController _animationController;
  late Timer _timer;

  double duration = 225;
  double current = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat();

    _timer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      setState(() {
        if (current < duration) {
          current += 0.2;
        } else {
          current = 0;
        }
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Đang phát',
          style: TextStyle(
            color: Color(0xFF6E44FF),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          // Album Art
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (_, child) {
                    return Transform.rotate(
                      angle: _animationController.value * 2 * math.pi,
                      child: child,
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    constraints: const BoxConstraints(
                      maxWidth: 300,
                      maxHeight: 300,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF6E44FF).withAlpha(20),
                          spreadRadius: 3,
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      border: Border.all(
                        color: const Color(0xFF6E44FF),
                        width: 5,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.network(
                        'https://picsum.photos/400/400?random=25',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Song Info
          Expanded(
            flex: 1,
            child: Column(
              children: const [
                Text(
                  'Tên Bài Hát',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6E44FF),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Tên Nghệ Sĩ',
                  style: TextStyle(fontSize: 16, color: Color(0xFF6E44FF)),
                ),
              ],
            ),
          ),

          // Progress Bar
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 6,
                      ),
                      overlayShape: const RoundSliderOverlayShape(
                        overlayRadius: 14,
                      ),
                      thumbColor: const Color(0xFF6E44FF),
                      activeTrackColor: const Color(0xFF6E44FF),
                      inactiveTrackColor: const Color(0xFFBBDEFB),
                    ),
                    child: Slider(
                      value: current,
                      min: 0,
                      max: duration,
                      onChanged: (double value) {
                        setState(() {
                          current = value;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${(current / 60).floor()}:${(current.toInt() % 60).toString().padLeft(2, '0')}',
                          style: const TextStyle(
                            color: Color(0xFF6E44FF),
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '${(duration / 60).floor()}:${(duration.toInt() % 60).toString().padLeft(2, '0')}',
                          style: const TextStyle(
                            color: Color(0xFF6E44FF),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Controls
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Shuffle Button
                  IconButton(
                    icon: Icon(
                      Icons.shuffle,
                      color:
                          _isShuffle
                              ? const Color(0xFF6E44FF)
                              : const Color(0xFFBBDEFB),
                      size: 24,
                    ),
                    onPressed: () {
                      setState(() {
                        _isShuffle = !_isShuffle;
                      });
                    },
                  ),

                  // Previous Button
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF6E44FF).withAlpha(30),
                          spreadRadius: 1,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.skip_previous_rounded,
                        color: Color(0xFF6E44FF),
                        size: 35,
                      ),
                      onPressed: () {},
                    ),
                  ),

                  // Play/Pause Button
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6E44FF), Color(0xFF6E44FF)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF6E44FF).withAlpha(30),
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(
                        _isPlaying
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                        color: Colors.white,
                        size: 40,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPlaying = !_isPlaying;
                          if (_isPlaying) {
                            _animationController.repeat();
                          } else {
                            _animationController.stop();
                          }
                        });
                      },
                    ),
                  ),

                  // Next Button
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF6E44FF).withAlpha(30),
                          spreadRadius: 1,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.skip_next_rounded,
                        color: Color(0xFF6E44FF),
                        size: 35,
                      ),
                      onPressed: () {},
                    ),
                  ),

                  // Repeat Button
                  IconButton(
                    icon: Icon(
                      Icons.repeat,
                      color:
                          _isRepeat
                              ? const Color(0xFF6E44FF)
                              : const Color(0xFFBBDEFB),
                      size: 24,
                    ),
                    onPressed: () {
                      setState(() {
                        _isRepeat = !_isRepeat;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),

          // Additional Controls
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(
                      _isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: _isFavorite ? const Color(0xFF6E44FF) : null,
                      size: 28,
                    ),
                    onPressed: () {
                      setState(() {
                        _isFavorite = !_isFavorite;
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.playlist_add, size: 28),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.share, size: 28),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.equalizer, size: 28),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
