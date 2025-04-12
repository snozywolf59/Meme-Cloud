import 'package:get_it/get_it.dart';
import 'package:meme_cloud/data/repositories/auth/auth_repository_impl.dart';
import 'package:meme_cloud/data/sources/auth_firebase_service.dart';
import 'package:meme_cloud/data/sources/auth_supabase_service.dart';
import 'package:meme_cloud/domain/repositories/auth/auth_repository.dart';
import 'package:meme_cloud/domain/usecases/auth/sign_in.dart';
import 'package:meme_cloud/domain/usecases/auth/sign_up.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  serviceLocator.registerSingleton<AuthFirebaseService>(
    AuthFirebaseServiceImpl(),
  );

  serviceLocator.registerSingleton<SupabaseClient>(Supabase.instance.client);

  serviceLocator.registerSingleton<AuthSupabaseService>(AuthSupabaseService());

  serviceLocator.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  serviceLocator.registerSingleton<SignupUseCase>(SignupUseCase());

  serviceLocator.registerSingleton<SignInUseCase>(SignInUseCase());
}
