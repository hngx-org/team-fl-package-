

abstract class AuthRepository {
  Future<dynamic> signUp(String email, String name, String password);
  Future<dynamic> signIn(String email, String password);
  Future<dynamic> logout(String email);
  Future<dynamic> isSignedIn();
}
