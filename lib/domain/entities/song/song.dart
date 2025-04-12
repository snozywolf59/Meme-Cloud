class SongEntity {
   String? id;
  String? title;
  String? artist;
  String? album;
  int? trackNumber;
  int? duration; // in seconds
  DateTime? createdAt;
  String? url;
  String? coverUrl;

  SongEntity({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    required this.trackNumber,
    required this.duration,
    required this.createdAt,
    required this.url,
    required this.coverUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'album': album,
      'trackNumber': trackNumber,
      'duration': duration,
      'createdAt': createdAt,
      'url': url,
      'coverUrl': coverUrl,
    };
  }
  factory SongEntity.fromJson(Map<String, dynamic> json) {
    return SongEntity(
      id: json['id'] as String,
      title: json['title'] as String,
      artist: json['artist'] as String,
      album: json['album'] as String,
      trackNumber: json['trackNumber'] as int,
      duration: json['duration'] as int,
      createdAt: json['createdAt'] as DateTime,
      url: json['url'] as String,
      coverUrl: json['coverUrl'] as String,
    );
  }
  @override
  String toString() {
    return 'SongEntity{id: $id, title: $title, artist: $artist, album: $album, trackNumber: $trackNumber, duration: $duration, createdAt: $createdAt, url: $url, coverImageUrl: $coverUrl}';
  }
}
