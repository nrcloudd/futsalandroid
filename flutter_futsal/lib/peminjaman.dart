import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_futsal/api_connection/api_connection.dart';
import 'package:flutter_futsal/home.dart';
import 'package:flutter_futsal/login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PeminjamanPage extends StatefulWidget {
  final int id;

  PeminjamanPage({required this.id});
  @override
  _SewaLapanganPageState createState() => _SewaLapanganPageState();
}

class _SewaLapanganPageState extends State<PeminjamanPage> {
  List<dynamic> form = [];

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
  TextEditingController _buktiBayarController = TextEditingController();

  String userName = '';

  @override
  void dispose() {
    _startTimeController.dispose();
    _endTimeController.dispose();
    _hargaController.dispose();
    super.dispose();
  }

  Future<void> getUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final userId = prefs.getInt('user_id');
      final userName = prefs.getString('user_name');
      final userEmail = prefs.getString('user_email');

      setState(() {
        this.userName = userName ?? '';
        _namaController.text = userName ?? '';
      });

      print('User Name: $userName');
    } catch (e) {
      print('$e');
      throw Exception('Failed to get user data');
    }
  }

  void initState() {
    super.initState();
    print('ID: ${widget.id}');
    getData();
    getUserData();
  }

  void getData() async {
    try {
      final lapanganData = await LapanganService.show(widget.id);
      setState(() {
        form = lapanganData;
        _lapanganController.text = form[0]['namaLapangan'].toString();
        _tipeController.text = form[0]['tipe'].toString();
        print(lapanganData);
      });
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

  Future<void> _calculateHarga() {
    if (_selectedStartTime != null && _selectedEndTime != null) {
      final int minDifference =
          _selectedEndTime.minute - _selectedStartTime.minute;
      final int hourDifference =
          (_selectedEndTime.hour - _selectedStartTime.hour) * 60;
      final int totalMinutes = minDifference + hourDifference;

      final int harga = form[0]['harga'];
      final int hargaKotor = totalMinutes * harga;
      final double totalHarga = hargaKotor / 60;

      _hargaController.text = totalHarga
          .toStringAsFixed(2); // Convert to string with 2 decimal places
    }

    return Future<void>.value();
  }

//  Future<void> getData() async {
//     try {
//       final data = await TipeLapanganService.getLapanganData();
//       setState(() {
//         form = data;
//         print(data);
//       });
//     } catch (e) {
//       print(e);
//     }
//   }

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
              Text(
                "DANA : 0895619425183 - Davin",
              ),
              SizedBox(height: 20.0),
              if (_pickedImageFile != null)
                Image.file(
                  File(_pickedImageFile!.path),
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

              ElevatedButton.icon(
                icon: Icon(Icons.check),
                label: Text('Submit'),
                onPressed: () {
                  final nama = _namaController.text;
                  final lapangan = _lapanganController.text;
                  final jamAwal = _startTimeController.text;
                  final jamAkhir = _endTimeController.text;
                  final tanggal = _dateController.text;
                  final totalBayar = _totalBayarController.text;
                  final sisaBayar = _sisaBayarController.text;
                  final bukti = _pickedImage != null ? _pickedImage!.path : '';

                  final data = {
                    'namaMember': nama,
                    'namaLapangan': lapangan,
                    'jamAwal': jamAwal,
                    'jamAkhir': jamAkhir,
                    'tanggal': tanggal,
                    'total_bayar': totalBayar,
                    'sisa_bayar': sisaBayar,
                    'bukti_bayar': bukti,
                  };

                  try {
                    TransaksiSubmit.createTransaksi(
                        data, _pickedImageFile?.path ?? '');
                    Fluttertoast.showToast(
                      msg:
                          'Data berhasil disimpan. Silakan lakukan pembayaran.',
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  } catch (e) {
                    print('Gagal membuat transaksi: $e');
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.amber,
                  onPrimary: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // Mengambil nilai input dari dropdown dan text field
  }

  XFile? _pickedImageFile;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    try {
      final pickedImage = await picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          _pickedImageFile = pickedImage;
        });

        // Getting the path and file name from pickedImage
        final imagePath = pickedImage.path;
        final fileName = imagePath.split('/').last;

        // Use imagePath and fileName as needed
        print('Path: $imagePath');
        print('File Name: $fileName');

        // Perform other operations you need with the path or file name
      }
    } on PlatformException catch (e) {
      // Handle any potential platform exceptions
      print('Failed to pick image: $e');
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
    totalHarga = double.parse(_hargaController.text).toInt();
    totalBayar = double.parse(_totalBayarController.text).toInt();
    sisaBayar = totalHarga - totalBayar;
    _sisaBayarController.text = sisaBayar.toString();
  }
}
