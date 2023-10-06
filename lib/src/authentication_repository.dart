import 'package:hng_authentication/src/models/user.dart';

/// An abstract class representing an authentication repository interface.
///
/// Implementations of this class should provide methods for user authentication,
/// including sign-up, sign-in, logging out, and retrieving user data.
abstract class AuthRepository {
  /// Sign up a new user with the provided [email], [name], and [password].
  Future<User?> signUp(String email, String name, String password);

  /// Sign in a user with the provided [email] and [password].
  Future signIn(String email, String password);

  /// Log out the user associated with the given [email].
  Future logout(String email);

  /// Retrieve user information for the currently authenticated user.
  Future getUser();
}
