import 'package:flutter/material.dart';
import 'package:rra_mobile/services/profilService.dart';

class UserIntro extends StatefulWidget {
  const UserIntro({super.key});

  @override
  _UserIntroState createState() => _UserIntroState();
}

class _UserIntroState extends State<UserIntro> {
  String? userName;

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  // Fetch user profile data
  Future<void> _fetchProfile() async {
    final profilService = ProfilService();
    final profileData = await profilService.getMyProfile();

    if (profileData != null && mounted) {
      setState(() {
        userName = profileData['name'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        color: Colors.transparent,
        child: ListTile(
          leading: CircleAvatar(
            child: Icon(Icons.person, color: Colors.grey[800]),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Selamat Datang,",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              Text(
                userName ??
                    "Loading...", 
                style: TextStyle(
                  color: Colors.amberAccent[200],
                  fontFamily: 'Roboto',
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
