import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  AdminPage({super.key});

  late double mWidth;

  @override
  Widget build(BuildContext context) {
    // mWidth = MediaQuery.of(context).size.width;
    // mWidth = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card( 
            child: GestureDetector(
              child: Column(
                children: [
                  Text('Pegawai'),
                  Icon(Icons.people),
                ],
              ),
              onTap: () {
                print('Button Pegawai');
              },
            ),
          ),
          SizedBox(height: 10,),
          Card(
            child: GestureDetector(
              child: Column(
                children: [
                  Text('Pengguna'),
                  Icon(Icons.people)
                ],
              ),
              onTap: () {
                print('Button Penggunan');
              },
            ),
          )
        ],
      ),
      );
  }
}