abstract class AuthRepository {
  Future<dynamic> signUp(String email, String password);
  Future<dynamic> signIn(String email, String password);
  Future<dynamic> logout(String email);
  Future<bool> isSignedIn();
  Future<dynamic> resetPassword(String email);
}
