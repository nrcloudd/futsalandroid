class API {
  static const String Connect = "http://127.0.0.1:8000";

  static Future<String> registerUser(
      String namaMember,
      String emailMember,
      String passMember,
      String noTelp,
      ) async {
    final response = await http.post(
      Uri.parse('$Connect/api/register'),
      body: {
        'namaMember': namaMember,
        'emailMember': emailMember,
        'passMember': passMember,
        'noTelp': noTelp,
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      String status = responseData['status'];
      String message = responseData['message'];

      if (status == 'success') {
        return 'Registration successful';
      } else if (status == 'error') {
        if (message == 'duplicate_email') {
          return 'Email is already taken. Please choose a different email.';
        } else {
          return 'Registration failed. Error: $message';
        }
      } else {
        return 'Registration failed';
      }
    } else {
      return 'Registration failed';
    }
  }
}