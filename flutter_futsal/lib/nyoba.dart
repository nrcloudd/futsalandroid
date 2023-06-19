import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TimePickerPage extends StatefulWidget {
  @override
  _TimePickerPageState createState() => _TimePickerPageState();
}

class _TimePickerPageState extends State<TimePickerPage> {
  TextEditingController _startTimeController = TextEditingController();
  TextEditingController _endTimeController = TextEditingController();
  TextEditingController _hargaController = TextEditingController();

  TimeOfDay _selectedStartTime = TimeOfDay.now();
  TimeOfDay _selectedEndTime = TimeOfDay.now();

  @override
  void dispose() {
    _startTimeController.dispose();
    _endTimeController.dispose();
    _hargaController.dispose();
    super.dispose();
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
        title: Text('Time Picker Demo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _startTimeController,
              readOnly: true,
              onTap: () => _selectStartTime(context),
              decoration: InputDecoration(
                labelText: 'Jam Awal',
                suffixIcon: Icon(Icons.access_time),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _endTimeController,
              readOnly: true,
              onTap: () => _selectEndTime(context),
              decoration: InputDecoration(
                labelText: 'Jam Akhir',
                suffixIcon: Icon(Icons.access_time),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _hargaController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Harga',
              ),
            ),
          ],
        ),
      ),
    );
  }
}


