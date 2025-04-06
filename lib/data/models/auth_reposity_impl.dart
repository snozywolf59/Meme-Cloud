import 'package:dartz/dartz.dart';
import 'package:meme_cloud/data/models/create_user_request.dart';
import 'package:meme_cloud/domain/reposities/auth/auth_reposity.dart';

class AuthReposityImpl extends AuthRepository {
  @override
  Future<void> signIn({required String email, required String password}) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<Either> signUp(CreateUserRequest createUserRequest) {
    // TODO: implement signUp
    throw UnimplementedError();
  }
}
