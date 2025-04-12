class SongEntity {
  final String id;
  final String title;
  final String artist;
  final String url;
  final String coverUrl;
  final int duration;
  final DateTime createdAt;

  SongEntity({
    required this.id,
    required this.title,
    required this.artist,
    required this.url,
    required this.coverUrl,
    required this.duration,
    required this.createdAt,
  });
}
