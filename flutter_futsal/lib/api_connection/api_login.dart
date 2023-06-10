import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class API {
  static const String Connect = "http://127.0.0.1:8000";

  static Future<String> loginUser(String emailMember, String passMember) async {
    final response = await http.post(
      Uri.parse('$Connect/api/login'),
      body: {
        'emailMember': emailMember,
        'passMember': passMember,
      },
    );
    if (response.statusCode == 200) {
      // Successful login
      final token = response.body; // Assuming the response contains a token
      return token;
    } else {
      // Login failed
      return "Login failed";
    }
  }
}
