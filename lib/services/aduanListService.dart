import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AduanListService {
  final String baseUrl = "https://backend-aduan.amiersiddiq.com/api/aduan";
  final storage = const FlutterSecureStorage();

  Future<Map<String, dynamic>> fetchAduanList(
      int currentPage, int pageSize) async {
    String? token = await storage.read(key: 'token');
    print('Token: $token');
    print(
        'URL: $baseUrl/aduanList-Pegawai?page=$currentPage&pageSize=$pageSize');

    final response = await http.get(
      Uri.parse(
          '$baseUrl/aduanList-Pegawai?page=$currentPage&pageSize=$pageSize'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Error Response: ${response.statusCode}');
      print('Response Body: ${response.body}');
      throw Exception('Failed to load aduan list');
    }
  }
}
