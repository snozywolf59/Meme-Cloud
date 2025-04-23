import 'package:audio_service/audio_service.dart';

class SongDto {
  final String id;
  final String title;
  final String artist;
  final String coverUrl;
  final String url;
  final bool isLiked;

  SongDto({
    required this.id,
    required this.title,
    required this.artist,
    required this.coverUrl,
    required this.url,
    this.isLiked = false,
  });

  factory SongDto.fromJson(Map<String, dynamic> json) {
    return SongDto(
      id: json['id'] as String,
      title: json['title'] as String,
      artist: json['artist'] as String,
      coverUrl: json['cover_url'] as String,
      url: json['url'] as String,
      isLiked: json['is_liked'] as bool? ?? false,
    );
  }

  factory SongDto.fromMediaItem(MediaItem mediaItem) {
    try {
      return SongDto(
        id: mediaItem.id,
        title: mediaItem.title,
        artist: mediaItem.artist ?? '',
        coverUrl: mediaItem.artUri?.toString() ?? '',
        url: mediaItem.extras?['url'] as String? ?? '',
      );
    } catch (e) {
      print("error while make songdto from mediaitem ${e.toString()}");
      return SongDto.emptySong;
    }
  }

  MediaItem toMediaItem() {
    return MediaItem(
      id: id,
      title: title,
      artist: artist,
      artUri: Uri.parse(coverUrl),
      extras: {'url': url},
    );
  }

  static SongDto emptySong = SongDto(
    id: '',
    title: '',
    artist: '',
    coverUrl: '',
    url: '',
  );
}
