import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
        Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.blue[800],
                        borderRadius: BorderRadius.circular(10)),
                    child: const Icon(
                      Icons.warning_amber_outlined,
                      color: Colors.white,
                    ),
                  ),
                  title: const Text(
                    "Dalam Perhatian",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  trailing: Text("32",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[800])),
                ),
                ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.amber[800],
                        borderRadius: BorderRadius.circular(10)),
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                  title: const Text("Dalam Siasatan",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  trailing: Text("32",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber[800])),
                ),
                ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.green[800],
                        borderRadius: BorderRadius.circular(10)),
                    child: const Icon(
                      Icons.assignment_turned_in_outlined,
                      color: Colors.white,
                    ),
                  ),
                  title: const Text("Selesai",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  trailing: Text("32",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[800])),
                ),
                ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.red[800],
                        borderRadius: BorderRadius.circular(10)),
                    child: const Icon(
                      Icons.cancel_outlined,
                      color: Colors.white,
                    ),
                  ),
                  title: const Text("Batal",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  trailing: Text("32",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.red[800])),
                ),
                ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.blue[800],
                        borderRadius: BorderRadius.circular(10)),
                    child: const Icon(
                      Icons.cancel_presentation_outlined,
                      color: Colors.white,
                    ),
                  ),
                  title: const Text("Tolak",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  trailing: Text("32",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[900])),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 110,
                height: 100,
                child: Card(
                  child: GestureDetector(
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(),
                        Text(
                          "Taburan Maklum Balas",
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                    onTap: () {
                      print("Taburan Maklum Balas clicked");
                    },
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                width: 110,
                height: 110,
                child: Card(
                    child: GestureDetector(
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(),
                      Text(
                        "Semua Maklum Balas",
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                  onTap: () {
                    print("Semua Maklum Balas clicked");
                  },
                )),
              ),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                width: 110,
                height: 100,
                child: Card(
                  child: GestureDetector(
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(),
                        Text(
                          "Penilaian Perkhidmatan",
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                    onTap: () {
                      print("Penilaian Perkhidmatan clicked");
                    },
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
