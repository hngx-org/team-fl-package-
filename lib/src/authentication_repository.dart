import 'package:hng_authentication/src/models/user.dart';

abstract class AuthRepository {
  Future<User?> signUp(String email, String name, String password);
  Future signIn(String email, String password);
  Future logout(String email);
  Future getUser();
}
