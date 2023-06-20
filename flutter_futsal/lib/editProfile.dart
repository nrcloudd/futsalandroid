import 'dart:io';
import 'package:flutter_futsal/api_connection/api_connection.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'home.dart';
import 'package:flutter_futsal/api_connection/api_connection.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late String _imagePath = ''; // Tambahkan variabel _imagePath
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();





  Future<void> _pickImage() async {
    String name = nameController.text;
    String phone = phoneController.text;
    API authService = API();


    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
      // Use _imagePath to access the selected image path
      // or perform other operations like uploading to a server
    }


  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Edit Profile'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: _imagePath.isNotEmpty
                      ? FileImage(File(_imagePath))
                      : null,
                  child: IconButton(
                    icon: Icon(Icons.camera_alt),
                    onPressed: _pickImage,
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                  });
                },
              ),
              SizedBox(height: 10),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: 'Nomor Telepon',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                onChanged: (value) {
                  setState(() {
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateProfile,
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _updateProfile() async{
    String name = nameController.text;
    String phone = phoneController.text;
    API authService = API();

    try {
      String responseMessage = await authService.updateProfile(name, phone);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Edit Result'),
          content: Text(responseMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (responseMessage == 'Edit successful') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditProfile()),
                  );
                }
              },
              child: Text('Next'),
            ),
          ],
        ),
      );
    } catch (e) {
      print(e);

    }
  }


}