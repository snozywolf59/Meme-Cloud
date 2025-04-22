import 'package:dartz/dartz.dart';
import 'package:meme_cloud/common/supabase.dart';
import 'package:meme_cloud/data/models/song/song_dto.dart';

abstract class SongService {
  Future<Either> fetchSongList();
  Future<Either> toggleLike(String songId);
}

class SongSupabaseService extends SongService {
  @override
  Future<Either> fetchSongList() async {
    try {
      final response = await supabase
          .from('songs')
          .select('''
            id as song_id,
            title,
            cover_url,
            artists!song_artists(id as artist_id, name as artist_name),
            is_liked:liked_songs!inner(
              song_id,
              user_id
            ).song_id.exists()
          ''')
          .limit(4);
      final songsList =
          (response as List<dynamic>).map((song) {
            final songMap = {
              'id': song['id'],
              'title': song['title'],
              'url': song['url'],
              'cover_url': song['cover_url'],
              'artist': song['artists'][0]['name'],
              'is_liked': song['is_liked'] ?? false,
            };
            return SongDto.fromJson(songMap);
          }).toList();
      return Right(songsList);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either> toggleLike(String songId) async {
    try {
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) {
        return Left('User not authenticated');
      }

      final likedResponse =
          await supabase
              .from('liked_songs')
              .select()
              .eq('song_id', songId)
              .eq('user_id', userId)
              .maybeSingle();

      if (likedResponse == null) {
        final response =
            await supabase.from('liked_songs').insert({
              'song_id': songId,
              'user_id': userId,
            }).select();
        return Right(response);
      } else {
        final response =
            await supabase
                .from('liked_songs')
                .delete()
                .eq('song_id', songId)
                .eq('user_id', userId)
                .select();
        return Right(response);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
