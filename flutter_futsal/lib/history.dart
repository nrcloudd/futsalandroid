import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_futsal/api_connection/api_connection.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}
class _HistoryPageState extends State<HistoryPage> {
  List<dynamic> transactions = [];


  @override
  void initState() {
    super.initState();
    tampilTransaksi();
  }

  Future<void> tampilTransaksi() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/auth/transaksi'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        transactions = data['transactions'];
      });
    } else {
      // Handle error case
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final transaction = transactions[index];
            return ListTile(
              title: Text(transaction['title']),
              subtitle: Text(transaction['date']),
              trailing: Text('\$${transaction['amount']}'),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'History',
          ),
        ],
        currentIndex: 1, // Index item yang terpilih
        onTap: (int index) {
          if (index == 1) {
            Navigator.pushNamed(context, '/history');
          }else{
            Navigator.pushNamed(context, '/home');
          }
        },
      ),
    );
  }
}