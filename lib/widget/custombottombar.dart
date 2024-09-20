import 'dart:math';
import 'package:flutter/material.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({super.key});


  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.blue[900],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              child: const Icon(
                Icons.home,
                color: Colors.white,
                size: 50,
              ),
              onTap: () {
                print("Home button clicked");
              },
            ),
            SizedBox(
              width: max(1, 50),
            ),
            GestureDetector(
              child: const Icon(
                Icons.info,
                color: Colors.white,
                size: 50,
              ),
              onTap: () {
                print("Info button clicked");
              },
            ),
            SizedBox(
              width: max(1, 50),
            ),
            GestureDetector(
              child: const Icon(
                Icons.person,
                color: Colors.white,
                size: 50,
              ),
              onTap: () {
                print("person button clicked");
              },
            ),
          ],
        ),
    );
  }
}