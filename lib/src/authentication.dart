import 'dart:convert';
import 'dart:io';
import 'package:hng_authentication/src/authentication_repository.dart';
import 'package:hng_authentication/src/models/failure.dart';
import 'package:hng_authentication/src/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// class [ApiConfig] to store the base API URL and
/// request headers for consistency.
class ApiConfig {
  static const String baseUrl =
      'https://spitfire-interractions.onrender.com/api/auth';
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
  };
}

/// class [ApiException] which implement interface Exception class

class ApiException implements Exception {
  final String message;

  ApiException(this.message);
}

/// This class, `Authentication`, implements the [AuthRepository] interface and
/// provides methods for user authentication, including sign-up, sign-in, and
/// logging out. It communicates with a remote API using HTTP requests and
/// handles various API response scenarios.
///
class Authentication implements AuthRepository {
  @override

  /// signUp async function which recieve [email] [name] and [password]
  /// as a means of signing up and registering user
  Future<User?> signUp(String email, String name, String password) async {
    try {
      // Make a POST request to register a new user.
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
          // Handle a successful registration response.
          final responseData = jsonDecode(response.body)['data'];

          // Create a User object from the response data based on the user model.
          final user = User(
            id: responseData['id'],
            name: responseData['name'],
            email: responseData['email'],
            credits: responseData['credits'],
          );

          //return the user object if registration after successful registration
          return user;

        case 400:
          // Handle a 400 Bad Request response (Invalid input data) using failure class.
          throw Failure('Invalid input data.');

        case 405:
          // Handle a 405 Method Not Allowed response.
          throw Failure(
              'The HTTP method used is not allowed for this endpoint.');

        case 413:
          // Handle a 413 Payload Too Large response.
          throw Failure('The request body is too long');

        case 422:
          // Handle a 422 Unprocessable Entity response (Invalid data).
          throw Failure(
              'The server cannot process the request due to invalid data.');

        case 429:
          // Handle a 429 Too Many Requests response (Rate limit exceeded).
          throw Failure('Rate limit exceeded. Please try again later.');

        default:
          // Handle other response codes with a generic failure message.
          throw Failure('Unknown error occurred.');
      }
    } on SocketException {
      // Handle a SocketException (Network connectivity issue).
      throw Failure('Please check your internet connection 😑');
    } on FormatException {
      // Handle a FormatException (Bad response format).
      throw Failure('Bad response format 👎');
    } on HttpException {
      // Handle an HttpException (Network connectivity issue).
      throw Failure('Please check your internet connection');
    } catch (e) {
      // Handle other exceptions and provide an error message.
      throw ApiException('Error signing up: ${e.toString()}');
    }
  }

  @override

  /// signIn async function which recieve [email] and [password]
  /// as a means of signing in user
  Future signIn(String email, String password) async {
    try {
      // Make a POST request to log in the user.
      final response = await http.post(Uri.parse('${ApiConfig.baseUrl}/login'),
          headers: ApiConfig.headers,
          body: jsonEncode({
            'email': email,
            'password': password,
          }));

      switch (response.statusCode) {
        case 200:
          // Handle a successful sign-in response.
          final responseData = jsonDecode(response.body)['data'];

          // Create a User object from the response data.
          final user = User(
            id: responseData['id'],
            name: responseData['name'],
            email: responseData['email'],
            cookie: response.headers['set-cookie'],

            ///this set the cookie so user can have access to it and use it
            credits: responseData['credits'],
          );

          return user;

        case 400:
          // Handle a 400 Bad Request response (Invalid input data).
          throw Failure('Invalid input data.');

        case 405:
          // Handle a 405 Method Not Allowed response.
          throw Failure(
              'The HTTP method used is not allowed for this endpoint.');

        case 413:
          // Handle a 413 Payload Too Large response.
          throw Failure('The request body is too long');

        case 422:
          // Handle a 422 Unprocessable Entity response (Invalid data).
          throw Failure(
              'The server cannot process the request due to invalid data.');

        case 429:
          // Handle a 429 Too Many Requests response (Rate limit exceeded).
          throw Failure('Rate limit exceeded. Please try again later.');

        default:
          // Handle other response codes with a generic failure message.
          throw Failure('Unknown error occurred.');
      }
    } catch (e) {
      // Handle other exceptions and provide an error message.
      throw Failure(e.toString());
    }
  }

  @override

  /// logout async function which recieve [email]
  /// as a means of signing out
  Future logout(String email) async {
    // Get an instance of SharedPreferences for managing user data.
    final pref = await SharedPreferences.getInstance();

    try {
      // Make a GET request to log the user out.
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/logout'),
        headers: ApiConfig.headers,
      );

      // Decode the response body to access data from the logout request.
      final responseData = json.decode(response.body);

      // Clear user preferences to perform a logout operation.
      pref.clear();

      // Return the response data as a result of the logout operation.
      return responseData;
    } catch (e) {
      // Handle exceptions and provide an error message in case of failure.
      throw ApiException('Error logging out: ${e.toString()}');
    }
  }

  @override

  /// getUser async function which get the present login user
  Future getUser() async {
    // Get an instance of SharedPreferences to retrieve the user's cookie data.
    final pref = await SharedPreferences.getInstance();

    // Retrieve the user's cookie from SharedPreferences.
    final cookie = pref.getString('cookie');

    try {
      // Make a POST request to retrieve user data.
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/@me'),
        headers: {
          ...ApiConfig.headers,
          'cookie': cookie!,
        },
      );

      switch (response.statusCode) {
        case 200:
          // Handle a successful response with user data.
          final responseData = jsonDecode(response.body)['data'];

          // Create a User object from the response data, including the user's cookie.
          final user = User(
              id: responseData['id'],
              name: responseData['name'],
              email: responseData['email'],
              credits: responseData['credits'],
              cookie: cookie);

          return user;

        case 400:
          // Handle a 400 Bad Request response (Invalid input data).
          throw Failure('Invalid input data.');

        case 405:
          // Handle a 405 Method Not Allowed response.
          throw Failure(
              'The HTTP method used is not allowed for this endpoint.');

        case 413:
          // Handle a 413 Payload Too Large response.
          throw Failure('The request body is too long');

        case 422:
          // Handle a 422 Unprocessable Entity response (Invalid data).
          throw Failure(
              'The server cannot process the request due to invalid data.');

        case 429:
          // Handle a 429 Too Many Requests response (Rate limit exceeded).
          throw Failure('Rate limit exceeded. Please try again later.');

        default:
          // Handle other response codes with a generic failure message.
          throw Failure('Unknown error occurred.');
      }
    } catch (e) {
      // Handle exceptions and provide an error message in case of failure.
      throw Failure(e.toString());
    }
  }
}
