import 'dart:convert';
import 'package:rra_mobile/services/allAduanService.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>?> loadMyAduanStatus() async {
    final token = await storage.read(key: "token");
    final uri = Uri.parse('https://api-aduan.safwanzarif.dev/api/aduan/stat');

    try {
      final res = await http.get(uri, headers: <String, String>{
        'Authorization': 'Bearer $token',
      });
      if (res.statusCode == 200) {
        print('load status success');
        return jsonDecode(res.body) as Map<String, dynamic>;
      } else (
        print('Failed load status')
      );
    } catch (e) {
      print('Error: $e');
      return null;
    }
    return null;
  }