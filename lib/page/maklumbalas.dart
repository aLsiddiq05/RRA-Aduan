import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rra_mobile/widget/customappbar.dart';
import 'package:rra_mobile/widget/mb_type_avatar.dart';

class MaklumBalas extends StatefulWidget {

  @override
  State<MaklumBalas> createState() => _MaklumBalasState();
}

class _MaklumBalasState extends State<MaklumBalas> {
  late Widget showWidget = Container();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _tajuk = TextEditingController();
  final TextEditingController _butiran = TextEditingController();

  @override
  void initState() {
    super.initState();
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
                          title: Text(
                         'Saya'
                          ),
                        )),
                    const SizedBox(
                      height: 10,
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
                          return 'Sila masukkan butiran';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 10,
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
