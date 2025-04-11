import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class UpdateProfile {
  final String _url = 'https://backend-aduan.amiersiddiq.com/api/profil/update';
  final storage = const FlutterSecureStorage();

  Future<Map<String, dynamic>?> updateProfileService(
      {required String name,
      required String email,
      String? idno}) async {
    final token = await storage.read(key: 'token');
    Map<String, String> body = {
      'name': name,
      'email': email,
    };

    if (idno != null && idno.isNotEmpty) {
      body['ic_no'] = idno;
    }

    final res = await http.put(Uri.parse(_url),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json', // Line wajib kalo nk hantar data
        },
        body: jsonEncode(body));

    if (res.statusCode == 200) {
      print(res.body);
      return jsonDecode(res.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to update profile: ${res.statusCode}');
    }
  }
}
