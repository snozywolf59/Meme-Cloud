import 'package:dartz/dartz.dart';
import 'package:meme_cloud/data/models/create_user_request.dart';

abstract class AuthRepository {
  Future<void> signIn({required String email, required String password});

  Future<Either> signUp(CreateUserRequest createUserRequest);

  Future<void> signOut();
}
