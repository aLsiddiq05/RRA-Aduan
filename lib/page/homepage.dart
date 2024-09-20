import 'package:flutter/material.dart';
import 'package:rra_mobile/views/login.dart';
import 'package:rra_mobile/widget/borangMB.dart';
import 'package:rra_mobile/widget/customappbar.dart';
import 'package:rra_mobile/widget/dashboard.dart';
import 'package:rra_mobile/widget/info.dart';
import 'package:rra_mobile/widget/profile.dart';
import 'package:rra_mobile/widget/userIntro.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // const HomePage({super.key});
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _pages = <Widget>[
    Dashboard(),
    Informasi(),
    Profil(),
  ];

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
              onPressed: () {
                print("logout button");
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
        content: _selectedIndex == 0 ?Container(
          child: Column(
            children: [
              UserIntro(),
              BorangMB(),
            ],
          ),
        ): null
      ),
      body: SingleChildScrollView(
        child: Center(
          child: _pages.elementAt(_selectedIndex),
        ),
      ),
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

