import 'package:dartz/dartz.dart';
import 'package:meme_cloud/core/service_locator.dart';
import 'package:meme_cloud/domain/entities/auth/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class UserService {
  Future<Either> getCurrentUser();

  Future<Either> changePassword(String newPassword);
}

class UserServiceIplm extends UserService {
  final SupabaseClient _supabaseClient = serviceLocator<SupabaseClient>();
  @override
  Future<Either> getCurrentUser() async {
    try {
      User? user = Supabase.instance.client.auth.currentUser;
      if (user == null) return Left('User has not logged in');
      String id = user.id;
      final userJson =
          await _supabaseClient.from('users').select().eq('id', id).single();
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
