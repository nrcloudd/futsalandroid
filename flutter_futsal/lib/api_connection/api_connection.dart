import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class API {
  static const String Connect = "http://127.0.0.1:8000";

  static Future<String> registerUser(
      String name, String email, String password, String phone) async {
    final response = await http.post(
      Uri.parse('$Connect/api/auth/register'),
      body: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,

      },
    );
    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

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


}
class TampilLapangan {
  static Future<List<dynamic>> getLapanganData() async {
    try {
      final response = await http.post(Uri.parse('http://127.0.0.1:8000/api/field/show'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        if (data.containsKey('data') && data['data'] is List<dynamic>) {
          return data['data'];
        } else {
          throw Exception('Format data tidak sesuai');
        }
      } else {
        throw Exception('Gagal memuat data');
      }
    } catch (error) {
      throw Exception('Terjadi kesalahan: $error');
    }
  }
}
class getUser {
  
}


