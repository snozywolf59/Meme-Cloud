import 'package:dartz/dartz.dart';
import 'package:meme_cloud/data/models/create_user_request.dart';
import 'package:meme_cloud/data/models/sign_in_request.dart';
import 'package:meme_cloud/data/sources/auth_firebase_service.dart';
import 'package:meme_cloud/domain/repositories/auth/auth_repository.dart';
import 'package:meme_cloud/service_locator.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Either> signIn(SignInRequest signInRequest) async {
    return serviceLocator<AuthFirebaseService>().signIn(
      signInRequest,
    );
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<Either> signUp(CreateUserRequest createUserRequest) async {
    return await serviceLocator<AuthFirebaseService>().signUp(
      createUserRequest,
    );
  }
}
