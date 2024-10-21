
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Profile {
  final int id;
  final String name;
  final String id_no;
  final String email;

  Profile({
    required this.id,
    required this.name,
    required this.id_no,
    required this.email,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'], 
      name: json['name'], 
      id_no: json['id_no'], 
      email: json['email'], 
      );
  }
}

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


class ProfileResponse {
  final Profile profile;
  final List<Aduan> results;
  final int total;

  ProfileResponse({
    required this.profile,
    required this.results,
    required this.total,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    var resultsJson = json['aduan']['results'] as List;
    List<Aduan> resultsList = resultsJson.map((e) => Aduan.fromJson(e),).toList();
    return ProfileResponse(profile: Profile.fromJson(json['profile']), results: resultsList, total: json['aduan']['total']); 
  }
}

const storage = FlutterSecureStorage();

Future<ProfileResponse?> fetchProfile(int id) async {
  final token = await storage.read(key: 'token');
  final uri = Uri.http(
    'https://api-aduan.safwanzarif.dev',
    '/api/pengguna/$id',
  );

  final res = await http.get(
    uri,
    headers:  <String, String> {
       'Authorization': 'Bearer $token',
    }
  );

  if (res.statusCode == 200) {
    print('Profile service success + Id: $id');
    print('Response Body: ${jsonDecode(res.body)}');
    return ProfileResponse.fromJson(jsonDecode(res.body));
  } else {
    print('Failed to fetch profileService');
    return null;
  }
}