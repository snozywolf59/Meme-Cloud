import 'package:flutter/material.dart';
import 'package:meme_cloud/presentation/view/play_music_view.dart';

class NewReleasesSection extends StatelessWidget {
  const NewReleasesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> newSongs = [
      {
        'title': 'Bài hát mới 1',
        'artist': 'Nghệ sĩ A',
        'image': 'https://picsum.photos/200/200?random=10',
      },
      {
        'title': 'Bài hát mới 2',
        'artist': 'Nghệ sĩ B',
        'image': 'https://picsum.photos/200/200?random=11',
      },
      {
        'title': 'Bài hát mới 3',
        'artist': 'Nghệ sĩ C',
        'image': 'https://picsum.photos/200/200?random=12',
      },
      {
        'title': 'Bài hát mới 4',
        'artist': 'Nghệ sĩ D',
        'image': 'https://picsum.photos/200/200?random=13',
      },
      {
        'title': 'Bài hát mới 5',
        'artist': 'Nghệ sĩ E',
        'image': 'https://picsum.photos/200/200?random=14',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Bài hát mới',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextButton(onPressed: () {}, child: const Text('Xem tất cả')),
            ],
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: newSongs.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        //Todo: Pass data to MusicPlayerScreen
                        // and implement the music player functionality
                        // with the selected song.
                        // For now, we will just navigate to the screen.
                        builder: (context) => const MusicPlayerScreen(),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            newSongs[index]['image']!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: 140,
                        child: Text(
                          newSongs[index]['title']!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        width: 140,
                        child: Text(
                          newSongs[index]['artist']!,
                          style: const TextStyle(fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
