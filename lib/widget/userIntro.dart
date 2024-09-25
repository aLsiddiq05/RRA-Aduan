import 'package:flutter/material.dart';

class UserIntro extends StatelessWidget {
  const UserIntro({super.key});

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
                  Text("Ali Bin Abu",
                      style: TextStyle(
                          color: Colors.amberAccent[200],
                          fontFamily: 'Roboto',
                          fontSize: 20)),
                ],
              ),
              subtitle: const Text(
                "Log masuk terakhir: 11/05/2024 17:30",
                style: TextStyle(color: Colors.white),
              ),
            ),
      ),
    );
  }
}