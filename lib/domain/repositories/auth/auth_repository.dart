import 'package:dartz/dartz.dart';
import 'package:meme_cloud/data/models/auth/create_user_request.dart';
import 'package:meme_cloud/data/models/auth/sign_in_request.dart';

abstract class AuthRepository {
  Future<Either> signIn(SignInRequest signInRequest);

  Future<Either> signUp(CreateUserRequest createUserRequest);

  void signOut();
}
