import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

class PeminjamanPage extends StatefulWidget {
  @override
  _SewaLapanganPageState createState() => _SewaLapanganPageState();
}

class _SewaLapanganPageState extends State<PeminjamanPage> {
  File? _pickedImage;
  late String _selectedDate;
  late String _selectedTime;
  int totalHarga = 100000; // Ganti dengan nilai total harga yang sesuai
  int totalBayar = 0;
  int sisaBayar = 0;
  TextEditingController _namaController = TextEditingController();
  TextEditingController _totalBayarController = TextEditingController();
  TextEditingController _sisaBayarController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sewa Lapangan'),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _namaController,
                decoration: InputDecoration(
                  labelText: 'Nama',
                ),
              ),
              SizedBox(height: 16.0),
              // ElevatedButton(
              //   child: Text('Pilih Jam Awal'),
              //   onPressed: () {
              //     _selectTime(context);
              //   },
              // ),
              TextField(
                controller: _timeController,
                readOnly: true,
                onTap: () {
                  _selectTime(context);
                },
                decoration: InputDecoration(
                  labelText: 'Waktu Awal :',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _dateController,
                readOnly: true,
                onTap: () {
                  _selectDate(context);
                },
                decoration: InputDecoration(
                  labelText: 'Tanggal',
                ),
              ),
              SizedBox(height: 8.0),
              TextField(
                readOnly: true,
                controller:
                    TextEditingController(text: 'Total harga: Rp. $totalHarga'),
                // Total harga dapat diganti sesuai dengan logika bisnis Anda
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 16.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Total Bayar:',
                ),
                controller: _totalBayarController,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  // Lakukan perhitungan otomatis saat total bayar berubah
                  _calculateSisaBayar();
                },
              ),
              SizedBox(height: 8.0),
              TextField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Sisa Bayar:',
                ),
                controller: _sisaBayarController,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  // Lakukan perhitungan otomatis saat total bayar berubah
                  _calculateSisaBayar();
                },
              ),
              SizedBox(height: 16.0),
              // ElevatedButton(
              //   child: Text('Unggah Gambar'),
              //   onPressed: () {
              //     _pickImage();
              //   },
              // ),

              if (_pickedImage != null)
                Image.network(
                  _pickedImage!.path,
                  width: 200,
                  height: 200,
                )
              else
                Text('Belum ada gambar dipilih'),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Upload Bukti Pembayaran'),
              ),

              SizedBox(height: 16.0),
              ElevatedButton(
                child: Text('Sewa'),
                onPressed: () {
                  _submitTransaksi();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _pickedImage = File(pickedImage.path);
      });
      // Gunakan pickedImage untuk mengakses path gambar yang dipilih
      // atau melakukan operasi lain seperti mengunggah ke server
    }
  }

  void _selectTime(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selectedTime != null) {
      setState(() {
        _selectedTime = selectedTime.format(context);
        _timeController.text = _selectedTime.toString();
      });
    }
  }

  void _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 3)),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
        _dateController.text = _selectedDate.toString();
      });
    }
  }

  void _calculateSisaBayar() {
    // Lakukan perhitungan sisa bayar sesuai dengan logika bisnis Anda
    // Contoh perhitungan: sisaBayar = totalHarga - totalBayar
    totalHarga = 100000; // Ganti dengan nilai total harga yang sesuai
    totalBayar = int.parse(_totalBayarController.text);
    sisaBayar = totalHarga - totalBayar;
    _sisaBayarController.text = sisaBayar.toString();
  }

  void _submitTransaksi() {
    // Lakukan logika  enyimpanan ke database di sini
    // Jika berhasil, tampilkan pop-up "Transaksi berhasil"
    // Jika gagal, tampilkan pop-up "Transaksi gagal"
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Status Transaksi'),
          content: Text('Transaksi berhasil'),
          actions: [
            ElevatedButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
