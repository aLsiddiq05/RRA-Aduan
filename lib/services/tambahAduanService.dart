import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class TambahAduanService {
  final storage = const FlutterSecureStorage();

  Future<Map<String, dynamic>?> submitAduan(String title, String content) async {
    try {
      // Retrieve the token from secure storage
      String? token = await storage.read(key: 'token');

      if (token == null) {
        throw Exception('No token found');
      }

      final response = await http.post(
        Uri.parse('http://localhost:3000/api/aduan'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Include the token in the header
        },
        body: jsonEncode({
          'title': title,
          'content': content,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Aduan submitted successfully
        return jsonDecode(response.body);
      } else {
        print('Failed to submit aduan: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
