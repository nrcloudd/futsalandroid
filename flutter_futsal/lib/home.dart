import 'package:flutter/material.dart';
import 'history.dart';
import 'main.dart';
import 'peminjaman.dart';
import 'login.dart';
import 'editProfile.dart';
import 'api_connection/api_connection.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Product {
  final String title;

  Product(this.title);
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _statusState();
}

class _statusState extends State<HomePage> {
  List<dynamic> products = [];
 
  String userName = '';
  @override
  void initState() {
    super.initState();
    getLapanganData();
    getUserData();
  }

  Future<void> getUserData() async {
  try {
    final prefs = await SharedPreferences.getInstance();

    final userId = prefs.getInt('user_id');
    final userName = prefs.getString('user_name');
    final userEmail = prefs.getString('user_email');

    setState(() {
      this.userName = userName ?? '';
    });

    print('User Name: $userName');
  } catch (e) {
    print('$e');
    throw Exception('Failed to get user data');
  }
}


  Future<void> getLapanganData() async {
    try {
      final data = await TampilLapangan.getLapanganData();
      setState(() {
        products = data;
        print(data);
      });
    } catch (e) {
      print(e);
    }
  }
  Future<void> getUser() async{
    try {
      final data = await TampilLapangan.getLapanganData();
      setState(() {
        products = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('assets/images/avatar1.png'),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditProfile()));
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Welcome,$userName',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                )),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context); // Menutup drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('History'),
              onTap: () {
                Navigator.pop(context); // Menutup drawer
                Navigator.pushNamed(context, '/history');
              },
            ),
            ListTile(
              leading: Icon(Icons.logout_rounded),
              title: Text('Log Out'),
              onTap: () {
                Navigator.pop(context);
                // Menutup drawer
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Jumlah kolom
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          // Mengganti 'products' dengan data yang diambil dari database Laravel
          var product = products[index];

          return Card(
            child: ListTile(
              title: Stack(
                children: [
                  Image.asset(
                    'assets/images/IMG2.jpg',
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          product[
                              'namaLapangan'], // Menggunakan kolom 'namaLapangan' dari data
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              subtitle: ButtonBar(
                children: [
                  ElevatedButton(
                    child: Text('Pinjam'),
                    onPressed: () {
                      Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PeminjamanPage(id: product['id']),
    ),
  );
                    },
                  ),
                ],
              ),
            ),
          );
        },
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
        currentIndex: 0, // Index item yang terpilih
        onTap: (int index) {
          if (index == 1) {
            Navigator.pushNamed(context, '/history');
          }
        },
      ),
    );
  }
}

// class HistoryPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('History'),
//       ),
//       body: Center(
//         child: Text('History Page'),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     initialRoute: '/',
//     routes: {
//       '/': (context) => HomePage(),
//       '/history': (context) => HistoryPage(),
//     },
//   ));
// }
