import 'package:flutter/material.dart';
import 'history.dart';
import 'main.dart';
import 'peminjaman.dart';
import 'login.dart';
import 'editProfile.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Product {
  final String title;

  Product(this.title);
}



class HomePage extends StatelessWidget {
  final List<Product> products = [
    Product('Lapangan 1'),
    Product('Lapangan 2'),
    Product('Lapangan 3'),
    Product('Lapangan 4'),
    Product('Lapangan 5'),
  ];

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
                            MaterialPageRoute(builder: (context) => EditProfile())
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Welcome, ...!',
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
      body: GridView.count(
        crossAxisCount: 2, // Jumlah kolom
        children: List.generate(products.length, (index) {
          return Card(
              child: ListTile(
                  title: Stack(
                    children: [
                      Image.asset(
                        'assets/images/IMG2.jpg', // Path file gambar default
                      ),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              products[index].title,
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
                                builder: (context) => PeminjamanPage(),
                              ),
                            );
                          }),
                    ],
                  )));
        }),
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



      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Phone Number'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Please enter your phone number:'),
                    TextField(
                      decoration: InputDecoration(labelText: 'Phone Number'),
                    ),
                  ],
                ),
                actions: [
                  ElevatedButton(
                    child: Text('Submit'),
                    onPressed: () {
                      // Handle the form submission here
                      // You can access the entered phone number using the TextField's controller
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          },
        ),
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
