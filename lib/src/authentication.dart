import 'dart:convert';

import 'package:authentication/src/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Authentication implements AuthRepository {
  @override
  Future<dynamic> signUp(String email, String password) async {
    // Implement signup logic here
    try {
      final response = await http.post(
        Uri.parse('apiUrl/signup'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final userId = data['userId'];
        return userId;
      } else {
        final errorData = json.decode(response.body);
        final errorMessage = errorData['error'];
        return errorMessage;
      }
    } catch (e) {
      return 'An error occurred: $e';
    }
  }

  @override
  Future<dynamic> signIn(String email, String password) async {
    // Implement signin logic here
    try {
      final response = await http.post(
        Uri.parse('apiUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      final responseData = json.decode(response.body);
      return responseData;
    } catch (e) {
      print('Error signing UP user/admin>>>>> : $e');
      return SnackBar(
          content: Text(
        'Error: $e',
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w500,
          backgroundColor: Colors.red,
        ),
      ));
    }
  }

  @override
  Future<dynamic> logout(String email) async {
    // Implement logout logic here
    try {
      final response = await http.post(
        Uri.parse('apiUrl/logout'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
        }),
      );

      final responseData = json.decode(response.body);
      return responseData;
    } catch (e) {
      print('Error signing UP user/admin>>>>> : $e');
      return SnackBar(
          content: Text(
        'Error: $e',
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w500,
          backgroundColor: Colors.red,
        ),
      ));
    }
  }

  @override
  Future<dynamic> resetPassword(String email) async {
    // Implement reset password logic here
    try {
      final response = await http.post(
        Uri.parse('apiUrl/resetPassword'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
        }),
      );

      final responseData = json.decode(response.body);
      return responseData;
    } catch (e) {
      print('Error signing UP user/admin>>>>> : $e');
      return SnackBar(
          content: Text(
        'Error: $e',
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w500,
          backgroundColor: Colors.red,
        ),
      ));
    }
  }

  @override
  Future<bool> isSignedIn() {
    // TODO: implement isSignedIn
    throw UnimplementedError();
  }
}
