import 'package:flutter_test/flutter_test.dart';
import 'package:hng_authentication/src/models/failure.dart';
import 'package:hng_authentication/src/models/user.dart';
import 'package:hng_authentication/authentication.dart';

void main() {
  group('Authentication', () {
    Authentication authentication = Authentication();

    test('signUp - successful sign-up returns a User', () async {
      //Arrange
      const email = 'test@example.com';
      const name = 'Test User';
      const password = 'password';

      // Act
      final user = await authentication.signUp(email, name, password);

      // Assert
      expect(user, isA<User>());
    });

    test('signUp - invalid input data throws Failure', () async {
      // Arrange
      const email = 'test@example.com';
      const name = 'Test User';
      const password = 'password';

      // Act and Assert
      expect(
        () async => await authentication.signUp(email, name, password),
        throwsA(isA<Failure>()),
      );
    });

    test('signIn - successful sign-in returns a User', () async {
      //Arrange
      const email = 'test@example.com';
      const password = 'password';

      // Act
      final user = await authentication.signIn(email, password);

      // Assert
      expect(user, isA<User>());
    });

    test('signIn - invalid input data throws Failure', () async {
      const email = 'test@example.com';
      const password = 'password';

      expect(
        () async => await authentication.signIn(email, password),
        throwsA(isA<Failure>()),
      );
    });
  });
}
