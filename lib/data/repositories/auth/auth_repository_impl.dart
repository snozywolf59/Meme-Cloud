import 'package:dartz/dartz.dart';
import 'package:meme_cloud/data/models/auth/create_user_request.dart';
import 'package:meme_cloud/data/models/auth/sign_in_request.dart';
import 'package:meme_cloud/data/sources/auth/auth_supabase_service.dart';
import 'package:meme_cloud/domain/repositories/auth/auth_repository.dart';
import 'package:meme_cloud/service_locator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Either> signIn(SignInRequest signInRequest) async {
    return await serviceLocator<AuthSupabaseService>().signInWithEmail(
      signInRequest,
    );
  }

  @override
  Future<void> signOut() async {
    return await serviceLocator<AuthSupabaseService>().signOut();
  }

  @override
  Future<Either> signUp(CreateUserRequest createUserRequest) async {
    return await serviceLocator<AuthSupabaseService>().signUpWithEmail(
      createUserRequest,
    );
  }
}
