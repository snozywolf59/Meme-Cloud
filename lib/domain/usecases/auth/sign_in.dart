import 'package:dartz/dartz.dart';
import 'package:meme_cloud/core/configs/usecase/use_case.dart';
import 'package:meme_cloud/data/models/auth/sign_in_request.dart';
import 'package:meme_cloud/domain/repositories/auth/auth_repository.dart';
import 'package:meme_cloud/service_locator.dart';

class SignInUseCase implements UseCase<Either, SignInRequest> {
  @override
  Future<Either> call(SignInRequest params) async {
    // Implement the sign-in logic here
    // For example, you might want to call an authentication service
    // and handle the response accordingly.
    return await serviceLocator<AuthRepository>().signIn(
      params
    );
  }

}