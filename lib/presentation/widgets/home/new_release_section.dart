import 'package:flutter/material.dart';

class NewReleasesSection extends StatelessWidget {
  const NewReleasesSection({Key? key}) : super(key: key);

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
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D47A1), // Màu xanh lam đậm cho tiêu đề
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Xem tất cả',
                  style: TextStyle(color: Color(0xFF1E88E5)), // Màu xanh lam cho link
                ),
              ),
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
                          color: Color(0xFF1565C0), // Màu xanh lam cho tiêu đề bài hát
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      width: 140,
                      child: Text(
                        newSongs[index]['artist']!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF64B5F6), // Màu xanh lam nhạt cho nghệ sĩ
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}