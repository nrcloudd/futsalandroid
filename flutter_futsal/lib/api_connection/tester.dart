import 'package:flutter/gestures.dart';

class HomePage extends StatelessWidget {
  // ...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      // ... Rest of your code

      body: Column(
        children: [
          // ... Your existing widgets

          SizedBox(height: 20),
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
                          builder: (context) => RegistrationPage(),
                        ),
                      );
                    },
                ),
              ],
            ),
          ),
        ],
      ),

      // ... Rest of your code
    );
  }
}
