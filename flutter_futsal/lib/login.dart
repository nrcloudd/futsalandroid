import 'package:flutter/material.dart';
import 'package:flutter_futsal/api_connection/api_connection.dart';
import 'package:flutter_futsal/main.dart';
import 'package:flutter_futsal/peminjaman.dart';
import 'package:flutter_futsal/register.dart';
import 'package:flutter_futsal/home.dart';
import 'package:flutter_futsal/api_connection/api_connection.dart';
import 'package:http/http.dart' as http;
import 'splash_page.dart';
import 'package:flutter/gestures.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.black),
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/IMG1.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(8),
        // color: Colors.lightBlue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  color: Colors.lightBlue, shape: BoxShape.circle),
              child: Center(
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Welcome To FUTZONE",
              style: TextStyle(
                  fontSize: 20, color: Colors.black87, fontFamily: 'Acme'),
            ),
            Text(
              "User Login",
              style: TextStyle(
                  fontSize: 20, color: Colors.black87, fontFamily: 'Acme'),
            ),
            SizedBox(
              height: 20,
            ),

            //form email
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black87)),
                  prefixIcon: Icon(
                    Icons.person,
                    size: 40,
                  ),
                  hintText: "Masukkan Email",
                  hintStyle: TextStyle(color: Colors.black87),
                  labelText: "Email",
                  labelStyle: TextStyle(color: Colors.black87)),
            ),
            SizedBox(
              height: 20,
            ),

            //form pass
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black87)),
                  prefixIcon: Icon(
                    Icons.lock,
                    size: 40,
                  ),
                  hintText: "Masukkan Password",
                  hintStyle: TextStyle(color: Colors.black87),
                  labelText: "Password",
                  labelStyle: TextStyle(color: Colors.black87)),
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              color: Colors.lightBlue,
              elevation: 5,
              child: Container(
                height: 50,
                child: InkWell(
                  splashColor: Colors.white,
                  onTap: () {
                    loginUser();
                  },
                  child: Center(
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),

            RichText(
              text: TextSpan(
                text: "Don't have an account? ",
                style: TextStyle(fontSize: 16, color: Colors.black),
                children: [
                  TextSpan(
                    text: 'Register',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Handle the registration button press here
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Register(),
                          ),
                        );
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    String email = emailController.text;
    String password = passwordController.text;

    final responseMessage = await API.loginUser(email, password);

    // Display the response message
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Login Result'),
        content: Text(responseMessage),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (responseMessage == 'Login successful') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              }
            },
            child: Text('Next'),
          ),
        ],
      ),
    );
  }
}
