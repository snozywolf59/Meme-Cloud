import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:meme_cloud/common/supabase.dart';
import 'package:meme_cloud/domain/entities/auth/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:mime/mime.dart';

abstract class UserService {
  Future<Either> getCurrentUser();

  Future<Either> changePassword(String newPassword);

  Future<Either> changeName(String newName);

  Future<String?> getAvatarUrl();

  Future<String?> uploadAvatar(File file);

  Future<void> deleteAvatar(String userId);
}

class UserServiceIplm extends UserService {

  final String _bucketName = 'images';
  final String _avatarFolder = 'avatar';

  @override
  Future<Either> getCurrentUser() async {
    try {
      User? user = supabase.auth.currentUser;
      if (user == null) return Left('User has not logged in');
      String id = user.id;
      final userJson =
          await supabase.from('users').select().eq('id', id).single();
      return Right(AppUser.fromJson(userJson));
    } catch (e) {
      return Left('Error $e');
    }
  }

  @override
  Future<Either> changePassword(String newPassword) {
    // TODO: implement changePassword
    throw UnimplementedError();
  }

  @override
  Future<String?> uploadAvatar(File file) async {
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) return null;

    final mimeType = lookupMimeType(file.path);
    final fileExt = _extensionFromMime(mimeType) ?? file.path.split('.').last;
    final filePath = '$_avatarFolder/$userId.$fileExt';

    await supabase.storage
        .from(_bucketName)
        .upload(
          filePath,
          file,
          fileOptions: FileOptions(contentType: mimeType, upsert: true),
        );

    final publicUrl = supabase.storage
        .from(_bucketName)
        .getPublicUrl(filePath);

    // Lưu vào DB nếu cần
    await supabase
        .from('users')
        .update({'avatar_url': publicUrl})
        .eq('id', userId);

    return publicUrl;
  }

  @override
  Future<String?> getAvatarUrl() async {
    String userId = supabase.auth.currentUser!.id;
    final res =
        await supabase
            .from('users')
            .select('avatar_url')
            .eq('id', userId)
            .single();

    return res['avatar_url'] as String?;
  }

  /// Delete avatar (optional)
  @override
  Future<void> deleteAvatar(String userId) async {
    final list = await supabase.storage
        .from(_bucketName)
        .list(path: _avatarFolder);

    FileObject? file;
    try {
      file = list.firstWhere((f) => f.name.startsWith(userId));
    } catch (_) {
      file = null;
    }

    if (file != null) {
      await supabase.storage.from(_bucketName).remove([
        '$_avatarFolder/${file.name}',
      ]);
    }

    await supabase
        .from('profiles')
        .update({'avatar_url': null})
        .eq('id', userId);
  }
  
  @override
  Future<Either> changeName(String newName) {
    // TODO: implement changeName
    throw UnimplementedError();
  }
}

String? _extensionFromMime(String? mimeType) {
  if (mimeType == null) return null;

  return extensionFromMime(mimeType);
}

/**
 * {
  "id": "e3c0e2b3-ddd0-4c1b-8b40-21db9c8f86ab",
  "appMetadata": {
    "provider": "email",
    "providers": ["email"]
  },
  "userMetadata": {
    "display_name": "Test Acc 2",
    "email": "testacc09@gmail.com",
    "email_verified": true,
    "phone_verified": false,
    "sub": "e3c0e2b3-ddd0-4c1b-8b40-21db9c8f86ab"
  },
  "aud": "authenticated",
  "confirmationSentAt": null,
  "recoverySentAt": null,
  "emailChangeSentAt": null,
  "newEmail": null,
  "invitedAt": null,
  "actionLink": null,
  "email": "testacc09@gmail.com",
  "phone": "",
  "createdAt": "2025-04-14T17:24:41.301694Z",
  "confirmedAt": "2025-04-14T17:24:41.322646Z",
  "emailConfirmedAt": "2025-04-14T17:24:41.322646Z",
  "phoneConfirmedAt": null,
  "lastSignInAt": "2025-04-16T12:34:47.344484004Z",
  "role": "authenticated",
  "updatedAt": "2025-04-16T12:34:47.346839Z",
  "identities": [
    {
      "id": "e3c0e2b3-ddd0-4c1b-8b40-21db9c8f86ab",
      "userId": "e3c0e2b3-ddd0-4c1b-8b40-21db9c8f86ab",
      "identityData": {
        "display_name": "Test Acc 2",
        "email": "testacc09@gmail.com",
        "email_verified": false,
        "phone_verified": false,
        "sub": "e3c0e2b3-ddd0-4c1b-8b40-21db9c8f86ab"
      },
      "identityId": "a4afced7-08ca-44b6-ba84-cbe3cbd26e4e",
      "provider": "email",
      "createdAt": "2025-04-14T17:24:41.319521Z",
      "lastSignInAt": "2025-04-14T17:24:41.319467Z",
      "updatedAt": "2025-04-14T17:24:41.319521Z"
    }
  ],
  "factors": null,
  "isAnonymous": false
}

 */
