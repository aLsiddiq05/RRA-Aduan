
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class Pengguna {
  final int id;
  final String name;
  final String id_no;
  final String email;
  final int aduanCount;

  Pengguna({
    required this.id,
    required this.name,
    required this.id_no,
    required this.email,
    required this.aduanCount
  });

  factory Pengguna.fromJson(Map<String, dynamic> json) {
    return Pengguna(
      id: json['id'], 
      name: json['name'], 
      id_no: json['id_no'], 
      email: json['email'], 
      aduanCount: json['aduanCount']);
  }
}

class PenggunaResponse {
  final List<Pengguna> result;
  final int currentPage;
  final int maxPage;

  PenggunaResponse({
    required this.result,
    required this.currentPage,
    required this.maxPage
  });

  factory PenggunaResponse.fromJson(Map<String, dynamic> json){
    var list = json['result'] as List;
    List<Pengguna> penggunaList = list.map((i) => Pengguna.fromJson(i)).toList();
    return PenggunaResponse(result: penggunaList, currentPage: json['currentPage'], maxPage: json['maxPage']);
  }
}

const storage = FlutterSecureStorage();

Future<PenggunaResponse?> fetchPengguna(int page) async {
  final token = await storage.read(key: 'token');
  final uri = Uri.https(
    'api-aduan.safwanzarif.dev',
    '/api/pengguna',
     {
      'page': page.toString()
    }
  );

  final res = await http.get(
    uri,
    headers: <String, String> {
      'Authorization': 'Bearer $token',
    }
  );

  if (res.statusCode == 200) {
    return PenggunaResponse.fromJson(jsonDecode(res.body));
  } else {
    print('Failed to load pengguna' + res.statusCode.toString());
    return null;
  }
}