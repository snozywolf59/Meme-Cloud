import 'package:meme_cloud/core/configs/usecase/use_case.dart';
import 'package:meme_cloud/data/models/auth/create_user_request.dart';
import 'package:dartz/dartz.dart';
import 'package:meme_cloud/domain/repositories/auth/auth_repository.dart';
import 'package:meme_cloud/core/service_locator.dart';

class SignUpUseCase implements UseCase<Either, CreateUserRequest> {
  @override
  Future<Either> call(CreateUserRequest params) {
    return serviceLocator<AuthRepository>().signUp(
      params
    );
  }
}
