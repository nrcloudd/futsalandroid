import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class API {
  static const String Connect = "http://127.0.0.1:8000";

  static Future<String> registerUser(String name, String email, String password, /*String password_confirmation*/) async {
    final response = await http.post(
      Uri.parse('$Connect/api/auth/register'),
      body: {
        'name': name,
        'email': email,
        'password': password,
       // 'password':password_confirmation,

      },
    );

    if (response.statusCode == 201) {
      return 'Registration successful'; // Replace with your success message
    } else {
      return 'Registration failed '; // Replace with your failure message
    }
  }

  static Future<String> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse('$Connect/api/auth/login'),
      body: {
        'email': email,
        'password': password,
      },
    );
    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');
    if (response.statusCode == 200) {
      // Successful login
      return 'Login successful';
    } else {
      // Login failed
      return 'Login failed';
    }
  }

  static Future<List<dynamic>> getLapanganData() async {
    final response = await http.get(Uri.parse('$Connect/'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Gagal memuat data');
    }
  }
}
