import 'package:flutter/material.dart';
import 'package:flutter_futsal/login.dart';
import 'package:flutter_futsal/main.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_futsal/api_connection/api_connection.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Register',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.black),
      home: Register(),
    );
  }
}

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
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
              "Selamat Datang di FUTZONE",
              style: TextStyle(fontSize: 20, color: Colors.black87),
            ),
            Text(
              "User Register",
              style: TextStyle(fontSize: 20, color: Colors.black87),
            ),
            SizedBox(
              height: 20,
            ),

            //Form Nama
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black87)),
                  prefixIcon: Icon(
                    Icons.person_outline_rounded,
                    size: 30,
                  ),
                  hintText: "Masukkan Nama",
                  hintStyle: TextStyle(color: Colors.black87),
                  labelText: "Nama",
                  labelStyle: TextStyle(color: Colors.black87)),
            ),
            SizedBox(
              height: 20,
            ),


            //Form Email
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black87)),
                  prefixIcon: Icon(
                    Icons.person_outline_outlined,
                    size: 30,
                  ),
                  hintText: "Masukkan Email",
                  hintStyle: TextStyle(color: Colors.black87),
                  labelText: "Email",
                  labelStyle: TextStyle(color: Colors.black87)),
            ),
            SizedBox(
              height: 20,
            ),

            //Form Password
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black87)),
                  prefixIcon: Icon(
                    Icons.lock,
                    size: 30,
                  ),
                  hintText: "Masukkan Password",
                  hintStyle: TextStyle(color: Colors.black87),
                  labelText: "Password",
                  labelStyle: TextStyle(color: Colors.black87)),
            ),
            SizedBox(
              height: 20,
            ),


            //Form no HP
            TextFormField(
              controller: phoneController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black87)),
                  prefixIcon: Icon(
                    Icons.phone,
                    size: 30,
                  ),
                  hintText: "Masukkan No HP",
                  hintStyle: TextStyle(color: Colors.black87),
                  labelText: "No HP",
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
                    registerUser();

                  },
                  child: Center(
                    child: Text(
                      "Register",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    String namaMember = nameController.text;
    String emailMember = emailController.text;
    String passMember = passwordController.text;
    String noTelp = phoneController.text;


    final responseMessage = await API.registerUser(namaMember, emailMember, passMember, noTelp);

    // Display the response message
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Registration Result'),
        content: Text(responseMessage),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (responseMessage == 'Registration successful') {
                // Navigate to the login page or any other desired screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              }
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}


