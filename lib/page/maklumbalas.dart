import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rra_mobile/widget/customappbar.dart';
import 'package:rra_mobile/widget/mb_type_avatar.dart';

// ignore: must_be_immutable
class MaklumBalas extends StatefulWidget {
  // const MaklumBalas({super.key});
  String title;
  String initial;
  Color backgroundColor;
  Color textColor;
  bool lokasi;

  MaklumBalas({Key? key, required this.title, required this.initial, required this.backgroundColor, required this.textColor, required this.lokasi}):super(key: key);

  @override
  State<MaklumBalas> createState() => _MaklumBalasState();
}

class _MaklumBalasState extends State<MaklumBalas> {
  late Widget showWidget = Container();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _agensi = TextEditingController();
  final TextEditingController _tajuk = TextEditingController();
  final TextEditingController _butiran = TextEditingController();
  final TextEditingController _lokasi = TextEditingController();

  @override
  void initState() {
    super.initState();
    lokasicontent();
  }

  void lokasicontent() {
    if (widget.lokasi == true) {
      showWidget = locationFun();
    }
  }

  Widget locationFun() {
    return Column(
      children: [
        Container(
            // height: 30,
            width: double.infinity,
            color: Colors.blueGrey[200],
            child: ListTile(
              leading: const Icon(
                Icons.map,
                size: 25,
              ),
              title: Text(
                'Lokasi',
                style: TextStyle(
                    color: Colors.blue[900],
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            )),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: _lokasi,
          decoration: InputDecoration(
            label: const Row(
              children: [
                Icon(Icons.map, color: Colors.grey),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Lokasi',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey),
                )
              ],
            ),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Sila masukkan Tajuk';
            }
            return null;
          },
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: 'Maklum Balas Baharu'),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                        // height: 30,
                        width: double.infinity,
                        color: Colors.blueGrey[200],
                        child: ListTile(
                          leading: CustomMBAvatar(initial: widget.initial, backgroundColor: widget.backgroundColor, textColor: widget.textColor),
                          title: Text(
                            widget.title,
                            style: TextStyle(
                                color: Colors.blue[900],
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _agensi,
                      decoration: InputDecoration(
                        label: const Row(
                          children: [
                            FaIcon(FontAwesomeIcons.sitemap, color: Colors.grey),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Agensi',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            )
                          ],
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Sila masukkan agensi';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _tajuk,
                      decoration: InputDecoration(
                        label: const Row(
                          children: [
                            FaIcon(FontAwesomeIcons.book, color: Colors.grey),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Tajuk',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            )
                          ],
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Sila masukkan Tajuk';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _butiran,
                      maxLines: 3,
                      decoration: InputDecoration(
                        label: const Row(
                          children: [
                            FaIcon(FontAwesomeIcons.edit, color: Colors.grey),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Butiran',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            )
                          ],
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Sila masukkan agensi';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    //lokasi widget
                    showWidget,

                    Container(
                        // height: 30,
                        width: double.infinity,
                        color: Colors.blueGrey[200],
                        child: ListTile(
                          leading: const Icon(
                            Icons.attach_file,
                            size: 25,
                          ),
                          title: Text(
                            'Lampiran (0/50 mb)',
                            style: TextStyle(
                                color: Colors.blue[900],
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                print('test button 1');
                              },
                              child: const Icon(Icons.camera_alt, size: 35),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                print('test button 2');
                              },
                              child: const Icon(Icons.videocam, size: 35),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                print('test button 3');
                              },
                              child: const Icon(Icons.image, size: 35),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                print('test button 4');
                              },
                              child: const Icon(Icons.keyboard_voice, size: 35),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                print('test button 5');
                              },
                              child: const Icon(Icons.attach_file, size: 35),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.blue[900],
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () {
                        print('Hanto button');
                      }, 
                      child: const Text('Hantar', style: TextStyle(fontSize: 18),))
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
