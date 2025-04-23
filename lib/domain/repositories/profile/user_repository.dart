import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either> getCurrentUser();

  Future<Either> changePassword(String newPassword);

  Future<String?> getAvatarUrl();
}
