// ignore_for_file: unused_element_parameter

import 'package:memecloud/apis/zingmp3/endpoints.dart';
import 'package:memecloud/models/artist_model.dart';
import 'package:memecloud/models/music_model.dart';
import 'package:memecloud/models/song_model.dart';
import 'package:memecloud/utils/common.dart';

class AnonymousPlaylist {}

const String anomPrefix = "anomPl_";

class PlaylistModel extends MusicModel {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String? artistsNames;
  final String? description;
  final List<SongModel>? songs;
  final List<ArtistModel>? artists;
  final bool? followed;

  PlaylistModel._({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    this.artistsNames,
    this.description,
    this.songs,
    this.artists,
    this.followed,
  });

  static PlaylistModel fromJson<T>(Map<String, dynamic> json) {
    if (T == AnonymousPlaylist) {
      return PlaylistModel._(
        id: "$anomPrefix${json['customId'] ?? ''}",
        title: json['title'],
        artistsNames: json['artistsNames'],
        description: json['description'],
        thumbnailUrl: json['thumbnailUrl'],
        songs: json.containsKey('songs') ? json['songs'] : null,
      );
    }
    else if (T == ZingMp3Api) {
      return PlaylistModel._(
        id: json['encodeId'],
        title: json['title'],
        artistsNames: json['artistsNames'],
        thumbnailUrl:
            json['thumbnailM'] ?? json['thumbnail'] ?? json['thumbnailUrl'],
        description: json['sortDescription'] ?? json['description'] ?? 'mô tả',
        songs:
            json.containsKey('song')
                ? SongModel.fromListJson<T>(json['song']['items'])
                : null,
        artists:
            json.containsKey('artists')
                ? ArtistModel.fromListJson<T>(json['artists'])
                : null,
      );
    }
    else {
      throw UnsupportedError('Unsupported parse json for type $T');
    }
  }

  bool get isAnom => id.startsWith(anomPrefix);

  static List<PlaylistModel> fromListJson<T>(List list) {
    return list.map((json) => PlaylistModel.fromJson<T>(json)).toList();
  }

  @override
  Map<String, dynamic> toJson({bool only = false}) {
    return ignoreNullValuesOfMap({
      'id': id,
      'title': title,
      'thumbnail_url': thumbnailUrl,
      'artists_names': artistsNames,
      'description': description,
      if (only == false)
        'songs': songs?.map((e) => e.toJson()).toList(),
      if (only == false)
        'artists': artists?.map((e) => e.toJson()).toList(),
    });
  }
}
