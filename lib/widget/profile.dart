import 'package:flutter/material.dart';
import 'package:rra_mobile/page/homepage.dart';
import 'package:rra_mobile/services/profilService.dart';
import 'package:rra_mobile/services/updateProfile.dart';

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _idNo = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var noic = '';
  var oName = '';
  var oEmail = '';

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  Future<void> getProfile() async {
    final pack = ProfilService();
    final res = await pack.getMyProfile();

    if (res != null) {
      print('getProfile - update profile page success');
      setState(() {
        oName = res['name'];
        oEmail = res['email'];
        noic = res['id_no'];

        
        _name.text = oName; 
        _email.text = oEmail; 
        _idNo.text = noic;
      });
    }
  }

  Future<void> updateProfile(String nameN, String emailN, String idNoN) async {
    UpdateProfile pack = UpdateProfile();

    try {
      var res = await pack.updateProfileService(
          name: nameN, email: emailN, idno: idNoN);
      showSuccess();
      print('result:  $res');
    } catch (e) {
      showFail();
      print('Error: $e');
    }
  }

  void showSuccess() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            icon: Icon(Icons.check),
            iconColor: Colors.green,
            title: Text('Berjaya !!!'),
            content: Text('Kemas kini profil anda berjaya'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    getProfile();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                        (Route<dynamic> route) => false);
                  },
                  child: const Text('OK'))
            ],
          );
        });
  }

  void showFail() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            icon: Icon(Icons.error),
            iconColor: Colors.red,
            title: Text('Gagal !!!'),
            content: Text('Kemas kini profil anda tidak berjaya'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    getProfile();
                  },
                  child: const Text('OK'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              color: Colors.blueGrey[50],
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Kemas Kini Profil',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue[900],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _name,
              decoration: InputDecoration(
                  label: const Text('Nama'),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  floatingLabelBehavior: FloatingLabelBehavior.always),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please fill your name';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _email,
              decoration: InputDecoration(
                  label: const Text('Email'),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  floatingLabelBehavior: FloatingLabelBehavior.always),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please fill your email';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _idNo,
              decoration: InputDecoration(
                  label: const Text('No Kad Pengenalan'),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  floatingLabelBehavior: FloatingLabelBehavior.always),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please fill your ID number';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    updateProfile(_name.text, _email.text, _idNo.text);
                  }
                },
                child: Text('Kemas Kini'))
          ],
        ),
      ),
    ));
  }
}
