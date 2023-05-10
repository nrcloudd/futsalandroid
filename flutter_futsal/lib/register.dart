import 'package:flutter/material.dart';
import 'package:flutter_futsal/login.dart';
import 'package:flutter_futsal/main.dart';

class RegisterPage extends StatelessWidget {

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text('User Register'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Nama',
                  ),
                ),
                SizedBox(height: 16.0),

                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                SizedBox(height: 16.0),

                TextField(
                  decoration: InputDecoration(
                    labelText: 'No HP',
                  ),
                ),
                SizedBox(height: 16.0),

                TextField(
                  decoration: InputDecoration(
                    labelText: 'Username',
                  ),
                ),
                SizedBox(height: 16.0),

                TextField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                ),
                SizedBox(height: 16.0),

                Center(
                  child: SizedBox(
                    width: 100,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    LoginPage()));
                      },
                      child: Text('Register'),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}






