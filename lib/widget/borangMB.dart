import 'package:flutter/material.dart';
import 'package:rra_mobile/widget/mb_type_avatar.dart';
class BorangMB extends StatelessWidget {
  const BorangMB({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Maklum balas baharu",
                style: TextStyle(color: Colors.white),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 90,
                    height: 80,
                    child: Card(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomMBAvatar(
                                    initial: "A",
                                    backgroundColor: Colors.red[100]!,
                                    textColor: Colors.red[800]!),
                                const Text(
                                  "Aduan",
                                  style: TextStyle(fontSize: 10),
                                )
                              ],
                            ),
                            onTap: () {
                              print("Aduan Button clicked");
                              Navigator.pushNamed(context, '/mbAduan');
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 90,
                    height: 80,
                    child: Card(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomMBAvatar(
                                    initial: "T",
                                    backgroundColor: Colors.amber[200]!,
                                    textColor: Colors.amber[800]!),
                                const Text(
                                  "Pertanyaan",
                                  style: TextStyle(fontSize: 10),
                                )
                              ],
                            ),
                            onTap: () {
                              print("Pertanyaan button clicked");
                              Navigator.pushNamed(context, '/mbTanya');
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 90,
                    height: 80,
                    child: Card(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomMBAvatar(
                                    initial: "C",
                                    backgroundColor: Colors.green[100]!,
                                    textColor: Colors.green[800]!),
                                const Text(
                                  "Penghargaan",
                                  style: TextStyle(fontSize: 10),
                                )
                              ],
                            ),
                            onTap: () {
                              print("Penghargaan button clicked");
                              Navigator.pushNamed(
                                  context, '/mbPenghargaan');
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 90,
                    height: 80,
                    child: Card(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomMBAvatar(
                                    initial: "P",
                                    backgroundColor: Colors.blue[100]!,
                                    textColor: Colors.blue[800]!),
                                const Text(
                                  "Cadangan",
                                  style: TextStyle(fontSize: 10),
                                )
                              ],
                            ),
                            onTap: () {
                              print("cadangan button clicked");
                              Navigator.pushNamed(context, '/mbCadang');
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          )
      );
  }
}