import 'dart:developer';
import 'package:memecloud/core/getit.dart';
import 'package:memecloud/apis/connectivity.dart';
import 'package:memecloud/apis/supabase/main.dart';
import 'package:memecloud/models/artist_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseArtistsApi {
  final SupabaseClient _client;
  SupabaseArtistsApi(this._client);
  final _connectivity = getIt<ConnectivityStatus>();

  Future<void> saveArtistsInfo(List<ArtistModel> artists) async {
    try {
      _connectivity.ensure();
      await _client
          .from('artists')
          .upsert(
            artists
                .map((artist) => artist.toJson<SupabaseApi>()['artist'])
                .toList(),
          );
    } catch (e, stackTrace) {
      _connectivity.reportCrash(e, StackTrace.current);
      log(
        "Failed to save artist info: $e",
        stackTrace: stackTrace,
        level: 1000,
      );
      rethrow;
    }
  }

  Future<void> saveSongArtists(String songId, List<ArtistModel> artists) async {
    try {
      _connectivity.ensure();
      await saveArtistsInfo(artists);
      await _client
          .from('song_artists')
          .upsert(
            artists
                .map((artist) => {'song_id': songId, 'artist_id': artist.id})
                .toList(),
          );
    } catch (e, stackTrace) {
      _connectivity.reportCrash(e, StackTrace.current);
      log(
        "Failed to save artist info: $e",
        stackTrace: stackTrace,
        level: 1000,
      );
      rethrow;
    }
  }

  Future<List<ArtistModel>> getTopArtists(int count) async {
    try {
      _connectivity.ensure();
      final response = await _client
          .from('artists')
          .select()
          .order('view_in_week', ascending: false)
          .limit(count);
      
      return response
          .map((artist) => ArtistModel.fromJson<SupabaseApi>({'artist': artist}))
          .toList();
    } catch (e, stackTrace) {
      _connectivity.reportCrash(e, StackTrace.current);
      log(
        "Failed to get top artists: $e",
        stackTrace: stackTrace,
        level: 1000,
      );
      rethrow;
    }
  }
}
