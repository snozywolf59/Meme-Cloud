import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class SongService {
  Future<Either> fetchSongList();
}

class SongSupabaseService extends SongService {
  final _supabaseClient = Supabase.instance.client;
  @override
  Future<Either> fetchSongList() async {
    final response = await _supabaseClient.from('songs').select().limit(4);
    try {
      log(response.toString());
      final songs = response as List<dynamic>;
      return Right(songs);
    } catch (e) {
      return Left(e.toString());
    }
  }
}

