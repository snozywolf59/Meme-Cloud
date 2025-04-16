import 'package:dartz/dartz.dart';
import 'package:meme_cloud/domain/entities/auth/user.dart';

abstract class UserRepository {
  Future<Either> saveUser(AppUser user);

  Future<Either> getCurrentUser();

  Future<Either> changePassword(String newPassword);

  Future<Either> changeAvt();
}
