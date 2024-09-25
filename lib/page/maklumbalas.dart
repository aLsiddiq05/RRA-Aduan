import 'package:rra_mobile/widget/customappbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rra_mobile/page/homepage.dart';
import 'package:rra_mobile/services/tambahAduanService.dart';
import 'package:intl/intl.dart';

class MaklumBalas extends StatefulWidget {
  @override
  State<MaklumBalas> createState() => _MaklumBalasState();
}

class _MaklumBalasState extends State<MaklumBalas> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _tajuk = TextEditingController();
  final TextEditingController _butiran = TextEditingController();
  final TambahAduanService _aduanService = TambahAduanService();
  bool _isSubmitting = false;

  Future<void> submitAduanForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });

      final result =
          await _aduanService.submitAduan(_tajuk.text, _butiran.text);

      setState(() {
        _isSubmitting = false;
      });

      if (result != null) {
        _showSnackbar('Aduan successfully submitted!', Colors.green);
        _showReceipt(result);
      } else {
        _showSnackbar('Failed to submit Aduan. Please try again.', Colors.red);
      }
    }
  }

  void _showSnackbar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  void _showReceipt(Map<String, dynamic> data) {
    String createdAtFormatted = DateFormat.yMMMd()
        .add_jm()
        .format(DateTime.fromMillisecondsSinceEpoch(data['created_at'] * 1000));

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Successful! Here is your aduan'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Text('--- Aduan Details ---',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              const SizedBox(height: 10),
              _buildReceiptRow('Title:', data['title']),
              _buildReceiptRow('Content:', data['content']),
              _buildReceiptRow('Status:', 'Terima'),
              _buildReceiptRow('Created At:', createdAtFormatted),
              const Divider(),
              Center(
                  child: Text('--- Thank You ---',
                      style: TextStyle(fontWeight: FontWeight.bold))),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context, 
                  MaterialPageRoute(builder: (context) => const HomePage(),), 
                  (Route<dynamic> route) => false);
                // Navigate back to HomePage
                // Navigator.of(context).pushReplacement(
                //   MaterialPageRoute(
                //     builder: (context) =>
                //         const HomePage(), // Assuming HomePage is in the same file or imported
                //   ),
                // );
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildReceiptRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 30),
        Flexible(
          child: Text(
            value,
            overflow: TextOverflow.visible, 
            // maxLines: 10,
            softWrap: true,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: 'Maklum Balas Baharu'),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _tajuk,
                    decoration: InputDecoration(
                      label: const Row(
                        children: [
                          FaIcon(FontAwesomeIcons.book, color: Colors.grey),
                          SizedBox(width: 20),
                          Text('Tajuk',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey)),
                        ],
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Sila masukkan Tajuk';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _butiran,
                    maxLines: 3,
                    decoration: InputDecoration(
                      label: const Row(
                        children: [
                          FaIcon(FontAwesomeIcons.edit, color: Colors.grey),
                          SizedBox(width: 20),
                          Text('Butiran',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey)),
                        ],
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Sila masukkan butiran';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.blue[900],
                      backgroundColor: Colors.white,
                    ),
                    onPressed: _isSubmitting ? null : submitAduanForm,
                    child: const Text('Hantar', style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
