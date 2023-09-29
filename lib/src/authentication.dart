import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiConfig {
  static const String baseUrl = 'your_api_base_url';
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
  };
}


class ApiException implements Exception {
  final String message;

  ApiException(this.message);
}

Future<T> _handleError<T>(dynamic e) {
  if (e is ApiException) {
    throw e;
  } else {
    throw ApiException('An error occurred: $e');
  }
}


class Authentication {
  Future signUp(String email, String name, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/signup'),
        headers: ApiConfig.headers,
        body: jsonEncode({'email': email, 'name': name, 'password': password}),
      );
      final responseData = jsonDecode(response.body);
      // Return responseData here if needed
    } catch (e) {
      throw ApiException('Error signing up: $e');
    }
  }

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

  Future<dynamic> logout(String email) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/logout'),
        headers: ApiConfig.headers,
        body: jsonEncode({'email': email}),
      );

      final responseData = json.decode(response.body);
      return responseData;
    } catch (e) {
      throw ApiException('Error logging out: $e');
    }
  }

  Future<dynamic> resetPassword(String email) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/resetPassword'),
        headers: ApiConfig.headers,
        body: jsonEncode({'email': email}),
      );

      final responseData = json.decode(response.body);
      return responseData;
    } catch (e) {
      throw ApiException('Error resetting password: $e');
    }
  }
}
