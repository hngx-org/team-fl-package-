import 'package:flutter_test/flutter_test.dart';
import 'package:hng_authentication/src/models/failure.dart';
import 'package:hng_authentication/src/models/user.dart';
import 'package:hng_authentication/authentication.dart'; // Import your Authentication class


void main() {
  group('Authentication', () {
    Authentication authentication =
        Authentication(); // Initialize your Authentication class

    test('signUp - successful sign-up returns a User', () async {
      // Arrange
      const email = 'test@example.com';
      const name = 'Test User';
      const password = 'password';

      // Act
      final user = await authentication.signUp(email, name, password);

      // Assert
      expect(user, isA<User>());
      // Add more specific assertions about the returned user if needed
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
      // You can add more specific assertions about the Failure object if needed
    });

    test('signIn - successful sign-in returns a User', () async {
      // Arrange
      const email = 'test@example.com';
      const password = 'password';

      // Act
      final user = await authentication.signIn(email, password);

      // Assert
      expect(user, isA<User>());
      // Add more specific assertions about the returned user if needed
    });

    test('signIn - invalid input data throws Failure', () async {
      // Arrange
      const email = 'test@example.com';
      const password = 'password';

      // Act and Assert
      expect(
        () async => await authentication.signIn(email, password),
        throwsA(isA<Failure>()),
      );
      
    });

    
  });
}
