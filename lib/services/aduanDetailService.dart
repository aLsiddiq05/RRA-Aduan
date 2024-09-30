import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AduanDetailService {
  final String baseUrl = 'http://localhost:3000/api/aduan';
  final storage = FlutterSecureStorage();

  Future<Map<String, dynamic>?> fetchAduanDetail(String aduanId) async {
    String? token = await storage.read(key: 'token');

    if (token == null) {
      throw Exception('User is not authenticated');
    }

    try {
      String url = '$baseUrl/my/$aduanId';

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception(
            'Failed to fetch aduan details: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error fetching aduan details: $e');
      return null;
    }
  }

  Future<bool> cancelAduan(String aduanId) async {
    String? token = await storage.read(key: 'token');

    if (token == null) {
      throw Exception('User is not authenticated');
    }

    try {
      String url = '$baseUrl/cancel/$aduanId';

      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Failed to cancel aduan: ${response.reasonPhrase}');
        return false; 
      }
    } catch (e) {
      print('Error cancelling aduan: $e');
      return false; 
    }
  }
}
