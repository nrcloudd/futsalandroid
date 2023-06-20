import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_futsal/api_connection/api_connection.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

class PeminjamanPage extends StatefulWidget {
  
  final int id;

  PeminjamanPage({required this.id});
  @override
  _SewaLapanganPageState createState() => _SewaLapanganPageState();
}

class _SewaLapanganPageState extends State<PeminjamanPage> {
  
  File? _pickedImage;
  late String _selectedDate;
  late String _selectedTime;
  int totalHarga = 0; // Ganti dengan nilai total harga yang sesuai
  int totalBayar = 0;
  int sisaBayar = 0;
  TimeOfDay _selectedStartTime = TimeOfDay.now();
  TimeOfDay _selectedEndTime = TimeOfDay.now();

  
  TextEditingController _namaController = TextEditingController();
  TextEditingController _totalBayarController = TextEditingController();
  TextEditingController _sisaBayarController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
   TextEditingController _startTimeController = TextEditingController();
  TextEditingController _endTimeController = TextEditingController();
  TextEditingController _hargaController = TextEditingController();
TextEditingController _lapanganController = TextEditingController();
TextEditingController _tipeController = TextEditingController();
@override
  void dispose() {
    _startTimeController.dispose();
    _endTimeController.dispose();
    _hargaController.dispose();
    super.dispose();
  }
  void initState() {
    super.initState();
    print('ID: ${widget.id}');
    getData();
  }
   void getData() async {
  try {
    final lapanganData = await LapanganService.show(widget.id);
    print(lapanganData); // Print the lapanganData inside the try block
    // Process lapanganData according to your needs
  } catch (error) {
    print(error);
  }
}


Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: _selectedStartTime,
    );

    if (selectedTime != null) {
      setState(() {
        _selectedStartTime = selectedTime;
        _startTimeController.text = selectedTime.format(context);
        _calculateHarga();
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: _selectedEndTime,
    );

    if (selectedTime != null) {
      setState(() {
        _selectedEndTime = selectedTime;
        _endTimeController.text = selectedTime.format(context);
        _calculateHarga();
      });
    }
  }

 void _calculateHarga() {
    if (_selectedStartTime != null && _selectedEndTime != null) {
      final int minDifference= 
          _selectedEndTime.minute - _selectedStartTime.minute;      
      final int hourDifference =
          (_selectedEndTime.hour - _selectedStartTime.hour)*60;
      final double harga = (minDifference + hourDifference) * 100000/60;

      _hargaController.text = harga.toString();
    }
  }


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
               TextField(
                controller: _lapanganController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Nama Lapangan',
                ),
              ),
              TextField(
                controller: _tipeController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Tipe Lapangan',
                ),
              ),
              SizedBox(height: 20.0),
             TextField(
              controller: _startTimeController,
              readOnly: true,
              onTap: () => _selectStartTime(context),
              decoration: InputDecoration(
                labelText: 'Jam Awal',
                suffixIcon: Icon(Icons.access_time),
              ),
            ),
            TextField(
              controller: _endTimeController,
              readOnly: true,
              onTap: () => _selectEndTime(context),
              decoration: InputDecoration(
                labelText: 'Jam Akhir',
                suffixIcon: Icon(Icons.access_time),
              ),
            ),
              SizedBox(height: 20.0),
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
              controller: _hargaController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Harga',
              ),
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
    totalHarga = int.parse(_hargaController.text); // Ganti dengan nilai total harga yang sesuai
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
