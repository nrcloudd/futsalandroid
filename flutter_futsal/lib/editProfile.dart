import 'dart:io';
import 'package:flutter_futsal/api_connection/api_connection.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'home.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String _name = '';
  String _phoneNumber = '';
  late String _imagePath = ''; // Tambahkan variabel _imagePath
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();


  void _updateProfile() {
    // Simulasi logika untuk mengirim perubahan ke database
    // Anda dapat menyesuaikan dengan logika sesuai kebutuhan aplikasi Anda

    // Simulasi berhasil
    bool updateSuccess = true;

    if (updateSuccess) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green),
                SizedBox(width: 10),
                Text('Update Berhasil'),
              ],
            ),
            content: Text('Perubahan berhasil disimpan.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                Icon(Icons.cancel, color: Colors.red),
                SizedBox(width: 10),
                Text('Update Gagal'),
              ],
            ),
            content: Text('Terjadi kesalahan saat menyimpan perubahan.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
   
   Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile  = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile  != null) {
       
      setState(() {
        _imagePath  = pickedFile.path;
      });
      // Gunakan pickedImage untuk mengakses path gambar yang dipilih
      // atau melakukan operasi lain seperti mengunggah ke server
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                backgroundImage: _imagePath != null ? FileImage(File(_imagePath)) : null,
                child: IconButton(
                  icon: Icon(Icons.camera_alt),
                  onPressed: _pickImage,
                ),
              ),
            ),


            SizedBox(height: 20),
            TextField(
              controller : nameController,
              decoration: InputDecoration(
                labelText: 'Nama',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _name = value;
                });
              },
            ),


            SizedBox(height: 10),
            TextField(
              controller : phoneController,
              decoration: InputDecoration(
                labelText: 'Nomor Telepon',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
              onChanged: (value) {
                setState(() {
                  _phoneNumber = value;
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
    );
  }
  Future<void> registerUser() async {
    String namaMember = nameController.text;
    String noTelp = phoneController.text;

    final responseMessage = await API.editUser(namaMember, noTelp);

    // Display the response message
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text('Profile Edit Result'),
            content: Text(responseMessage),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  if (responseMessage == 'Profile Edit') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
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
