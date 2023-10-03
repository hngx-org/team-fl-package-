import 'dart:convert';
import 'dart:io';

import 'package:hng_authentication/src/authentication_repository.dart';
import 'package:hng_authentication/src/models/failure.dart';
import 'package:hng_authentication/src/models/user.dart';
import 'package:http/http.dart' as http;

class ApiConfig {
  static const String baseUrl =
      'https://spitfire-interractions.onrender.com/api/auth';
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
  };
}

class ApiException implements Exception {
  final String message;

  ApiException(this.message);
}

class Authentication implements AuthRepository {

  //signup function. This function registers a user, to allow usage of the App.
  @override
  Future<User?> signUp(String email, String name, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/register'),
        headers: ApiConfig.headers,
        body: jsonEncode({
          'email': email,
          'name': name,
          'password': password,
          'confirm_password': password,
        }),
      );

      switch (response.statusCode) {
        case 201:
          final responseData = jsonDecode(response.body)['data'];

          final user = User(
            id: responseData['id'],
            name: responseData['name'],
            email: responseData['email'],
            credits: responseData['credits'],
          );

          return user;

        case 400:
          throw Failure('Invalid input data.');

        case 405:
          throw Failure(
              'The HTTP method used is not allowed for this endpoint.');

        case 413:
          throw Failure('The request body is too long');

        case 422:
          throw Failure(
              'The server cannot process the request due to invalid data.');

        case 429:
          throw Failure('Rate limit exceeded. Please try again later.');

        default:
          throw Failure('Unknown error occurred.');
      }
    } on SocketException {
      throw Failure('Please check your internet connection 😑');
    } on FormatException {
      throw Failure('Bad response format 👎');
    } on HttpException {
      throw Failure('Please check your internet connection');
    } catch (e) {
      throw ApiException('Error signing up: ${e.toString()}');
    }
  }

  //signin function. This function allows a registered user to access the App
  @override
  Future signIn(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/login'),
        headers: ApiConfig.headers,
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );
      switch (response.statusCode) {
        case 200:
          final responseData = jsonDecode(response.body)['data'];
          final user = User(
            id: responseData['id'],
            name: responseData['name'],
            email: responseData['email'],
          );
          return user;

        case 400:
          throw Failure('Invalid input data.');

        case 405:
          throw Failure(
              'The HTTP method used is not allowed for this endpoint.');

        case 413:
          throw Failure('The request body is too long');

        case 422:
          throw Failure(
              'The server cannot process the request due to invalid data.');

        case 429:
          throw Failure('Rate limit exceeded. Please try again later.');

        default:
          throw Failure('Unknown error occurred.');
      }
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  //logout function. This function logout the user from the App.
  @override
  Future logout(String email) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/logout'),
        headers: ApiConfig.headers,
      );

      final responseData = json.decode(response.body);
      return responseData;
    } catch (e) {
      throw ApiException('Error logging out: ${e.toString()}');
    }
  }

  //getUser Profile for the server to be displayed on the App
  @override
  Future getUser() async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/@me'),
        headers: ApiConfig.headers,
      );
      switch (response.statusCode) {
        case 200:
          final responseData = jsonDecode(response.body)['data'];
          final user = User(
            id: responseData['id'],
            name: responseData['name'],
            email: responseData['email'],
          );
          return user;

        case 400:
          throw Failure('Invalid input data.');

        case 405:
          throw Failure(
              'The HTTP method used is not allowed for this endpoint.');

        case 413:
          throw Failure('The request body is too long');

        case 422:
          throw Failure(
              'The server cannot process the request due to invalid data.');

        case 429:
          throw Failure('Rate limit exceeded. Please try again later.');

        default:
          throw Failure('Unknown error occurred.');
      }
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
