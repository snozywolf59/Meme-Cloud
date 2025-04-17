import 'package:get_it/get_it.dart';
import 'package:meme_cloud/data/repositories/auth/auth_repository_impl.dart';
import 'package:meme_cloud/data/repositories/song/song_supabase_impl.dart';
import 'package:meme_cloud/data/sources/auth/auth_firebase_service.dart';
import 'package:meme_cloud/data/sources/auth/auth_supabase_service.dart';
import 'package:meme_cloud/data/sources/song/song_service.dart';
import 'package:meme_cloud/domain/repositories/auth/auth_repository.dart';
import 'package:meme_cloud/domain/repositories/song/song_repository.dart';
import 'package:meme_cloud/domain/usecases/auth/sign_in.dart';
import 'package:meme_cloud/domain/usecases/auth/sign_up.dart';
import 'package:meme_cloud/domain/usecases/song/get_song_list.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  serviceLocator.registerSingleton<AuthFirebaseService>(
    AuthFirebaseServiceImpl(),
  );

  serviceLocator.registerSingleton<SupabaseClient>(Supabase.instance.client);

  serviceLocator.registerSingleton<AuthSupabaseService>(AuthSupabaseService());

  serviceLocator.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  serviceLocator.registerSingleton<SignUpUseCase>(SignUpUseCase());

  serviceLocator.registerSingleton<SignInUseCase>(SignInUseCase());

  serviceLocator.registerSingleton<SongRepository>(SongSupabaseImpl());

  serviceLocator.registerSingleton<SongService>(SongSupabaseService());

  serviceLocator.registerSingleton<GetSongListUsecase>(GetSongListUsecase());
}
