import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meme_cloud/data/models/auth/create_user_request.dart';
import 'package:meme_cloud/data/models/auth/sign_in_request.dart';

abstract class AuthFirebaseService {
  Future<Either> signIn(SignInRequest signInRequest);

  Future<Either> signUp(CreateUserRequest createUserRequest);

  Future<void> signOut();
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  @override
  Future<Either> signIn(SignInRequest signInRequest) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: signInRequest.email,
        password: signInRequest.password,
      );

      return const Right('User signed in successfully');
    } on FirebaseAuthException catch (e) {
      return Left('Failed to sign in: ${e.code} ${e.message}');
    }
  }

  @override
  Future<Either> signUp(CreateUserRequest createUserRequest) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: createUserRequest.email,
        password: createUserRequest.password,
      );

      return const Right('User created successfully');
    } on FirebaseAuthException catch (e) {

      return Left('Failed to create user: ${e.code} ${e.message}');
    }
  }

  @override
  Future<void> signOut() async {
    // TODO: Implement signOut logic
  }
}
