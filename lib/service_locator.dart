import 'package:get_it/get_it.dart';
import 'package:meme_cloud/data/repositories/auth/auth_repository_impl.dart';
import 'package:meme_cloud/data/sources/auth_firebase_service.dart';
import 'package:meme_cloud/domain/repositories/auth/auth_repository.dart';
import 'package:meme_cloud/domain/usecases/auth/sign_in.dart';
import 'package:meme_cloud/domain/usecases/auth/sign_up.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  // Register your services and repositories here
  // Example:
  // serviceLocator.registerLazySingleton<SomeService>(() => SomeServiceImpl());
  // serviceLocator.registerLazySingleton<SomeRepository>(() => SomeRepositoryImpl());
  serviceLocator.registerSingleton<AuthFirebaseService>(
    AuthFirebaseServiceImpl(),
  );

  serviceLocator.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  serviceLocator.registerSingleton<SignupUseCase>(SignupUseCase());

  serviceLocator.registerSingleton<SignInUseCase>(SignInUseCase());
}
