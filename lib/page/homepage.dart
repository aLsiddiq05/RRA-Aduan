import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rra_mobile/page/maklumbalas.dart';
import 'package:rra_mobile/views/login.dart';
import 'package:rra_mobile/widget/allAduan.dart';
import 'package:rra_mobile/widget/customappbar.dart';
import 'package:rra_mobile/widget/info.dart';
import 'package:rra_mobile/widget/profile.dart';
import 'package:rra_mobile/widget/statusbutton.dart';
import 'package:rra_mobile/widget/userIntro.dart';
// import 'package:rra_mobile/widget/borangMB.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final storage = const FlutterSecureStorage();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _pages = <Widget>[
    AllAduan(),
    Informasi(),
    Profil(),
  ];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Respons Rakyat",
        backgroundColor: const Color(0xFF0D47A1),
        actions: [
          IconButton(
              onPressed: () {
                print("Noti button");
                Navigator.pushNamed(context, '/noti');
              },
              icon: const Icon(
                Icons.notifications,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () async {
                print("logout button");
                await storage.deleteAll();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
        content: _selectedIndex == 0
            ? Container(
                child: const Column(
                  children: [
                    UserIntro(), // user profile
                    ShowStatus() // tukar jadi status
                  ],
                ),
              )
            : null,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: _pages.elementAt(_selectedIndex),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MaklumBalas()),
          );
        },
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue[500],
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomNavigationBar(
          iconSize: 35,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.blue[900],
          fixedColor: Colors.white,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Info'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
          ]),
    );
  }
}
