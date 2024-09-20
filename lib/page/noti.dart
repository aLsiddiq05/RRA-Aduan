import 'package:flutter/material.dart';
import 'package:rra_mobile/widget/customappbar.dart';

class Noti extends StatelessWidget {
  const Noti({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: "Notification",
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Center(
            child: Text("Notification"),
          ),
          ),
    );
  }
}