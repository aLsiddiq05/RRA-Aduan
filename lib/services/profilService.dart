import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProfilService {
  final String url = 'https://backend-aduan.amiersiddiq.com/api/pengguna/profil';
  final storage = const FlutterSecureStorage();

  Future<Map<String, dynamic>?> getMyProfile() async {
    try {
      // Retrieve the token from secure storage
      String? token = await storage.read(key: 'token');

      if (token == null) {
        throw Exception("No token found");
      }

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // Successfully retrieved the profile data
        return jsonDecode(response.body);
      } else {
        print('Failed to fetch profile: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching profile: $e');
      return null;
    }
  }
}
