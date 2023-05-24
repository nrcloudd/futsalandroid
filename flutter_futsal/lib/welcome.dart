import 'package:flutter/material.dart';
import 'package:flutter_futsal/login.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/IMG2.jpg"), fit: BoxFit.cover),
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Center(
                child: Text(
                  "Welcome To FUTZONE",
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 50,
                      fontFamily: 'Acme',
                      fontWeight: FontWeight.bold,
                      wordSpacing: 2),
                ),
              ),
            ),
            SizedBox(
              height: 70,
            ),
            Card(
              color: Colors.blueGrey,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                height: 40,
                width: 40,
                child: InkWell(
                  splashColor: Colors.white,
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Icon(Icons.keyboard_arrow_right),
                ),
              ),
            ),
          ]),
    )));
  }
}
