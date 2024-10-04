import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:http/http.dart';
import 'package:rra_mobile/page/maklumbalas.dart';
// import 'package:rra_mobile/services/allAduanService.dart';
import 'package:rra_mobile/views/login.dart';

import 'package:rra_mobile/widget/allAduan.dart';
import 'package:rra_mobile/widget/customappbar.dart';
import 'package:rra_mobile/widget/info.dart';
import 'package:rra_mobile/widget/profile.dart';
import 'package:rra_mobile/widget/userIntro.dart';
import 'package:rra_mobile/widget/userPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final storage = const FlutterSecureStorage();
  var _roleId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRoleId();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _pages = <Widget>[
    AllAduan(), //can change
    Informasi(),
    Profil(),
  ];

  void getRoleId() async {
    final roleId = await storage.read(key: 'roleId');
    setState(() {
      _roleId = roleId;
      mainShow();
    });
  }

  void mainShow() {
    setState(() {
      if (_roleId == '2') {
        _pages[0] = UserPage();
      } else if (_roleId == '3') {
        _pages[0] = AllAduan();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: "Respons Rakyat",
          backgroundColor: _roleId == '3' ? const Color(0xFF0D47A1) : Colors.teal,
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
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ))
          ],
          bottom: _selectedIndex == 0
              ? PreferredSize(
                  preferredSize: const Size.fromHeight(90.0),
                  child: Container(
                    child: UserIntro(),
                    padding: EdgeInsets.only(bottom: 15),
                  ))
              : null),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      floatingActionButton: 
      _selectedIndex == 0 && _roleId == '3'
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MaklumBalas()),
                );
              },
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue[500],
              child: const Icon(Icons.add),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomNavigationBar(
          iconSize: 35,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          backgroundColor: _roleId == '3' ? Colors.blue[900] : Colors.teal,
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
