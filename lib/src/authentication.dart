import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Authentication {
 

  Future<void> signUp(String email, String password) async {
    // Implement signup logic here
    
  }

  Future<dynamic> signIn(String email, String password) async {
    // Implement signin logic here
    try {
      final response = await http.post(
        Uri.parse('apiUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),);

         final responseData = json.decode(response.body);
        return responseData;
    } catch (e) {
         print('Error signing UP user/admin>>>>> : $e');
      return SnackBar(
          content: Text(
        'Error: $e',
        style: const TextStyle(
          fontSize: 16,
          color:Colors.white ,
          fontWeight: FontWeight.w500,
          backgroundColor: Colors.red,
        ),
      ));
    }
  }

  Future<dynamic> logout(String email) async {
    // Implement logout logic here
      try {
      final response = await http.post(
        Uri.parse('apiUrl/logout'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email,}),
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

  Future<dynamic> resetPassword(String email) async {
    // Implement reset password logic here
    try {
          final response = await http.post(
        Uri.parse('apiUrl/resetPassword'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email,}),
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
}
