import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AduanDetailService {
  final String baseUrl = 'http://localhost:3000/api/aduan';
  final storage = FlutterSecureStorage();

  Future<Map<String, dynamic>?> fetchAduanDetail(String aduanId) async {
    String? token = await storage.read(key: 'token');

    // Check if the token is null before making the request
    if (token == null) {
      throw Exception('User is not authenticated');
    }

    try {
      // Make the API request to the pengadu-specific endpoint
      String url = '$baseUrl/my/$aduanId';

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      // If the API returns a success status code, parse the response
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        // Let the API's error handling propagate back as a general exception
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

    // Check if the token is null before making the request
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

      // Check the response status code
      if (response.statusCode == 200) {
        return true; // Successfully cancelled the aduan
      } else {
        // Handle error responses
        print('Failed to cancel aduan: ${response.reasonPhrase}');
        return false; // Cancel failed
      }
    } catch (e) {
      print('Error cancelling aduan: $e');
      return false; // Cancel failed
    }
  }
}
