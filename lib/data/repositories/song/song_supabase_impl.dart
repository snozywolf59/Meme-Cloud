import 'package:dartz/dartz.dart';
import 'package:meme_cloud/data/sources/song/song_service.dart';
import 'package:meme_cloud/domain/repositories/song/song_repository.dart';
import 'package:meme_cloud/core/service_locator.dart';

class SongSupabaseImpl extends SongRepository {
  @override
  Future<Either> getSongList() async{
    return await serviceLocator<SongService>().fetchSongList();
  }
  
}