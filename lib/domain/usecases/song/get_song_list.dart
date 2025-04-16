import 'package:dartz/dartz.dart';
import 'package:meme_cloud/core/configs/usecase/use_case.dart';
import 'package:meme_cloud/domain/repositories/song/song_repository.dart';
import 'package:meme_cloud/core/service_locator.dart';

class GetSongListUsecase extends UseCase {
  @override
  Future<Either> call(void params) async {
    return serviceLocator<SongRepository>().getSongList();
  }
}
