import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AduanDetailService {
  final String baseUrl = 'https://backend-aduan.amiersiddiq.com/api/aduan';
  final storage = const FlutterSecureStorage();

  Future<Map<String, dynamic>?> fetchAduanDetail(String aduanId) async {
    String? token = await storage.read(key: 'token');
    String? roleId = await storage.read(key: 'roleId'); // Retrieve the role

    if (token == null || roleId == null) {
      throw Exception('User is not authenticated');
    }

    try {
      // Determine the API endpoint based on the user's role
      String url = (roleId == '2')
          ? '$baseUrl/aduanDetail-Pegawai/$aduanId'
          : '$baseUrl/my/$aduanId';

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        // Handle all error cases in a generic way
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
    String? roleId = await storage.read(key: 'roleId'); // Retrieve the roleId

    if (token == null || roleId == null) {
      throw Exception('User is not authenticated');
    }

    try {
      String url;

      if (roleId == '3') {
        // For Pengadu (roleId = 3), use the cancel endpoint
        url = '$baseUrl/cancel/$aduanId';
      } else if (roleId == '2') {
        // For Pegawai (roleId = 2), use the tolak endpoint
        url = '$baseUrl/pegawai/tolak/$aduanId';
      } else {
        throw Exception('Unauthorized role');
      }

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
        print('Failed to process aduan: ${response.reasonPhrase}');
        return false;
      }
    } catch (e) {
      print('Error processing aduan: $e');
      return false;
    }
  }

  Future<bool> selesaikanAduan(String aduanId, String hasil) async {
    String? token = await storage.read(key: 'token');
    String? roleId = await storage.read(key: 'roleId');

    if (token == null || roleId == null) {
      throw Exception('User is not authenticated');
    }

    try {
      String url = '$baseUrl/pegawai/selesai/$aduanId';

      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'hasil': hasil}),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Failed to complete aduan: ${response.reasonPhrase}');
        return false;
      }
    } catch (e) {
      print('Error completing aduan: $e');
      return false;
    }
  }

  Future<bool> terimaAduan(String aduanId) async {
    String? token = await storage.read(key: 'token');
    String? roleId = await storage.read(key: 'roleId');

    if (token == null || roleId == null) {
      throw Exception('User is not authenticated');
    }

    try {
      String url = '$baseUrl/pegawai/terima/$aduanId';

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
        print('Failed to terima aduan: ${response.reasonPhrase}');
        return false;
      }
    } catch (e) {
      print('Error terima aduan: $e');
      return false;
    }
  }
}
