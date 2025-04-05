class Song {
  final String title;
  final String artist;
  final String imageUrl;

  const Song({
    required this.title,
    required this.artist,
    required this.imageUrl,
  });
  @override
  String toString() {
    return 'Song{title: $title, artist: $artist, imageUrl: $imageUrl}';
  }
}
