import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class API {
  static const String Connect = "http://127.0.0.1:8000";

  Future<String> registerUser(
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

  Future<String> loginUser(String email, String password) async {
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
      final jsonResponse = json.decode(response.body);
      final user = jsonResponse['user'];

      // Simpan setiap elemen di dalam user ke SharedPreferences
      await saveUserToSharedPreferences(user);
      return 'Login successful';
    } else {
      // Login failed
      return 'Login failed';
    }
  }

  Future<void> saveUserToSharedPreferences(Map<String, dynamic> user) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setInt('user_id', int.parse(user['id'].toString()));
      await prefs.setString('user_name', user['name']);
      await prefs.setString('user_email', user['email']);

      final userName = prefs.getString('user_name');
      final userEmail = prefs.getString('user_email');
      print('$userName');
      print('$userEmail');
    } catch (e) {
      print('$e');
      throw Exception('Failed to save user data');
    }
  }
}

class TampilLapangan {
  static Future<List<dynamic>> getLapanganData() async {
    try {
      final response =
          await http.post(Uri.parse('http://127.0.0.1:8000/api/field/show'));
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
class LapanganService {
  static Future<dynamic> show(int id) async {
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/api/field/show2'),
        body: {'id': id.toString()}, // Convert id to String before sending it in the request body
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final success = data['success'];
        final message = data['message'];
        final lapanganData = data['data'];

        if (success) {
          return lapanganData;
        } else {
          throw Exception('Data Post Tidak Ditemukan!');
        }
      } else {
        throw Exception('Gagal memuat data');
      }
    } catch (error) {
      throw Exception('Terjadi kesalahan: $error');
    }
  }
}

class transaksiSubmit {
  static Future<String> transaksi(String jamA, String jamB, String tanggal,
      String total_bayar, String bukti_bayar) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/trans/store'),
      body: {
        'jamAwal': jamA,
        'jamAkhir': jamB,
        'tanggal': tanggal,
        'total_bayar': total_bayar,
      },
    );
    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');
    if (response.statusCode == 201) {
      return 'Transaction successful'; // Replace with your success message
    } else {
      return 'Transaction failed '; // Replace with your failure message
    }
  }
}

// class TipeLapanganService {
//   static Future<dynamic> show() async {
//     try {
//       final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/tipe/show'));

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body) as Map<String, dynamic>;
//         final success = data['success'];
//         final message = data['message'];
//         final tipeLapanganData = data['data'];

//         if (success) {
//           return tipeLapanganData;
//         } else {
//           throw Exception('Data Tipe Lapangan Tidak Ditemukan!');
//         }
//       } else {
//         throw Exception('Gagal memuat data');
//       }
//     } catch (error) {
//       throw Exception('Terjadi kesalahan: $error');
//     }
//   }
// }