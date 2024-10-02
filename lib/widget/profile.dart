import 'package:flutter/material.dart';
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
      });
    }
  }

  Future<void> updateProfile(String nameN, String emailN) async {
    UpdateProfile pack = UpdateProfile();

    try {
      var res =
          await pack.updateProfileService(name: nameN, email: emailN);
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
                  hintText: oName,
                  hintStyle: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey),
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
                  hintText: oEmail,
                  hintStyle: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey),
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
              enabled: false,
              controller: null,
              decoration: InputDecoration(
                  label: Text('No Kad Pengenalan'),
                  hintText: noic,
                  hintStyle: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey),
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
            ElevatedButton(
                onPressed: () {
                  updateProfile(_name.text, _email.text);
                },
                child: Text('Kemas Kini'))
          ],
        ),
      ),
    ));
  }
}
