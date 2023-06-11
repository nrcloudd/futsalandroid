import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class API {
  static const String Connect = "http://127.0.0.1:8000";

  static Future<String> registerUser(
      String namaMember, String emailMember, String passMember, String noTelp) async {
    final response = await http.post(
      Uri.parse('$Connect/api/register'),
      body: {
        'namaMember': namaMember,
        'emailMember': emailMember,
        'passMember': passMember,
        'noTelp': noTelp,

      },
    );

    if (response.statusCode == 201) {
      return 'Registration successful'; // Replace with your success message
    } else {
      return 'Registration failed '; // Replace with your failure message
    }
  }

  static Future<String> loginUser(String emailMember, String passMember) async {
    final response = await http.post(
      Uri.parse('$Connect/api/login'),
      body: {
        'emailMember': emailMember,
        'passMember': passMember,
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

  static Future<String> editUser(
      String namaMember, String namalMember, String noTelp) async {
    final response = await http.post(
      Uri.parse('$Connect/api/edituser'),
      body: {
        'namaMember': namaMember,
        'noTelp': noTelp,

      },
    );

    if (response.statusCode == 201) {
      return 'Edit Profile successful'; // Replace with your success message
    } else {
      return 'Edit Profile failed '; // Replace with your failure message
    }
  }


}

