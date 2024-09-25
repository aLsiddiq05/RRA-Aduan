import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class Aduan {
  final int id;
  final String title;
  final String content;
  final int status;
  final int createdAt;

  Aduan({
    required this.id,
    required this.title,
    required this.content,
    required this.status,
    required this.createdAt,
  });

  factory Aduan.fromJson(Map<String, dynamic> json) {
    return Aduan(
        id: json['id'],
        title: json['title'],
        content: json['content'],
        status: json['status'],
        createdAt: json['created_at']);
  }
}

class AduanResponse {
  final List<Aduan> result;
  final int currentPage;
  final int maxPages;

  AduanResponse({
    required this.result,
    required this.currentPage,
    required this.maxPages,
  });

  factory AduanResponse.fromJson(Map<String, dynamic> json) {
    var list = json['result'] as List;
    List<Aduan> aduanList = list.map((i) => Aduan.fromJson(i)).toList();
    return AduanResponse(
        result: aduanList,
        currentPage: json['currentPage'],
        maxPages: json['maxPages']);
  }
}

const storage = FlutterSecureStorage();

Future<AduanResponse?> fetchAduans(int page, int status) async {
  final token = await storage.read(key: 'token');
  final uri = Uri.http(
    'localhost:3000',
    '/api/aduan/my',
    {
      'page': page.toString(), 'status': status.toString(),
    }
  );

  final res = await http.get(
    uri,
    headers: <String, String> {
       'Authorization': 'Bearer $token',
    }
    );

    if (res.statusCode == 200) {
      return AduanResponse.fromJson(jsonDecode(res.body));
    } else {
      print('Failed to load aduan');
      return null;
    }
}
