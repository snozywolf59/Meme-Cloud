

abstract class AuthFirebaseService {
  Future<void> signIn({required String email, required String password});

  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
  });

  Future<void> signOut();
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  @override
  Future<void> signIn({required String email, required String password}) async {
    // TODO: Implement signIn logic
  }

  @override
  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    // TODO: Implement signUp logic
  }

  @override
  Future<void> signOut() async {
    // TODO: Implement signOut logic
  }
}