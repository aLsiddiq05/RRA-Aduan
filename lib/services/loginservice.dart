import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginService {
  final String url = 'http://localhost:3000/auth/login';

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

      if (response.statusCode == 201) {
        // Decode and return the JSON response
        return jsonDecode(response.body);
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