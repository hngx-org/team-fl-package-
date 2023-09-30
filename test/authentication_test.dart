import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

// Import your authentication package classes and concrete implementation here
import 'package:authentication/authentication.dart';
import 'package:authentication/src/authentication_repository.dart';

class MockHttpClient extends Mock implements http.Client {}

class ConcreteAuthenticationRepository extends AuthRepository {
  ConcreteAuthenticationRepository(http.Client httpClient) : super();

  @override
  Future<bool> isSignedIn() {
    // TODO: implement isSignedIn
    throw UnimplementedError();
  }

  @override
  Future logout(String email) {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future resetPassword(String email) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future signIn(String email, String password) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future signUp(String email, String name, String password) {
    // TODO: implement signUp
    throw UnimplementedError();
  }
}

void main() {
  late ConcreteAuthenticationRepository authenticationRepository;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    authenticationRepository = ConcreteAuthenticationRepository(mockHttpClient);
  });

  // Authentication.signUp()

  test('signUp() successfully creates a new user', () async {
    // Mock the HTTP response to return a 200 OK status code.
    when(mockHttpClient.post(
      Uri.parse('${ApiConfig.baseUrl}/signup'),
      headers: ApiConfig.headers,
      body: jsonEncode({
        'email': 'test@email.com',
        'name': 'Test User',
        'password': 'password'
      }),
    )).thenAnswer(
      (_) async => http.Response('''
    {
    "message": "User Created Succesfully",
    "data": {
        "name": "name",
        "email": "test@mail.com",
        "id": "1"
    },
}''', 201),
    );

    // Sign up the new user.
    final result = await authenticationRepository.signUp(
        'test@email.com', 'Test User', 'password');

    // Expect the result to be true.
    expect(result, true);

    // Verify that the HTTP client was called with the correct parameters.
    verify(mockHttpClient.post(
      Uri.parse('${ApiConfig.baseUrl}/signup'),
      headers: ApiConfig.headers,
      body: jsonEncode({
        "name": "name",
        "email": "test@mail.com",
        "password": "password",
        "confirm_password": "password"
      }),
    ));
  });

  test('signUp() throws an exception if the HTTP request fails', () async {
    // Mock the HTTP response to return a 500 Internal Server Error status code.
    when(mockHttpClient.post(
      Uri.parse('${ApiConfig.baseUrl}/signup'),
      headers: ApiConfig.headers,
      body: jsonEncode({
        "name": "name",
        "email": "test@mail.com",
        "password": "password",
        "confirm_password": "password"
      }),
    )).thenAnswer((_) async => http.Response(
          '{"error": "Internal server error","message":"It\'s not you, it\'s us. We encountered an internal server error.",}',
          500,
        ));

    // Try to sign up the new user and expect an ApiException.
    expect(
        () async => await authenticationRepository.signUp(
            'test@email.com', 'Test User', 'password'),
        throwsA(TypeMatcher<ApiException>()));
  });

  // Authentication.signIn()

  test('signIn() successfully signs in a user', () async {
    // Mock the HTTP response to return a 200 OK status code.
    when(mockHttpClient.post(
      Uri.parse('${ApiConfig.baseUrl}/login'),
      headers: ApiConfig.headers,
      body: jsonEncode({'email': 'test@email.com', 'password': 'password'}),
    )).thenAnswer((_) async => http.Response('{"success": true}', 200));

    // Sign in the user.
    final result =
        await authenticationRepository.signIn('test@email.com', 'password');

    // Expect the result to be true.
    expect(result, true);

    // Verify that the HTTP client was called with the correct parameters.
    verify(mockHttpClient.post(
      Uri.parse('${ApiConfig.baseUrl}/login'),
      headers: ApiConfig.headers,
      body: jsonEncode({'email': 'test@email.com', 'password': 'password'}),
    ));
  });

  test('signIn() throws an exception if the HTTP request fails', () async {
    // Mock the HTTP response to return a 500 Internal Server Error status code.
    when(mockHttpClient.post(
      Uri.parse('${ApiConfig.baseUrl}/login'),
      headers: ApiConfig.headers,
      body: jsonEncode({'email': 'test@email.com', 'password': 'password'}),
    )).thenAnswer((_) async => http.Response(
          '{"error": "Internal server error","message":"It\'s not you, it\'s us. We encountered an internal server error.",}',
          500,
        ));

    // Try to sign in the user and expect an ApiException.
    expect(
        () async =>
            await authenticationRepository.signIn('test@email.com', 'password'),
        throwsA(TypeMatcher<ApiException>()));
  });

  // Authentication.resetPassword()

  test('resetPassword() successfully resets a user\'s password', () async {
    // Mock the HTTP response to return a 200 OK status code.
    when(mockHttpClient.post(
      Uri.parse('${ApiConfig.baseUrl}/resetPassword'),
      headers: ApiConfig.headers,
      body: jsonEncode({'email': 'test@email.com'}),
    )).thenAnswer((_) async => http.Response('{"success": true}', 200));

    // Reset the user's password.
    final result =
        await authenticationRepository.resetPassword('test@email.com');

    // Expect the result to be true.
    expect(result, true);
  });

  // Authentication.logout()

  test('logout() successfully logs out a user', () async {
    // Mock the HTTP response to return a 200 OK status code.
    when(mockHttpClient.post(
      Uri.parse('${ApiConfig.baseUrl}/logout'),
      headers: ApiConfig.headers,
      body: jsonEncode({'email': 'test@email.com'}),
    )).thenAnswer((_) async => http.Response('{"success": true}', 200));

    // Log out the user.
    final result = await authenticationRepository.logout('test@email.com');

    // Expect the result to be true.
    expect(result, true);

    // Verify that the HTTP client was called with the correct parameters.
    verify(mockHttpClient.post(
      Uri.parse('${ApiConfig.baseUrl}/logout'),
      headers: ApiConfig.headers,
      body: jsonEncode({'email': 'test@email.com'}),
    ));
  });

  test('logout() throws an exception if the HTTP request fails', () async {
    // Mock the HTTP response to return a 500 Internal Server Error status code.
    when(mockHttpClient.post(
      Uri.parse('${ApiConfig.baseUrl}/logout'),
      headers: ApiConfig.headers,
      body: jsonEncode({'email': 'test@email.com'}),
    )).thenAnswer(
        (_) async => http.Response('{"error": "Internal server error"}', 500));

    // Try to log out the user and expect an ApiException.
    expect(() async => await authenticationRepository.logout('test@email.com'),
        throwsA(TypeMatcher<ApiException>()));
  });
}
