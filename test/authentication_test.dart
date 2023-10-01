import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hng_authentication/authentication.dart';
import 'package:mockito/mockito.dart';

import 'package:http/http.dart' as http;

// Create a mock HTTP client for testing
class MockClient extends Mock implements http.Client {}

void main() {
  group('Authentication Tests', () {
    Authentication authentication = Authentication();
    MockClient mockClient;

    setUp(() {
      mockClient = MockClient();

      // Mock the HTTP response for sign up
      when(mockClient.post(
        Uri.parse('${ApiConfig.baseUrl}/register'),
        headers: ApiConfig.headers,
        body: jsonEncode({
          'email': anyNamed('email'),
          'name': anyNamed('name'),
          'password': anyNamed('password'),
          'confirm_password': anyNamed('confirm_password'),
        }),
      )).thenAnswer((_) async => http.Response('{"success": true}', 200));

      // Mock the HTTP response for sign in
      when(mockClient.post(
        Uri.parse('${ApiConfig.baseUrl}/login'),
        headers: ApiConfig.headers,
        body: jsonEncode({
          'email': anyNamed('email'),
          'password': anyNamed('password'),
        }),
      )).thenAnswer((_) async => http.Response('{"success": true}', 200));

      // Mock the HTTP response for isSignedIn
      when(mockClient.post(
        Uri.parse('${ApiConfig.baseUrl}/@me'),
        headers: ApiConfig.headers,
      )).thenAnswer((_) async => http.Response('{"authenticated": true}', 200));

      // Mock the HTTP response for logout
      when(mockClient.get(
        Uri.parse('${ApiConfig.baseUrl}/logout'),
        headers: ApiConfig.headers,
      )).thenAnswer((_) async => http.Response('{"success": true}', 200));
    });

    test('Sign Up - Successful', () async {
      const email = 'test@example.com';
      const name = 'Test User';
      const password = 'password123';

      final response = await authentication.signUp(email,name,password);

      expect(response, isNotNull);
      expect(response['success'], true);
    });

    test('Sign In - Successful', () async {
      const email = 'test@example.com';
      const password = 'password123';

      final response = await authentication.signIn(email, password);

      expect(response, isNotNull);
      expect(response['success'], true);
    });

    test('Is Signed In - Successful', () async {
      final response = await authentication.isSignedIn();

      expect(response, isNotNull);
      expect(response['authenticated'], true);
    });

    test('Logout - Successful', () async {
      final response = await authentication.logout('test@example.com');

      expect(response, isNotNull);
      expect(response['success'], true);
    });
  });
}
