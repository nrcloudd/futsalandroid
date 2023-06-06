import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PeminjamanPage extends StatefulWidget {
  @override
  _SewaLapanganPageState createState() => _SewaLapanganPageState();
}

class _SewaLapanganPageState extends State<PeminjamanPage> {
  late String _selectedDate;
  late String _selectedTime;
    int totalHarga = 100000; // Ganti dengan nilai total harga yang sesuai
    int totalBayar = 0;
    int sisaBayar = 0;
  TextEditingController _namaController = TextEditingController();
  TextEditingController _totalBayarController = TextEditingController();
  TextEditingController _sisaBayarController = TextEditingController();

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
              ElevatedButton(
                child: Text('Pilih Jam Awal'),
                onPressed: () {
                  _selectTime(context);
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                child: Text('Pilih Tanggal'),
                onPressed: () {
                  _selectDate(context);
                },
              ),
              SizedBox(height: 16.0),
              Text(
                'Total Harga:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                // totalHarga.toString(),
                
                'Total harga: $totalHarga',
                // Total harga dapat diganti sesuai dengan logika bisnis Anda
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 16.0),
              Text(
                'Total Bayar:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              TextField(
                controller: _totalBayarController,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  // Lakukan perhitungan otomatis saat total bayar berubah
                  _calculateSisaBayar();
                },
              ),
              SizedBox(height: 16.0),
              Text(
                'Sisa Bayar:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
               TextField(
                controller: _sisaBayarController,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  // Lakukan perhitungan otomatis saat total bayar berubah
                  _calculateSisaBayar();
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                child: Text('Unggah Gambar'),
                onPressed: () {
                  // Tambahkan logika unggah gambar dari penyimpanan internal
                },
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

  void _selectTime(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selectedTime != null) {
      setState(() {
        _selectedTime = selectedTime.format(context);
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
    // Lakukan logika penyimpanan ke database di sini
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


