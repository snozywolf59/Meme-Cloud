class SongDto {
  String? id;
  String? title;
  String? artist;
  String? album;
  int? trackNumber;
  int? duration; // in seconds
  String? createdAt;
  String? url;
  String? coverImageUrl;

  SongDto({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    required this.trackNumber,
    required this.duration,
    required this.createdAt,
    required this.url,
    required this.coverImageUrl,
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
      'coverImageUrl': coverImageUrl,
    };
  }
  factory SongDto.fromJson(Map<String, dynamic> json) {
    return SongDto(
      id: json['id'] as String,
      title: json['title'] as String,
      artist: json['artist'] as String,
      album: json['album'] as String,
      trackNumber: json['trackNumber'] as int,
      duration: json['duration'] as int,
      createdAt: json['createdAt'] as String,
      url: json['url'] as String,
      coverImageUrl: json['coverImageUrl'] as String,
    );
  }
  @override
  String toString() {
    return 'SongDto{id: $id, title: $title, artist: $artist, album: $album, trackNumber: $trackNumber, duration: $duration, createdAt: $createdAt, url: $url, coverImageUrl: $coverImageUrl}';
  }
}
