import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:rra_mobile/widget/allAduan.dart';

class ShowStatus extends StatelessWidget {
  const ShowStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 90,
            height: 80,
            child: Card(
              color: const Color.fromARGB(255, 169, 190, 200),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Terima"),
                      Text("0")
                    ],
                  ),
                  onTap: () {
                    // AllAduan(0);
                  },
                ),
                ),
            ),
          ),
          SizedBox(
            width: 90,
            height: 80,
            child: Card(
              color: Colors.blueAccent,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  child:const  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Siasatan"),
                      Text("0")
                    ],
                  ),
                  onTap: () {
                    
                  },
                ),
                ),
            ),
          ),
          SizedBox(
            width: 90,
            height: 80,
            child: Card(
              color: Colors.green,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Selesai"),
                      Text("0")
                    ],
                  ),
                  onTap: () {
                    
                  },
                ),
                ),
            ),
          ),
          SizedBox(
            width: 90,
            height: 80,
            child: Card(
              color: Colors.redAccent,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Batal"),
                      Text("0")
                    ],
                  ),
                  onTap: () {
                    
                  },
                ),
                ),
            ),
          ),
        ],
      ),
      );
  }
}