import 'package:flutter/material.dart';
import 'package:rra_mobile/views/AduanList.dart';
import 'package:rra_mobile/page/penggunaList.dart';

class UserPage extends StatelessWidget {
  UserPage({super.key});

  late double mWidth;
  // late double mHeight;

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    // mHeight = MediaQuery.of(context).size.height;
    return Container(
      width: mWidth,
      // height: mHeight,
      margin: EdgeInsets.all(mWidth * 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: Card(
                color: Colors.grey[400],
                child: GestureDetector(
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Pengguna',
                        style: TextStyle(fontSize: 25),
                      ),
                      Icon(
                        Icons.people,
                        size: 60,
                      ),
                    ],
                  ),
                  onTap: () {
                    print('Button Pengguna');
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PenggunaList(),));
                  },
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: Card(
                color: Colors.grey[400],
                child: GestureDetector(
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Aduan',
                        style: TextStyle(fontSize: 25),
                      ),
                      Icon(
                        Icons.message_outlined,
                        size: 60,
                      )
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AduanListPage()),
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
