import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;


class LoginService {
  final String url = 'http://localhost:3000/auth/login';
  final storage = const FlutterSecureStorage();

  Future<Map<String, dynamic>?> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        // Decode and return the JSON response
        final res = jsonDecode(response.body); 
        await storage.write(key: 'roleId', value: res['roleId'].toString());
        await storage.write(key: 'token', value: res['access_token']);
        return res;
      } else {
        // Handle non-201 responses
        print('Failed to login: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}