import 'dart:convert';
import 'package:example/src/authentication_repository.dart';
import 'package:http/http.dart' as http;

class ApiConfig {
  static const String baseUrl = 'https://spitfire-interractions.onrender.com/api/auth';
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
  };
}

class ApiException implements Exception {
  final String message;

  ApiException(this.message);
}


class Authentication implements AuthRepository {
  @override
  // accept defined model, crete a listner for FE. 
  Future<dynamic> signUp(String email, String name, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/register'),
        headers: ApiConfig.headers,
        body: jsonEncode({
          'email': email,
          'name': name,
          'password': password,
          'confirm_password': password
        }),
      );
      final responseData = jsonDecode(response.body);
      // Return responseData here if needed
      // return model quicktype.io
      print('this is sign up >>>>: $responseData');
      return responseData;
    } catch (e) {
      throw ApiException('Error signing up: $e');
    }
  }

  @override
  Future<dynamic> signIn(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/login'),
        headers: ApiConfig.headers,
        body: jsonEncode({'email': email, 'password': password}),
      );

      final responseData = json.decode(response.body);
      return responseData;
    } catch (e) {
      throw ApiException('Error signing in: $e');
    }
  }

  @override
  Future<dynamic> logout(String email) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/logout'),
        headers: ApiConfig.headers,
      );

      final responseData = json.decode(response.body);
      return responseData;
    } catch (e) {
      throw ApiException('Error logging out: $e');
    }
  }


  @override
  Future<dynamic> getUser() async{
   try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/@me'),
        headers: ApiConfig.headers,
      );
      final responseData = json.decode(response.body);
      return responseData;
    } catch (e) {
      throw ApiException('Error resetting password: $e');
    }
  }
}
