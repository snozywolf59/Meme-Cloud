import 'package:meme_cloud/core/configs/usecase/use_case.dart';
import 'package:meme_cloud/data/models/create_user_request.dart';
import 'package:dartz/dartz.dart';
import 'package:meme_cloud/domain/reposities/auth/auth_reposity.dart';
import 'package:meme_cloud/service_locator.dart';

class SignupUseCase implements UseCase<Either, CreateUserRequest> {
  @override
  Future<Either> call(CreateUserRequest params) {
    // TODO: implement call
    return sl<AuthRepository>().signUp(
      params!
    );
  }
}
