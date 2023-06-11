Future<void> registerUser() async {
  String namaMember = nameController.text;
  String emailMember = emailController.text;
  String passMember = passwordController.text;
  String noTelp = phoneController.text;

  final responseMessage =
  await API.registerUser(namaMember, emailMember, passMember, noTelp);

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