import 'package:dartz/dartz.dart';
import 'package:meme_cloud/core/service_locator.dart';
import 'package:meme_cloud/data/sources/profile/user_service.dart';
import 'package:meme_cloud/domain/entities/auth/user.dart';
import 'package:meme_cloud/domain/repositories/profile/user_repository.dart';

class UserRepositoryIpml extends UserRepository {
  AppUser? _user;

  @override
  Future<Either> getCurrentUser() async {
    if (_user != null) return Right(_user);
    return await serviceLocator<UserService>().getCurrentUser();
  }

  @override
  Future<Either> saveUser(AppUser user) {
    // TODO: implement saveUser
    throw UnimplementedError();
  }

  @override
  Future<Either> changeAvt() {
    // TODO: implement changeAvt
    throw UnimplementedError();
  }

  @override
  Future<Either> changePassword(String newPassword) async {
    return await serviceLocator<UserService>().changePassword(newPassword);
  }
}
