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
}

